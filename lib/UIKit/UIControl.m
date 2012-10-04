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
#import <UIKit/UIControl.h>
#import <UIKit/UIApplication.h>

@implementation UIControlTarget
@synthesize target;
@synthesize action;
@synthesize events;
@end

@implementation UIControl
@synthesize state;
@synthesize enabled;
@synthesize selected;
@synthesize highlighted;
@synthesize contentVerticalAlignment;
@synthesize contentHorizontalAlignment;
@synthesize tracking;
@synthesize touchInside;

-(id)init
{
	self = [super init];
	state = UIControlStateNormal;
}
-(void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent*)event
{
	[[UIApplication sharedApplication] sendAction:action to:target from:self forEvent:event];
}
-(void)sendActionsForControlEvents:(UIControlEvents)controlEvents
{
	int x;
	for(x=0; x<[targets count]; x++)
	{
		printf("Here!\n");
		if(((UIControlTarget*)[targets objectAtIndex:x]).events & controlEvents)
		{
			printf("Here!\n");
			[self sendAction:((UIControlTarget*)[targets objectAtIndex:x]).action to:((UIControlTarget*)[targets objectAtIndex:x]).target forEvent:lastEvent];
		}	
	}
}
-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
	if(targets == nil)
	{
		targets = [NSMutableArray arrayWithCapacity:0];
	}
	UIControlTarget *hold = [UIControlTarget new];
	hold.target = target;
	hold.action = action;
	hold.events = controlEvents;
	
	[targets addObject:hold];
}
-(void)removeTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
	int x;
	for(x=0; x<[targets count]; x++)
	{
		if((((UIControlTarget*)[targets objectAtIndex:x]).target == target) && (((UIControlTarget*)[targets objectAtIndex:x]).action == action) && (((UIControlTarget*)[targets objectAtIndex:x]).events == controlEvents))
		{
			[targets removeObjectAtIndex:x];
			return;
		}
	}
}
-(NSArray*)actionsForTarget:(id)target forControlEvent:(UIControlEvents)controlEvent
{
	NSArray* arr = [NSArray array];
	int x;
	for(x=0; x<[targets count]; x++)
	{
		if((((UIControlTarget*)[targets objectAtIndex:x]).target == target) && (((UIControlTarget*)[targets objectAtIndex:x]).events == controlEvent))
		{
			arr = [arr arrayByAddingObject:NSStringFromSelector(((UIControlTarget*)[targets objectAtIndex:x]).action)];
		}
	}
	return arr;
}
-(NSSet*)allTargets
{
	NSSet* set = [NSSet set];
	int x;
	for(x=0; x<[targets count]; x++)
	{
		set = [set setByAddingObject: [targets objectAtIndex:x]];
	}
	return set;
}
-(UIControlEvents)allControlEvents
{
	int x;
	UIControlEvents controlEvents = ((UIControlTarget*)[targets objectAtIndex:0]).events;
	for(x=1; x<[targets count]; x++)
	{
		controlEvents = (controlEvents | ((UIControlTarget*)[targets objectAtIndex:x]).events);
	}
	return controlEvents;
}
-(BOOL)beginTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
	return YES;
}
-(BOOL)continueTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
	return YES;
}
-(void)endTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
}
-(void)cancelTrackingWithEvent:(UIEvent*)event
{
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	lastEvent = event;	
	shouldTrackContinuously = [self beginTrackingWithTouch: ((UITouch*)[touches anyObject]) withEvent:event];
	tracking = YES;
	[self sendActionsForControlEvents: UIControlEventTouchDown];
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	lastEvent = event;
	[self cancelTrackingWithEvent: event];
	tracking = NO;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	lastEvent = event;
	[self endTrackingWithTouch: ((UITouch*)[touches anyObject]) withEvent:event];
	tracking = NO;
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(shouldTrackContinuously)
	{
		shouldTrackContinuously = [self continueTrackingWithTouch: ((UITouch*)[touches anyObject]) withEvent:event];
		tracking = YES;
	}
}
@end
