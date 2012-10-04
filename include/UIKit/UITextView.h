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
#import <UIKit/UIScrollView.h>
#import <UIKit/UILabel.h>

@interface UITextViewCursor : UIView
{
	CGPoint cursor;
}
@property(nonatomic) CGPoint cursor;
@end

@interface UITextView : UIScrollView
{
	UILabel *label;
	NSString* text;
	UIFont* font;
	UIColor* textColor;
	BOOL init;
	BOOL editable;
	UITextAlignment textAlignment;
	NSRange selectedRange;
	UIView *inputAccessoryView;
	UIView *inputView;
	UITouch *startTouch;
	UITextViewCursor *cursorView;
}
-(id)initWithFrame:(CGRect)aRect;
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(NSRange)coordinatesToRange:(CGPoint)point;
-(CGPoint)rangeToCoordinates:(NSRange)range;
-(BOOL)hasText;
-(void)drawRect:(CGRect)rect;
-(void)scrollRangeToVisible:(NSRange)range;
-(void)setText:(NSString *)txt;
-(void)receiveInput:(NSString*)input;
-(BOOL)resignFirstResponder;
-(BOOL)becomeFirstResponder;
@property(nonatomic, copy) NSString *text;
@property(nonatomic, retain) UIFont *font;
@property(nonatomic, retain) UIColor *textColor;
@property(nonatomic, getter=isEditable) BOOL editable;
@property(nonatomic) UITextAlignment textAlignment;
@property(nonatomic) NSRange selectedRange;
@property(readwrite, retain) UIView *inputAccessoryView;
@property(readwrite, retain) UIView *inputView;
@end
