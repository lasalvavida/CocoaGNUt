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
#import <UIKit/UIButton.h>
#import <UIKit/UIKit.h>

@implementation UIButton
@synthesize buttonType;
@synthesize titleLabel;
+(id)buttonWithType:(UIButtonType)type
{
	UIButton *ret = [[UIButton alloc] initButton];
	ret.buttonType = type;
	return ret;
}
-(id)initButton
{
	[self initWithFrame: CGRectMake(0.0f, 0.0f, 0.0f, 0.0f)];
	init = NO;
	titles = [NSMutableArray arrayWithCapacity:6];
	int x;
	for(x=0; x<6; x++)
	{
		[titles addObject: [[UILabel alloc] init]];
	}
	return self;
}
-(void)setTitle:(NSString *)title forState:(UIControlState)controlState
{
	int num;
	if(controlState == UIControlStateNormal)
	{
		num = 0;
	}
	else if(controlState == UIControlStateHighlighted)
	{
		num = 1;
	}
	else if(controlState == UIControlStateDisabled)
	{
		num = 2;
	}
	else if(controlState == UIControlStateSelected)
	{
		num = 3;
	}
	else if(controlState == UIControlStateApplication)
	{
		num = 4;
	}
	else if(controlState == UIControlStateReserved)
	{
		num = 5;
	}
	UILabel *hold = [titles objectAtIndex:num];
	[hold initWithFrame:bounds];
	hold.backgroundColor = nil;
	hold.text = title;
	hold.textAlignment = UITextAlignmentCenter;
	
	[titles replaceObjectAtIndex:num withObject:hold];
}
-(void)setTitleColor:(UIColor *)color forState:(UIControlState)controlState
{
	int num;
	if(controlState == UIControlStateNormal)
	{
		num = 0;
	}
	else if(controlState == UIControlStateHighlighted)
	{
		num = 1;
	}
	else if(controlState == UIControlStateDisabled)
	{
		num = 2;
	}
	else if(controlState == UIControlStateSelected)
	{
		num = 3;
	}
	else if(controlState == UIControlStateApplication)
	{
		num = 4;
	}
	else if(controlState == UIControlStateReserved)
	{
		num = 5;
	}
	UILabel *hold = [titles objectAtIndex:num];
	[hold initWithFrame:bounds];
	hold.textColor = color;
	
	[titles replaceObjectAtIndex:num withObject:hold];
}
-(void)setTitleShadowColor:(UIColor *)color forState:(UIControlState)controlState
{
	int num;
	if(controlState == UIControlStateNormal)
	{
		num = 0;
	}
	else if(controlState == UIControlStateHighlighted)
	{
		num = 1;
	}
	else if(controlState == UIControlStateDisabled)
	{
		num = 2;
	}
	else if(controlState == UIControlStateSelected)
	{
		num = 3;
	}
	else if(controlState == UIControlStateApplication)
	{
		num = 4;
	}
	else if(controlState == UIControlStateReserved)
	{
		num = 5;
	}
	UILabel *hold = [titles objectAtIndex:num];
	hold.shadowColor = color;
	
	[titles replaceObjectAtIndex:num withObject:hold];
}
-(BOOL)beginTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
	[self setNeedsDisplay];
	return YES;
}
-(BOOL)continueTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
	return YES;
}
-(void)endTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
	[self setNeedsDisplay];
}
-(void)cancelTrackingWithEvent:(UIEvent*)event
{
	[self setNeedsDisplay];
}
-(void)drawRect:(CGRect)rect
{
	if(self.buttonType == UIButtonTypeCustom)
	{
		[titleLabel drawTextInRect:bounds];
	}
	else if(self.buttonType == UIButtonTypeRoundedRect)
	{
		CGContextRef ref = UIGraphicsGetCurrentContext();
		CGContextSaveGState(ref);
		CGGradientRef grad;

		CGFloat components[8];
		CGFloat locations[2];

		components[0] = 0.0;
		components[1] = .58;
		components[2] = 1.0;
		components[3] = 1.0;
		components[4] = 0.0;
		components[5] = .118;
		components[6] = .627;
		components[7] = 1.0;
		locations[0] = 0;
		locations[1] = 1.0;

		grad = CGGradientCreateWithColorComponents(CGColorSpaceCreateDeviceRGB(), components, locations, 2);

		CGContextSetRGBStrokeColor(ref, 0.0, 0.0, 0.0, 1.0);
		
		radius = 10;
		if(radius > self.bounds.size.height/2.0)
		{
			radius = self.bounds.size.height/2.0;
		}

		cairo_new_sub_path(ref);
		cairo_arc(ref, self.bounds.origin.x + self.bounds.size.width - radius, self.bounds.origin.y + radius, radius, -90 * (M_PI / 180.0), 0);
		cairo_arc(ref, self.bounds.origin.x + self.bounds.size.width - radius, self.bounds.origin.y + self.bounds.size.height - radius, radius, 0, 90 * (M_PI / 180.0));
		cairo_arc(ref, self.bounds.origin.x + radius, self.bounds.origin.y + self.bounds.size.height - radius, radius, 90 * (M_PI / 180.0), 180 * (M_PI / 180.0));
		cairo_arc(ref, self.bounds.origin.x + radius, self.bounds.origin.y + radius, radius, 180.0 * (M_PI / 180.0), 270.0 * (M_PI / 180.0));
		cairo_close_path(ref);
	
		if(self.tracking)
		{
			cairo_clip(ref);
			CGContextDrawLinearGradient(ref, grad, CGPointMake(0, 0), CGPointMake(0, self.frame.size.height), kCGGradientDrawsBeforeStartLocation);
		}
		else
		{
			cairo_set_source_rgb(ref, 1.0, 1.0, 1.0);
			cairo_fill_preserve(ref);
			cairo_set_source_rgba(ref, 0, 0, 0, 0);
			cairo_set_line_width(ref, 1.0);
			cairo_stroke(ref);
		}
		int num;
		if(state == UIControlStateNormal)
		{
			num = 0;
		}
		else if(state == UIControlStateHighlighted)
		{
			num = 1;
		}
		else if(state == UIControlStateDisabled)
		{
			num = 2;
		}
		else if(state == UIControlStateSelected)
		{
			num = 3;
		}
		else if(state == UIControlStateApplication)
		{
			num = 4;
		}
		else if(state == UIControlStateReserved)
		{
			num = 5;
		}
	
		[((UILabel*)[titles objectAtIndex: num]) drawTextInRect:bounds];
	}
	else if(self.buttonType == UIButtonTypeDetailDisclosure)
	{
		CGContextRef ref = UIGraphicsGetCurrentContext();
		CGGradientRef grad;

		CGFloat components[8];
		CGFloat locations[2];

		CGRect buttonRect = self.bounds;
		CGContextSaveGState(ref);
		CGContextAddEllipseInRect(ref, buttonRect);
		CGContextClip(ref);

		components[0] = .5;
		components[1] = .5;
		components[2] = .5;
		components[3] = 1;
		components[4] = .75;
		components[5] = .75;
		components[6] = .75;
		components[7] = 1;
		locations[0] = 0;
		locations[1] = 1;

		grad = CGGradientCreateWithColorComponents(CGColorSpaceCreateDeviceRGB(), components, locations, 2);
		
		CGContextDrawLinearGradient(ref, grad, CGPointMake(buttonRect.origin.x, 0), CGPointMake(buttonRect.origin.x, buttonRect.origin.y), kCGGradientDrawsBeforeStartLocation);

		CGContextRestoreGState(ref);
		
		buttonRect = CGRectMake(self.bounds.size.width*.05, self.bounds.size.height*.05, self.bounds.size.width*.9, self.bounds.size.height*.9);

		CGContextSetRGBFillColor(ref, 1, 1, 1, 1);
		CGContextFillEllipseInRect(ref, buttonRect);

		buttonRect = CGRectMake(self.bounds.size.width*.1, self.bounds.size.height*.1, self.bounds.size.width*.8, self.bounds.size.height*.8);
		
		CGContextSaveGState(ref);
		CGContextAddRect(ref, CGRectMake(buttonRect.origin.x, buttonRect.origin.y, buttonRect.size.width, buttonRect.size.height/2.0));
		CGContextClip(ref);

		if(self.tracking)
		{
			CGContextSetRGBFillColor(ref, .3, .5, .8, 1);
		}
		else
		{
			CGContextSetRGBFillColor(ref, .4, .6, .9, 1);
		}
		CGContextFillEllipseInRect(ref, buttonRect);
		
		CGContextRestoreGState(ref);
		CGContextSaveGState(ref);
		CGContextAddRect(ref, CGRectMake(buttonRect.origin.x, buttonRect.origin.y + buttonRect.size.height/2.0, buttonRect.size.width, buttonRect.size.height/2.0));
		CGContextClip(ref);

		if(self.tracking)
		{
			CGContextSetRGBFillColor(ref, 0, .3, .8, 1);
		}
		else
		{
			CGContextSetRGBFillColor(ref, .1, .4, .9, 1);
		}
		CGContextFillEllipseInRect(ref, buttonRect);

		CGContextRestoreGState(ref);

		CGContextSetRGBFillColor(ref, 1.0, 1.0, 1.0, 1.0);		
		CGContextMoveToPoint(ref, bounds.size.width/2.0-bounds.size.width*.09, bounds.size.height/2.0-bounds.size.width*.13);
		CGContextAddLineToPoint(ref, bounds.size.width/2.0+bounds.size.width*.11, bounds.size.height/2.0);
		CGContextAddLineToPoint(ref, bounds.size.width/2.0-bounds.size.width*.09, bounds.size.height/2.0+bounds.size.width*.13);
		CGContextStrokePath(ref);
	}
	else if(self.buttonType == UIButtonTypeInfoLight)
	{
		CGContextRef ref = UIGraphicsGetCurrentContext();

		CGRect buttonRect = CGRectMake((self.bounds.size.width/2.0)-9, (self.bounds.size.height/2.0)-9, 18, 18);
		CGContextSetRGBFillColor(ref, .85, .85, .85, 1.0);
		CGContextFillEllipseInRect(ref, buttonRect);
		
		CGContextSetRGBFillColor(ref, 0.0, 0.0, 0.0, 1.0);

		//this bit needs to be re-written to run solely through coregraphics
		cairo_text_extents_t extents;
		const char *string = "i";
		double x, y;
		cairo_select_font_face(ref, "serif", CAIRO_FONT_SLANT_OBLIQUE, CAIRO_FONT_WEIGHT_BOLD);
		cairo_set_font_size(ref, 18.0);
		cairo_text_extents(ref, string, &extents);
		x = (self.bounds.size.width/2.0)-(extents.width/2.0 + extents.x_bearing);
		y = (self.bounds.size.height/2.0)-(extents.height/2.0 + extents.y_bearing);
		cairo_move_to(ref, x, y);
		cairo_show_text(ref, string);
	}
	else if(self.buttonType == UIButtonTypeInfoDark)
	{
		CGContextRef ref = UIGraphicsGetCurrentContext();

		CGRect buttonRect = self.bounds;
		CGContextSetRGBFillColor(ref, .4, .4, .4, 1.0);
		CGContextFillEllipseInRect(ref, buttonRect);
		
		CGContextSetRGBFillColor(ref, 1.0, 1.0, 1.0, 1.0);

		//this bit needs to be re-written to run solely through coregraphics
		cairo_text_extents_t extents;
		const char *string = "i";
		double x, y;
		cairo_select_font_face(ref, "serif", CAIRO_FONT_SLANT_OBLIQUE, CAIRO_FONT_WEIGHT_BOLD);
		cairo_set_font_size(ref, self.bounds.size.height);
		cairo_text_extents(ref, string, &extents);
		x = (self.bounds.size.width/2.0)-(extents.width/2.0 + extents.x_bearing);
		y = (self.bounds.size.height/2.0)-(extents.height/2.0 + extents.y_bearing);
		cairo_move_to(ref, x, y);
		cairo_show_text(ref, string);
	}
	else if(self.buttonType == UIButtonTypeContactAdd)
	{
		CGContextRef ref = UIGraphicsGetCurrentContext();
		CGGradientRef grad;

		CGFloat components[8];
		CGFloat locations[2];

		CGRect buttonRect = self.bounds;	
		CGContextSaveGState(ref);
		CGContextAddEllipseInRect(ref, buttonRect);
		CGContextClip(ref);

		components[0] = .5;
		components[1] = .5;
		components[2] = .5;
		components[3] = 1;
		components[4] = .75;
		components[5] = .75;
		components[6] = .75;
		components[7] = 1;
		locations[0] = 0;
		locations[1] = 1;

		grad = CGGradientCreateWithColorComponents(CGColorSpaceCreateDeviceRGB(), components, locations, 2);
		
		CGContextDrawLinearGradient(ref, grad, CGPointMake(buttonRect.origin.x, 0), CGPointMake(buttonRect.origin.x, buttonRect.origin.y), kCGGradientDrawsBeforeStartLocation);

		CGContextRestoreGState(ref);
		
		buttonRect = CGRectMake(self.bounds.size.width*.05, self.bounds.size.height*.05, self.bounds.size.width*.9, self.bounds.size.height*.9);

		CGContextSetRGBFillColor(ref, 1, 1, 1, 1);
		CGContextFillEllipseInRect(ref, buttonRect);

		buttonRect = CGRectMake(self.bounds.size.width*.1, self.bounds.size.height*.1, self.bounds.size.width*.8, self.bounds.size.height*.8);
		
		CGContextSaveGState(ref);
		CGContextAddRect(ref, CGRectMake(buttonRect.origin.x, buttonRect.origin.y, buttonRect.size.width, buttonRect.size.height/2.0));
		CGContextClip(ref);

		CGContextSetRGBFillColor(ref, .4, .6, .9, 1);
		CGContextFillEllipseInRect(ref, buttonRect);
		
		CGContextRestoreGState(ref);
		CGContextSaveGState(ref);
		CGContextAddRect(ref, CGRectMake(buttonRect.origin.x, buttonRect.origin.y + buttonRect.size.height/2.0, buttonRect.size.width, buttonRect.size.height/2.0));
		CGContextClip(ref);

		if(self.tracking)
		{
			CGContextSetRGBFillColor(ref, 0, .3, .8, 1);
		}
		else
		{
			CGContextSetRGBFillColor(ref, .1, .4, .9, 1);
		}
		CGContextFillEllipseInRect(ref, buttonRect);

		CGContextRestoreGState(ref);

		CGContextSetRGBFillColor(ref, 1.0, 1.0, 1.0, 1.0);
		
		CGContextMoveToPoint(ref, bounds.size.width/2.0, bounds.size.height*.2);
		CGContextAddLineToPoint(ref, bounds.size.width/2.0, bounds.size.height*.8);
		CGContextMoveToPoint(ref, bounds.size.width*.2, bounds.size.height/2.0);
		CGContextAddLineToPoint(ref, bounds.size.width*.8, bounds.size.height/2.0);
		CGContextStrokePath(ref);
	}
}
-(void)setFrame:(CGRect)aRect
{
	[super setFrame:aRect];
	if(!init)
	{
		[self initWithFrame:aRect];
		init = YES;
	}
}
@end
