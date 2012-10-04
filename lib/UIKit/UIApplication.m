/*CocoaGNUt, an open-source implementation of iPhone's UIKit and CoreGraphics
    Copyright (C) 2012  Rob Taglang

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
#import <UIKit/UIApplication.h>
#import <UIKit/UIAnimator.h>
#import <UIKit/UIKit.h>
#import <UIKit/UITouch.h>
#import <CoreGraphics/CGGeometry.h>
#import <cairo.h>
#import <time.h>
#import <pthread.h>

int xTouch, yTouch, xPrev, yPrev;
UIStatusBar* statusBar;
int loopCounter;
BOOL init;
static int currently_drawing;
BOOL exposed = NO;
cairo_surface_t* hardSurface;

void drawCycle(UIView* view)
{
	CGContextRef ref = UIGraphicsGetCurrentContext();
	CGContextSaveGState(ref);

	if(!CGSizeEqualToSize(view.frame.size, CGSizeMake(0.0f, 0.0f)))
	{
	//start of loop

	//draw the contents into a cairo_surface if needed
	if(view.needsDisplay)
	{
		//this creates a brand new context, no transformations
		cairo_surface_destroy(view.layer);
		if(!init)
		{
			view.layer = cairo_image_surface_create(CAIRO_FORMAT_ARGB32, cairo_image_surface_get_width(view.layer), cairo_image_surface_get_height(view.layer));
		}
		else
		{
			view.layer = cairo_image_surface_create(CAIRO_FORMAT_ARGB32, view.bounds.size.width, view.bounds.size.height);
		}
		UIGraphicsPushContext(cairo_create(view.layer));
		ref = UIGraphicsGetCurrentContext();
		if(view.backgroundColor != nil)
		{	
			CGFloat* components = calloc(4, sizeof(CGFloat));
			CGColorGetComponents(view.backgroundColor.CGColor, &components);
			CGContextSetRGBFillColor(ref, components[0], components[1], components[2], components[3]);
			CGContextFillRect(ref, view.bounds);
			free(components);
		}
		[view drawRect:view.frame];
		//drawing is done, reset the context
		UIGraphicsPopContext();
		ref = UIGraphicsGetCurrentContext();
		view.needsDisplay = NO;
	}

	//compare the surface size to the frame size
	float scaleX = (view.bounds.size.width)/((float)cairo_image_surface_get_width(view.layer));
	float scaleY = (view.bounds.size.height)/((float)cairo_image_surface_get_height(view.layer));

	//this is used below to make sure clip occurs correctly
	if(view.contentMode != UIViewContentModeScaleToFill && view.contentMode != UIViewContentModeScaleAspectFit && view.contentMode != UIViewContentModeScaleAspectFill)
	{
		scaleX = 1.0;
		scaleY = 1.0;
	}

	//adjust the contexts based on scaling or position
	double originX, originY, sizeW, sizeH;
	cairo_clip_extents(ref, &originX, &originY, &sizeW, &sizeH);
	//cairo_reset_clip(ref);
	if(view.contentMode == UIViewContentModeScaleToFill)
	{
		CGContextScaleCTM(ref, scaleX, scaleY);
	}
	else if(view.contentMode == UIViewContentModeScaleAspectFit)
	{
		if(scaleX < scaleY)
		{
			scaleY = scaleX;
			CGContextScaleCTM(ref, scaleX, scaleY);
		}
		else
		{
			scaleX = scaleY;
			CGContextScaleCTM(ref, scaleX, scaleY);
		}
	}
	else if(view.contentMode == UIViewContentModeScaleAspectFill)
	{
		if(scaleX < scaleY)
		{
			CGContextScaleCTM(ref, scaleY, scaleY);
		}
		else
		{
			CGContextScaleCTM(ref, scaleX, scaleX);
		}
	}
	else if(view.contentMode == UIViewContentModeRedraw)
	{
		[view setNeedsDisplay];
	}
	else if(view.contentMode == UIViewContentModeCenter)
	{
		CGContextTranslateCTM(ref, (view.bounds.size.width/2.0)-(((float)cairo_image_surface_get_width(view.layer))/2.0), (view.bounds.size.height/2.0)-(((float)cairo_image_surface_get_height(view.layer))/2.0));
	}
	else if(view.contentMode == UIViewContentModeTop)
	{
		CGContextTranslateCTM(ref, (view.bounds.size.width/2.0)-(((float)cairo_image_surface_get_width(view.layer))/2.0), 0);
	}
	else if(view.contentMode == UIViewContentModeBottom)
	{
		CGContextTranslateCTM(ref, (view.bounds.size.width/2.0)-(((float)cairo_image_surface_get_width(view.layer))/2.0), (view.bounds.size.height-((float)cairo_image_surface_get_height(view.layer))));
	}
	else if(view.contentMode == UIViewContentModeLeft)
	{
		CGContextTranslateCTM(ref, 0, (view.bounds.size.height/2.0)-(((float)cairo_image_surface_get_height(view.layer))/2.0));
	}
	else if(view.contentMode == UIViewContentModeRight)
	{
		CGContextTranslateCTM(ref, (view.bounds.size.width-((float)cairo_image_surface_get_width(view.layer))), (view.bounds.size.height/2.0)-(((float)cairo_image_surface_get_height(view.layer))/2.0));
	}
	else if(view.contentMode == UIViewContentModeTopLeft)
	{
		CGContextTranslateCTM(ref, 0, 0);
	}
	else if(view.contentMode == UIViewContentModeTopRight)
	{
		CGContextTranslateCTM(ref, (view.bounds.size.width-((float)cairo_image_surface_get_width(view.layer))), 0);
	}
	else if(view.contentMode == UIViewContentModeBottomLeft)
	{
		CGContextTranslateCTM(ref, 0, (view.bounds.size.height-((float)cairo_image_surface_get_height(view.layer))));
	}
	else if(view.contentMode == UIViewContentModeBottomRight)
	{
		CGContextTranslateCTM(ref, (view.bounds.size.width-((float)cairo_image_surface_get_width(view.layer))), (view.bounds.size.height-((float)cairo_image_surface_get_height(view.layer))));
	}

	//translate and rotate the graphics context
	//CGContextAddRect(ref, CGRectMake(originX/scaleX, originY/scaleY, sizeW/scaleX, sizeH/scaleY));
	//CGContextClip(ref);
	CGContextTranslateCTM(ref, view.center.x/scaleX, view.center.y/scaleY);
	CGAffineTransform mat = CGAffineTransformConcat(view.transform, CGContextGetCTM(ref));
	CGContextSetCTM(ref, mat);
	CGContextTranslateCTM(ref, -view.center.x/scaleX, -view.center.y/scaleY);

	CGContextTranslateCTM(ref, view.frame.origin.x/scaleX, view.frame.origin.y/scaleY);
	CGContextTranslateCTM(ref, -view.bounds.origin.x/scaleX, -view.bounds.origin.y/scaleY);
	CGContextAddRect(ref, CGRectMake(view.bounds.origin.x/scaleX, view.bounds.origin.y/scaleY, view.bounds.size.width/scaleX, view.bounds.size.height/scaleY));
	CGContextClip(ref);

	cairo_set_source_surface(ref, view.layer, 0.0, 0.0);

	cairo_paint_with_alpha(ref, view.alpha);

	}
	//start loop with subviews (recursive)
	int x;
	UIView *hold;
	for(x=0; x<[view.subviews count]; x++)
	{
		hold = [view.subviews objectAtIndex:x];
		drawCycle(hold);
	}
	//remove modifications
	CGContextRestoreGState(ref);
	return;
}
@interface DrawUpdate : NSObject
+(void)drawCallback:(id)param;
@end

@implementation DrawUpdate
+(void)drawCallback:(id)param
{
	gdk_threads_enter();
	if(exposed)
	{
		NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
		currently_drawing = 1;

		if([UIApplication sharedApplication].keyWindow != nil)
		{
			[[UIAnimator sharedAnimator] animate];
			UIGraphicsPushContext(cairo_create(hardSurface));
			CGContextRef ref = UIGraphicsGetCurrentContext();
			CGContextFillRect(ref, CGRectMake(0.0f, 0.0f, 320.0f, 480.0f));
			drawCycle([UIApplication sharedApplication].keyWindow);
			[statusBar drawRect:statusBar.frame];
			UIGraphicsPopContext();
		}
		init = YES;
		loopCounter--;

		currently_drawing = 0;
		[pool release];
	}
	gdk_flush();
	gdk_threads_leave();
}
@end

static gboolean on_expose_event(GtkWidget *widget, GdkEventExpose *event, gpointer data)
{
	UIGraphicsPushContext(gdk_cairo_create(([ [UIApplication sharedApplication] getGtkWindow])->window));
	CGContextRef ref = UIGraphicsGetCurrentContext();
	cairo_set_source_surface(ref, hardSurface, 0.0, 0.0);
	cairo_paint(ref);
	UIGraphicsPopContext();
}

gboolean clicked(GtkWidget *widget, GdkEventButton *event, gpointer user_data)
{
	xTouch = event->x;
	yTouch = event->y;

	[[UIApplication sharedApplication] touchesBegan];

	xPrev = xTouch;
	yPrev = yTouch;
    	return TRUE;
}

static gboolean motion_notify_event(GtkWidget *widget, GdkEventButton *event, gpointer user_data)
{	
	xTouch = event->x;
	yTouch = event->y;

	[[UIApplication sharedApplication] touchesMoved];

	xPrev = xTouch;
	yPrev = yTouch;
	return TRUE;
}

static gboolean button_release_event(GtkWidget *widget, GdkEventButton *event, gpointer user_data)
{
	xTouch = event->x;
	yTouch = event->y;
	
	[[UIApplication sharedApplication] touchesEnded];

	xPrev = xTouch;
	yPrev = yTouch;

	return TRUE;
}

static gboolean leave_notify_event(GtkWidget *widget, GdkEventCrossing *event, gpointer user_data)
{
	//[[UIApplication sharedApplication] touchesEnded];

	return TRUE;
}

gboolean guardian(GtkWidget* window)
{
	int drawing_status = g_atomic_int_get(&currently_drawing);
	if(drawing_status == 0)
	{
		[NSThread detachNewThreadSelector: @selector(drawCallback:) toTarget:[DrawUpdate class] withObject:nil];
	}
	gtk_widget_queue_draw_area([[UIApplication sharedApplication] getGtkWindow], 0, 0, 320, 480);

	return TRUE;
}

@implementation UIApplication
@synthesize delegate;
@synthesize keyWindow;
@synthesize windows;
@dynamic statusBarStyle;

+(UIApplication *)sharedApplication
{
	return UIApplicationGetPrincipalClass();
}

-(UIStatusBarStyle)statusBarStyle
{
	return statusBar.style;
}

-(void)setStatusBarStyle:(UIStatusBarStyle)style
{
	statusBar.style = style;
}

-(void)startApplication:(int)argc withArgs:(char**)argv;
{
	init = NO;
	statusBar = [[UIStatusBar alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 20.0f)]; 
	g_thread_init(NULL);
	gdk_threads_init();
	gtk_init(&argc, &argv);
  
	window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
 
	gtk_widget_set_events(window, GDK_BUTTON_PRESS_MASK | GDK_BUTTON_MOTION_MASK | GDK_BUTTON_RELEASE_MASK);

	g_signal_connect(window, "expose-event", G_CALLBACK(on_expose_event), NULL);
  	g_signal_connect(window, "destroy", G_CALLBACK(gtk_main_quit), NULL);
  	g_signal_connect(window, "button-press-event", G_CALLBACK(clicked), NULL);
	g_signal_connect(window, "button-release-event", G_CALLBACK(button_release_event), NULL);
	g_signal_connect(window, "motion-notify-event", G_CALLBACK(motion_notify_event), NULL);
	g_signal_connect(window, "leave-notify-event", G_CALLBACK(leave_notify_event), NULL);

	//g_idle_add_full(G_PRIORITY_HIGH_IDLE+40, drawCallBack, NULL, NULL);
	g_timeout_add(33, (GSourceFunc)guardian, window);

	gtk_widget_show_all(window);
  	gtk_window_set_title(GTK_WINDOW(window), "iPhone Emulator");
  	gtk_widget_set_usize(window, 320, 480); 
  	gtk_widget_set_app_paintable(window, TRUE);
	GdkColor color;
  	gdk_color_parse("black", &color);
 	gtk_widget_modify_bg(window, GTK_STATE_NORMAL, &color);
	gtk_window_set_resizable(GTK_WINDOW(window), FALSE);

	hardSurface = cairo_image_surface_create(CAIRO_FORMAT_ARGB32, 320.0f, 480.0f);
	UIApplication* sharedApp = [UIApplication sharedApplication];
	if(sharedApp.delegate != nil)
	{
		[sharedApp.delegate applicationDidFinishLaunching: sharedApp];
		exposed = YES;
	}

	gdk_threads_enter();
  	gtk_main();
	gdk_threads_leave();
}
-(BOOL)sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent*)event
{
	if(target == nil)
	{
		NSArray* viewStack = [UIView getViewStack];
		int x;
		for(x=0; x<[viewStack count]; x++)
		{
			if([[viewStack objectAtIndex:x] isFirstResponder])
			{
				[[viewStack objectAtIndex:x] performSelector:action withObject:sender withObject:event];
				[viewStack dealloc];
				return YES;
			}
		}
		[viewStack dealloc];
		return NO;
	}
	else
	{
		[target performSelector:action withObject:sender withObject:event];
		return YES;
	}
	return NO;
}
//all touch methods only support one finger right now
-(void)touchesBegan
{
	NSSet *touches = [NSSet set];
	UIEvent *event;
	UITouch *touch;

	touch = [[UITouch alloc] initWithLocation: CGPointMake(xTouch, yTouch) previousLocation: CGPointMake(xPrev, yPrev) phase: UITouchPhaseBegan];
	
	touches = [touches setByAddingObject:touch];
	
	[keyWindow touchesBegan:touches withEvent:event];
}
-(void)touchesMoved
{
	NSSet *touches = [NSSet set];
	UIEvent *event;
	UITouch *touch;

	touch = [[UITouch alloc] initWithLocation: CGPointMake(xTouch, yTouch) previousLocation: CGPointMake(xPrev, yPrev) phase: UITouchPhaseMoved];

	touches = [touches setByAddingObject:touch];
	
	[keyWindow touchesMoved:touches withEvent:event];
}
-(void)touchesEnded
{
	NSSet *touches = [NSSet set];
	UIEvent *event;
	UITouch *touch;

	touch = [[UITouch alloc] initWithLocation: CGPointMake(xTouch, yTouch) previousLocation: CGPointMake(xPrev, yPrev) phase: UITouchPhaseEnded];

	touches = [touches setByAddingObject:touch];
	
	[keyWindow touchesEnded:touches withEvent:event];
}
-(GtkWidget *)getGtkWindow
{
	return window;
}
@end


