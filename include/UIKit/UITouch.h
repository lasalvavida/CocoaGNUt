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
#import <UIKit/UIView.h>
#import <UIKit/UIWindow.h>
#import <CoreGraphics/CGGeometry.h>
#import <Foundation/Foundation.h>

typedef enum
{
	UITouchPhaseBegan,
	UITouchPhaseMoved,
	UITouchPhaseStationary,
	UITouchPhaseEnded,
	UITouchphaseCancelled,
}
UITouchPhase;

@interface UITouch : NSObject
{
	NSUInteger tapCount;
	NSTimeInterval timestamp;
	UIView *view;
	UIWindow *window;
	CGPoint location;
	CGPoint prevLocation;
	UITouchPhase phase;
}
-(id)initWithLocation:(CGPoint)point previousLocation:(CGPoint)prevPoint phase:(UITouchPhase)stage;
-(CGPoint)location;
-(CGPoint)locationInView:(UIView *)view;
-(CGPoint)previousLocationInView:(UIView *)view;
@property(nonatomic, readonly) NSUInteger tapCount;
@property(nonatomic, readonly) NSTimeInterval timestamp;
@property(nonatomic, readonly, retain) UIView *view;
@property(nonatomic, readonly, retain) UIWindow *window;
@property(nonatomic, readonly) UITouchPhase phase;
@end
