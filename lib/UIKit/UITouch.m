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
#import <UIKit/UITouch.h>
#import <UIKit/UIKit.h>

@implementation UITouch
@dynamic view;
@dynamic window;
@synthesize tapCount;
@synthesize timestamp;
@synthesize phase;
-(id)initWithLocation:(CGPoint)point previousLocation:(CGPoint)prevPoint phase:(UITouchPhase)stage 
{
	location = point;
	prevLocation = prevPoint;
	phase = stage;
	timestamp = get_uptime();
	
	return [self init];
}
-(CGPoint)location
{
	return location;
}
-(CGPoint)locationInView:(UIView *)view;
{
	return [view convertPoint:location toView:view];
}
-(CGPoint)previousLocationInView:(UIView *)view
{
	return [view convertPoint:prevLocation toView:view];
}
-(UIView*)view
{
	UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
	UIView *ret;
	int x;
	for(x=0; x<[[keyWindow subviews] count]; x++)
	{
		if(CGRectContainsPoint(((UIView*)[[keyWindow subviews] objectAtIndex:x]).frame, CGPointMake(location.x+keyWindow.frame.origin.x, location.y+keyWindow.frame.origin.y)))
		{
			ret = [[keyWindow subviews] objectAtIndex:x];
			break;
		} 
	}
	return ret;
}
-(UIWindow*)window
{
	return [UIApplication sharedApplication].keyWindow;
}
@end

