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
#import <CoreGraphics/CGContext.h>
#import <CoreGraphics/CGGeometry.h>
#import <UIKit/UIImage.h>

@interface UIColor : NSObject
{
	CGColorRef CGColor;
}
-(id)copyWithZone:(NSZone*)zone;
+(UIColor *)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha;
+(UIColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha;
+(UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+(UIColor *)colorWithCGColor:(CGColorRef)cgColor;
-(UIColor *)colorWithAlphaComponent:(CGFloat)alpha;
-(UIColor *)initWithWhite:(CGFloat)white alpha:(CGFloat)alpha;
-(UIColor *)initWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha;
-(UIColor *)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
-(UIColor *)initWithCGColor:(CGColorRef)cgColor;
+(UIColor *)blackColor;
+(UIColor *)darkGrayColor;
+(UIColor *)lightGrayColor;
+(UIColor *)whiteColor;
+(UIColor *)grayColor;
+(UIColor *)redColor;
+(UIColor *)greenColor;
+(UIColor *)blueColor;
+(UIColor *)cyanColor;
+(UIColor *)yellowColor;
+(UIColor *)magentaColor;
+(UIColor *)orangeColor;
+(UIColor *)purpleColor;
+(UIColor *)brownColor;
+(UIColor *)clearColor;
+(UIColor *)lightTextColor;
+(UIColor *)darkTextColor;
+(UIColor *)groupTableViewBackgroundColor;
+(UIColor *)viewFlipsideBackgroundColor;
+(UIColor *)scrollViewTexturedBackgroundColor;
-(void)set;
-(void)setFill;
-(void)setStroke;
@property(nonatomic)CGColorRef CGColor;
@end









