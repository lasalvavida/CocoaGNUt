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
#import <AppKit/NSColor.h>
#import <CoreGraphics/CGGeometry.h>
#import <CoreGraphics/CGColorSpace.h>
#import <stdint.h>

typedef NSColor* CGColorRef;

CGColorRef CGColorCreate(CGColorSpaceRef colorspace, const CGFloat components[]);
CGColorRef CGColorCreateCopyWithAlpha(CGColorRef color, CGFloat alpha);
CGColorRef CGColorCreateGenericCMYK(CGFloat cyan, CGFloat magenta, CGFloat yellow, CGFloat black, CGFloat alpha);
CGColorRef CGColorCreateGenericGray(CGFloat gray, CGFloat alpha);
CGColorRef CGColorCreateGenericRGB(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha);
bool CGColorEqualToColor(CGColorRef color1, CGColorRef color2);
CGFloat CGColorGetAlpha(CGColorRef color);
CGColorSpaceRef CGColorGetColorSpace(CGColorRef color);
void CGColorGetComponents(CGColorRef color, CGFloat** arr);
size_t CGColorGetNumberOfComponents(CGColorRef color);
CGColorRef CGColorGetColorUsingColorSpace(CGColorRef color, CGColorSpaceRef space);

