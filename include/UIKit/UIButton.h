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
#import <UIKit/UILabel.h>

typedef enum
{
	UIButtonTypeCustom = 0,
	UIButtonTypeRoundedRect,
	UIButtonTypeDetailDisclosure,
	UIButtonTypeInfoLight,
	UIButtonTypeInfoDark,
	UIButtonTypeContactAdd,
}
UIButtonType;

@interface UIButton : UIControl
{
	UILabel* titleLabel;
	UIButtonType buttonType;
	int radius;
	BOOL init;
	NSMutableArray* titles;
}
+(id)buttonWithType:(UIButtonType)type;
-(id)initButton;
-(void)setTitle:(NSString *)title forState:(UIControlState)controlState;
-(void)setTitleColor:(UIColor *)color forState:(UIControlState)controlState;
-(void)setTitleShadowColor:(UIColor *)color forState:(UIControlState)controlState;
-(BOOL)beginTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event;
-(BOOL)continueTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event;
-(void)endTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event;
-(void)cancelTrackingWithEvent:(UIEvent*)event;
-(void)drawRect:(CGRect)rect;
-(void)setFrame:(CGRect)aRect;
@property(nonatomic) UIButtonType buttonType;
@property(nonatomic, readonly) UILabel* titleLabel;
@end
