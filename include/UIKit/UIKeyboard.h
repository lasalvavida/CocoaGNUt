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

typedef enum
{
	UIKeyboardModeCharCaps,
	UIKeyboardModeCharLower,
	UIKeyboardModeSymReg,
	UIKeyboardModeSymAlt,
}
UIKeyboardMode;

@interface UIKeySpacebar : UIView
{
	NSString *display;
}
-(void)drawRect:(CGRect)rect;
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
@end

@interface UIKeyBackspace : UIView
{
	NSString *display;
}
-(void)drawRect:(CGRect)rect;
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
@end

@interface UIKeyReturn : UIView
{
	NSString *display;
}
-(void)drawRect:(CGRect)rect;
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
@end

@interface UIKeyTogglePrimary : UIView
{
	NSString *display;
}
-(void)drawRect:(CGRect)rect;
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
@end

@interface UIKeyToggleSecondary : UIView
{
	NSString *display;
}
-(void)drawRect:(CGRect)rect;
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
@end

@interface UIKey : UIView
{
	NSString *key;
}
-(void)setKey:(NSString*)string;
-(void)drawRect:(CGRect)rect;
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
@end

@interface UIKeyboard : UIView
{
	UIKeyboardMode mode;
	UIView* charKeyCaps;
	UIView* charKeyLower;
	UIView* symKeyReg;
	UIView* symKeyAlt;
	UIKeyTogglePrimary *togglePrimary;
	UIKeyToggleSecondary *toggleSecondary;
	UIView* target;
}
-(id)initKeyboard;
-(void)setMode:(UIKeyboardMode)keyMode;
-(void)drawRect:(CGRect)rect;
-(void)show;
-(void)dismiss;
@property(nonatomic) UIKeyboardMode mode;
@property(nonatomic) UIView* target;
@end
