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
#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>
#import <pango-1.0/pango/pangocairo.h>

@interface UIFont : NSObject
{
	NSString *familyName;
	NSString *fontName;
	CGFloat pointSize;
	CGFloat ascender;
	CGFloat descender;
	CGFloat capHeight;
	CGFloat xHeight;
	CGFloat lineHeight;
	CGFloat leading;
}
+(UIFont*)fontWithName:(NSString*)fontName size:(CGFloat)fontSize;
-(id)initWithName:(NSString*)name andSize:(CGFloat)size;
-(UIFont*)fontWithSize:(CGFloat)size;
+(UIFont*)systemFontOfSize:(CGFloat)fontSize;
+(UIFont*)boldSystemFontOfSize:(CGFloat)fontSize;
+(UIFont*)italicSystemFontOfSize:(CGFloat)fontSize;
+(NSArray*)familyNames;
+(NSArray*)fontNamesForFamilyName:(NSString*)familyName;
+(CGFloat)labelFontSize;
+(CGFloat)buttonFontSize;
+(CGFloat)smallSystemFontSize;
+(CGFloat)systemFontSize;
@property(nonatomic) NSString *familyName;
@property(nonatomic) NSString *fontName;
@property(nonatomic, readonly) CGFloat pointSize;
@property(nonatomic, readonly) CGFloat ascender;
@property(nonatomic, readonly) CGFloat descender;
@property(nonatomic, readonly) CGFloat capHeight;
@property(nonatomic, readonly) CGFloat xHeight;
@property(nonatomic, readonly) CGFloat lineHeight;
@property(nonatomic, readonly) CGFloat leading; /*deprecated*/
@end










