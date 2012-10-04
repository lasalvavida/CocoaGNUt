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
#import <UIKit/UIFont.h>

typedef enum
{
	UITextAlignmentLeft,
	UITextAlignmentCenter,
	UITextAlignmentRight,
}
UITextAlignment;

typedef enum
{
	UILineBreakModeWordWrap = 0,
	UILineBreakModeCharacterWrap,
	UILineBreakModeClip,
	UILineBreakModeHeadTruncation,
	UILineBreakModeTailTruncation,
	UILineBreakModeMiddleTruncation,
}
UILineBreakMode;

typedef enum
{
	UIBaselineAdjustmentAlignBaselines,
	UIBaselineAdjustmentAlignCenters,
	UIBaselineAdjustmentNone,
}
UIBaselineAdjustment;

@interface UILabel : UIView
{
	NSString *text;
	UIFont *font;
	UIColor *textColor;
	UITextAlignment textAlignment;
	UILineBreakMode lineBreakMode;
	BOOL enabled;
	BOOL adjustsFontSizeToFitWidth;
	UIBaselineAdjustment baselineAdjustment;
	CGFloat minimumFontSize;
	NSInteger numberOfLines;
	UIColor *highlightedTextColor;
	BOOL highlighted;
	UIColor *shadowColor;
	CGSize shadowOffset;
	BOOL userInteractionEnabled;
}
-(id)initWithFrame:(CGRect)rect;
-(void)drawRect:(CGRect)frame;
-(CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines;
-(void)drawTextInRect:(CGRect)frame;
@property(nonatomic, copy) NSString *text;
@property(nonatomic, retain) UIFont *font;
@property(nonatomic, retain) UIColor *textColor;
@property(nonatomic) UITextAlignment textAlignment;
@property(nonatomic) UILineBreakMode lineBreakMode;
@property(nonatomic, getter=isEnabled) BOOL enabled;
@property(nonatomic) BOOL adjustsFontSizeToFitWidth;
@property(nonatomic) UIBaselineAdjustment baselineAdjustment;
@property(nonatomic) NSInteger numberOfLines;
@property(nonatomic) CGFloat minimumFontSize;
@property(nonatomic, retain) UIColor *highlightedTextColor;
@property(nonatomic, getter=isHighlighted) BOOL highlighted;
@property(nonatomic, retain) UIColor *shadowColor;
@property(nonatomic) CGSize shadowOffset;
@property(nonatomic, getter=isUserInteractionEnabled) BOOL userInteractionEnabled;
@end



