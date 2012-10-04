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
#import <UIKit/UIKit.h>
#import <UIKit/UIView.h>
#import <UIKit/UIApplication.h>
#import <UIKit/UITouch.h>
#import <UIKit/UIAnimator.h>
#import <UIKit/UIAnimation.h>
#import <CoreGraphics/CGGeometry.h>
#import <CoreGraphics/CoreGraphics.h>
#import <cairo.h>

BOOL animating;
NSMutableArray* animationStack;

NSArray* viewStackRecursive(NSArray* arr, UIView* view)
{
	int x;
	for(x=0; x<[view.subviews count]; x++)
	{
		arr = [arr arrayByAddingObject: ((UIView*)[view.subviews objectAtIndex:x])];
		arr = viewStackRecursive(arr, [view.subviews objectAtIndex:x]);
	}
	return arr;
}

NSArray* getViewStack()
{
	NSArray* arr = [NSArray array];
	arr = [arr arrayByAddingObject: [UIApplication sharedApplication].keyWindow];
	arr = viewStackRecursive(arr, [UIApplication sharedApplication].keyWindow);
	return arr;
}

void printViewStack()
{
	NSArray* viewStack = getViewStack();
	int x;
	for(x=0; x<[viewStack count]; x++)
	{
		if(!([viewStack objectAtIndex:x] == nil))
		{
			printf("%s\n", [NSStringFromClass([[viewStack objectAtIndex:x] class]) UTF8String]);
		}
		else
		{
			printf("Null subview\n");
		}
	}
	[viewStack dealloc];
}

@implementation UIView
@synthesize touched;
@synthesize superview;
@synthesize subviews;
@dynamic frame;
@synthesize bounds;
@synthesize center;
@synthesize alpha;
@synthesize transform;
@synthesize needsDisplay;
@synthesize layer;
@synthesize contentMode;
@synthesize backgroundColor;
@synthesize isTransitioning;
@synthesize transition;
-(id)initWithFrame:(CGRect)aRect
{
	[self init];
	bounds = CGRectMake(0.0f, 0.0f, aRect.size.width, aRect.size.height);
	center = CGPointMake(aRect.origin.x + aRect.size.width/2, aRect.origin.y + aRect.size.height/2);
	superview = nil;
	firstResponder = NO;
	needsDisplay = YES;
	alpha = 1.0f;
	transform = CGAffineTransformIdentity;
	layer = cairo_image_surface_create(CAIRO_FORMAT_ARGB32, bounds.size.width, bounds.size.height);
	contentMode = UIViewContentModeScaleToFill;
	isTransitioning = NO;
	transition = [[UITransitionAnimation alloc] initWithTarget:self];
	return self;
}
-(CGRect)frame
{
	return CGRectMake(center.x - bounds.size.width/2, center.y - bounds.size.height/2, bounds.size.width, bounds.size.height);
}
/*Animated Properties*/
-(void)setFrame:(CGRect)aRect
{
	
	if(animating)
	{
		UIFrameAnimation* frameHold = [[UIFrameAnimation alloc] initWithTarget:self];
		[frameHold setStartFrame: self.frame];
		[frameHold setEndFrame: aRect];
		[[UIAnimator sharedAnimator] addAnimation:frameHold];
	}
	else
	{
		bounds = CGRectMake(bounds.origin.x, bounds.origin.y, aRect.size.width, aRect.size.height);
		center = CGPointMake(aRect.origin.x + bounds.size.width/2, aRect.origin.y + bounds.size.height/2);
	}
}
-(void)setCenter:(CGPoint)point
{	
	center = point;
	self.frame = CGRectMake(center.x - bounds.size.width/2, center.y - bounds.size.height/2, bounds.size.width, bounds.size.height);
}
-(void)setBounds:(CGRect)aRect
{
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, bounds.size.width, bounds.size.height);
	
	if(animating)
	{
		UIBoundsAnimation* boundsHold = [[UIBoundsAnimation alloc] initWithTarget:self];
		[boundsHold setStartPoint: bounds.origin];
		[boundsHold setEndPoint: aRect.origin];
		[[UIAnimator sharedAnimator] addAnimation:boundsHold];
	}
	else
	{
		bounds = aRect;
	}
}
-(void)setAlpha:(CGFloat)val
{
	if(animating)
	{
		UIAlphaAnimation* alphaHold = [[UIAlphaAnimation alloc] initWithTarget:self];
		[alphaHold setStartAlpha: alpha];
		[alphaHold setEndAlpha: val];
		[[UIAnimator sharedAnimator] addAnimation:alphaHold];
	}
	else
	{
		alpha = val;
	}
}
-(void)setTransform:(CGAffineTransform)trans
{
	if(animating)
	{
		UITransformAnimation* transHold = [[UITransformAnimation alloc] initWithTarget:self];
		[transHold setStartTransform: transform];
		[transHold setEndTransform: trans];
		[[UIAnimator sharedAnimator] addAnimation:transHold];
	}
	else
	{
		transform = trans;
	}
}
-(void)addSubview:(UIView *)view
{
	if(self.isTransitioning)
	{
		[transition setEndView:view];
	}
	else
	{
		if(subviews == nil)
		{
			subviews = [NSArray array];
		}
		subviews = [subviews arrayByAddingObject:view];
		view.superview = self;
	}
}
-(void)bringSubviewToFront:(UIView *)view
{
	NSMutableArray *temp = [NSMutableArray arrayWithCapacity:0];
	[temp  addObjectsFromArray:subviews];
	[temp removeObject:view];
	[temp addObject:view];
	subviews = [NSArray arrayWithArray:(NSArray *)temp];
	[temp release];
}
-(void)sendSubviewToBack:(UIView *)view
{
	NSMutableArray *temp = [NSMutableArray arrayWithCapacity:0];
	[temp  addObjectsFromArray:subviews];
	[temp removeObject:view];
	[temp insertObject:view atIndex:0];
	subviews = [NSArray arrayWithArray:(NSArray *)temp];
	[temp release];
}
-(void)removeFromSuperview
{
	if(superview.isTransitioning)
	{
		[superview.transition setStartView:self];
	}
	else
	{
		NSMutableArray *temp = [NSMutableArray arrayWithCapacity:0];
		[temp addObjectsFromArray:superview.subviews];
		[temp removeObject:self];
		superview.subviews = [NSArray arrayWithArray:(NSArray *)temp];
		[temp release];
	}
}
-(void)insertSubview:(UIView *)view atIndex:(NSInteger)index
{
	NSMutableArray *temp = [NSMutableArray arrayWithCapacity:0];
	[temp addObjectsFromArray: self.subviews];
	[temp insertObject:view atIndex:index];
	subviews = [NSArray arrayWithArray:(NSArray *)temp];
	[temp release];
}
-(void)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview
{
	NSMutableArray *temp = [NSMutableArray arrayWithCapacity:0];
	[temp addObjectsFromArray:subviews];
	[temp insertObject:view atIndex: [temp indexOfObject:siblingSubview]+1];
	subviews = [NSArray arrayWithArray:(NSArray *)temp];
	[temp release];
}
-(void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview
{
	NSMutableArray *temp = [NSMutableArray arrayWithCapacity:0];
	[temp addObjectsFromArray:subviews];
	[temp insertObject:view atIndex: [temp indexOfObject:siblingSubview]];
	subviews = [NSArray arrayWithArray:(NSArray *)temp];
	[temp release];
}
-(void)exchangeSubviewAtIndex:(NSInteger)index1 withSubviewAtIndex:(NSInteger)index2
{
	NSMutableArray *temp = [NSMutableArray arrayWithCapacity:0];
	[temp addObjectsFromArray:subviews];
	UIView *placeholder = [temp objectAtIndex:index1];
	[temp replaceObjectAtIndex:index1 withObject: [temp objectAtIndex:index2]];
	[temp replaceObjectAtIndex:index2 withObject: placeholder];
	subviews = [NSArray arrayWithArray:(NSArray *)temp];
	[temp release];
}
-(BOOL)isDescendantOfView:(UIView *)view
{
	return [view.subviews containsObject:self];
}
-(void)drawRect:(CGRect)rect
{
}
-(CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view
{
	CGPoint ret;
	int xDisplacement = view.frame.origin.x;
	int yDisplacement = view.frame.origin.y;

	UIView *suview = view.superview;

	while(suview != nil)
	{
		xDisplacement += suview.frame.origin.x;
		yDisplacement += suview.frame.origin.y;
		suview = suview.superview;
	}
	
	ret = CGPointMake(point.x - xDisplacement, point.y - yDisplacement);
	
	return ret;
}
-(CGRect)convertRect:(CGRect)rect fromView:(UIView *)view
{
	CGRect ret;
	int xDisplacement = view.frame.origin.x;
	int yDisplacement = view.frame.origin.y;

	UIView *suview = view.superview;

	while(suview != nil)
	{
		xDisplacement += suview.frame.origin.x;
		yDisplacement += suview.frame.origin.y;
		suview = suview.superview;
	}
	
	ret = CGRectMake(rect.origin.x + xDisplacement, rect.origin.y + yDisplacement, rect.size.width, rect.size.height);
	
	return ret;
}
-(CGRect)convertRect:(CGRect)rect toView:(UIView *)view
{
	CGRect ret;
	int xDisplacement = view.frame.origin.x;
	int yDisplacement = view.frame.origin.y;

	UIView *suview = view.superview;

	while(suview != nil)
	{
		xDisplacement += suview.frame.origin.x;
		yDisplacement += suview.frame.origin.y;
		suview = suview.superview;
	}
	
	ret = CGRectMake(rect.origin.x + xDisplacement, rect.origin.y + yDisplacement, rect.size.width, rect.size.height);
	
	return ret;
}
-(UIResponder *)nextResponder
{
	//this will return uiviewmanager once I write it
	return superview;
}
-(BOOL)isFirstResponder
{
	return firstResponder;
}
-(BOOL)canBecomeFirstResponder
{
	return YES;
}
-(BOOL)becomeFirstResponder
{
	if([self canBecomeFirstResponder])
	{
		firstResponder = YES;
		return YES;
	}
	else
	{
		return NO;
	}
}
-(BOOL)canResignFirstResponder
{
	return YES;
}
-(BOOL)resignFirstResponder
{
	firstResponder = NO;
	return YES;
}
+(NSArray*)getViewStack
{
	return getViewStack();
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UIView *ret;
	int x;

	for(x=[subviews count]-1; x>=0; x--)
	{
		if(CGRectContainsPoint(((UIView*)[subviews objectAtIndex:x]).frame, [[touches anyObject] locationInView:self]))
		{
			if([((UIView*)[subviews objectAtIndex:x]) canBecomeFirstResponder] && ![((UIView*)[subviews objectAtIndex:x]) isFirstResponder])
			{
				[((UIView*)[subviews objectAtIndex:x]) becomeFirstResponder];
			}
			if([((UIView*)[subviews objectAtIndex:x]) isFirstResponder])
			{
				((UIView*)[subviews objectAtIndex:x]).touched = YES;
				[[subviews objectAtIndex:x] touchesBegan:touches withEvent:event];
				break;
			}
		}
		if(x==0)
		{
			int num;
			for(num = [superview.subviews indexOfObject:self]; num>0; num--)
			{
				if(CGRectContainsPoint(((UIView*)[superview.subviews objectAtIndex:num-1]).frame, [[touches anyObject] locationInView:self]))
				{
					[((UIView*)[superview.subviews objectAtIndex:num-1]) touchesBegan:touches withEvent:event];
				}
			}
		}
	}
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}
//these need to be modified to match touchesbegan, but im still not sure how to work the responder chain
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{	
	UIView *ret;
	int x;

	for(x=[subviews count]-1; x>=0; x--)
	{
		if(((UIView*)[subviews objectAtIndex:x]).touched && !CGRectContainsPoint(((UIView*)[subviews objectAtIndex:x]).frame, [[touches anyObject] locationInView:self]))
		{
			((UIView*)[subviews objectAtIndex:x]).touched = NO;
			[[subviews objectAtIndex:x] touchesEnded:touches withEvent:event];
		}
		if(CGRectContainsPoint(((UIView*)[subviews objectAtIndex:x]).frame, [[touches anyObject] locationInView:self]))
		{
			if([((UIView*)[subviews objectAtIndex:x]) canBecomeFirstResponder] && ![((UIView*)[subviews objectAtIndex:x]) isFirstResponder])
			{
				[((UIView*)[subviews objectAtIndex:x]) becomeFirstResponder];
			}
			if([((UIView*)[subviews objectAtIndex:x]) isFirstResponder])
			{
				((UIView*)[subviews objectAtIndex:x]).touched = YES;
				[[subviews objectAtIndex:x] touchesMoved:touches withEvent:event];
				break;
			}
			
		}
		if(x==0)
		{
			int num = [superview.subviews indexOfObject:self];
			if(num > 0)
			{
				[((UIView*)[superview.subviews objectAtIndex:num-1]) touchesMoved:touches withEvent:event];
			}
		}
	}
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UIView *ret;
	int x;

	for(x=[subviews count]-1; x>=0; x--)
	{
		if(CGRectContainsPoint(((UIView*)[subviews objectAtIndex:x]).frame, [[touches anyObject] locationInView:self]))
		{
			if([((UIView*)[subviews objectAtIndex:x]) canBecomeFirstResponder] && ![((UIView*)[subviews objectAtIndex:x]) isFirstResponder])
			{
				[((UIView*)[subviews objectAtIndex:x]) becomeFirstResponder];
			}
			if([((UIView*)[subviews objectAtIndex:x]) isFirstResponder])
			{
				((UIView*)[subviews objectAtIndex:x]).touched = NO;
				[[subviews objectAtIndex:x] touchesEnded:touches withEvent:event];
				break;
			}
		}
		if(x==0)
		{
			int num = [superview.subviews indexOfObject:self];
			if(num > 0)
			{
				[((UIView*)[superview.subviews objectAtIndex:num-1]) touchesEnded:touches withEvent:event];
			}
		}
	}
}
-(void)setNeedsDisplay
{
	//cairo_surface_destroy(layer);
	needsDisplay = YES;
}
-(void)receiveInput:(NSString*)input
{
}
//Other two parameters do nothing currently
+(void)beginAnimations:(NSString *)animationID context:(void *)context
{
	animating = YES;
}
+(void)setAnimationTransition:(UIViewAnimationTransition)trans forView:(UIView *)view cache:(BOOL)cache
{
	view.isTransitioning = YES;
	[view.transition setTransition:trans];
}
+(void)setAnimationDuration:(NSTimeInterval)duration
{
	NSArray* animations = [[UIAnimator sharedAnimator] animations];
	int x;
	for(x=0; x<[animations count]; x++)
	{
		[((UIAnimation*)[animations objectAtIndex:x]) setDuration:duration];
	}
}
+(void)setAnimationCurve:(UIViewAnimationCurve)curve
{
	NSArray* animations = [[UIAnimator sharedAnimator] animations];
	int x;
	for(x=0; x<[animations count]; x++)
	{
		if(curve == UIViewAnimationCurveEaseInEaseOut)
		{
			[((UIAnimation*)[animations objectAtIndex:x]) setAnimationCurve:kUIAnimationCurveEaseInEaseOut];
		}
		else if(curve == UIViewAnimationCurveEaseIn)
		{
			[((UIAnimation*)[animations objectAtIndex:x]) setAnimationCurve:kUIAnimationCurveEaseIn];
		}
		else if(curve == UIViewAnimationCurveEaseOut)
		{
			[((UIAnimation*)[animations objectAtIndex:x]) setAnimationCurve:kUIAnimationCurveEaseOut];
		}
		else if(curve == UIViewAnimationCurveLinear)
		{
			[((UIAnimation*)[animations objectAtIndex:x]) setAnimationCurve:kUIAnimationCurveLinear];
		}
	}
}
+(void)commitAnimations
{
	animating = NO;
	[[UIAnimator sharedAnimator] startAllAnimations];
}
-(void)dealloc
{
	cairo_surface_destroy(layer);
	[super dealloc];
}
@end
