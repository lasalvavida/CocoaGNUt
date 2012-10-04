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
#import <UIKit/UIEvent.h>
#import <UIKit/UIView.h>
#import <UIKit/UIWindow.h>

@implementation UIEvent
@synthesize timestamp;
-(id)init
{
	timestamp = get_uptime();
	return [super init];
}
-(NSSet *)allTouches
{
	return nil;
}
-(NSSet *)touchesForView:(UIView *)view
{
	return nil;
}
-(NSSet *)touchesForWindow:(UIWindow *)window
{
	return nil;
}
@end
