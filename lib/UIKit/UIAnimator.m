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
#import <UIKit/UIAnimator.h>
#import <UIKit/UIKit.h>

BOOL canAnimate = YES;

@implementation UIAnimator
+(id)sharedAnimator
{
	return UIApplicationGetGlobalAnimator();
}
+(void)disableAnimation
{
	canAnimate = NO;
}
+(void)enableAnimation
{
	canAnimate = YES;
}
-(id)init
{
	self = [super init];
	animations = [NSMutableArray arrayWithCapacity:0];
	return self;
}
-(void)addAnimation:(UIAnimation *)animation
{
	int x;
	for(x=0; x<[animations count]; x++)
	{
		if(([[animations objectAtIndex: x] target] == [animation target]) && ([[animations objectAtIndex: x] class] == [animation class]))
		{
			[animations removeObjectAtIndex: x];
			x--;
		}
	}
	[animations addObject: animation];
}
-(void)addAnimations:(NSArray *)animas
{
	int x;
	for(x=0; x<[animas count]; x++)
	{
		[self addAnimation:((UIAnimation*)[animas objectAtIndex:x])];
	}
}
-(void)removeAnimationsForTarget:(id)target
{
	int x;
	for(x=0; x<[animations count]; x++)
	{
		if([((UIAnimation*)[animations objectAtIndex:x]) target] == target)
		{
			UIAnimation* hold = ((UIAnimation*)[animations objectAtIndex:x]);
			[self stopAnimation: hold];
			[animations removeObjectAtIndex:x];
			[hold dealloc];
			x--;
		}
	}
}
-(void)startAnimation:(UIAnimation *)animation
{
	[animation startAnimation];
}
-(void)startAllAnimations
{
	int x;
	for(x=0; x<[animations count]; x++)
	{
		[((UIAnimation*)[animations objectAtIndex:x]) startAnimation];
	}
}
-(void)stopAnimation:(UIAnimation *)animation
{
	[animation stopAnimation];
}
-(NSArray *)animations;
{
	return animations;
}
-(NSArray *)getAnimationsOfType:(Class)type
{
	NSArray* ret;
	int x;
	for(x=0; x<[animations count]; x++)
	{
		if([[animations objectAtIndex:x] isKindOfClass:[type class]])
		{
			ret = [ret arrayByAddingObject: [animations objectAtIndex:x]];
		}
	}
	return ret;
}
-(float)fractionForAnimation:(UIAnimation *)animation
{
	return [animation progress];
}
-(void)animate
{
	int x;
	UIAnimation *hold;
	for(x=0; x<[animations count]; x++)
	{
		hold = [animations objectAtIndex:x];
		if([hold canAnimate])
		{

			[hold setProgress: [hold progress]+(.033/[hold duration])];
			if([hold progress] > 1.0)
			{
				[hold setProgress: 1.0];
				[animations removeObject:hold];
				[hold dealloc];
			}
		}
	}
}
@end
