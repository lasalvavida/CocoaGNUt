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
#import <CoreGraphics/CGGeometry.h>
#import <CoreGraphics/CGColorSpace.h>
#import <CoreGraphics/CGColor.h>
#import <CoreFoundation/CFArray.h>
#import <AppKit/NSGradient.h>

typedef NSGradient* CGGradientRef;

enum CGGradientDrawingOptions
{
	kCGGradientDrawsBeforeStartLocation = (1 << 0),
	kCGGradientDrawsAfterEndLocation = (1 << 1)
};
typedef enum CGGradientDrawingOptions CGGradientDrawingOptions;

CGGradientRef CGGradientCreateWithColorComponents(CGColorSpaceRef space, const CGFloat components[], const CGFloat locations[], size_t count);
CGGradientRef CGGradientCreateWithColors(CGColorSpaceRef space, CFArrayRef colors, const CGFloat locations[]);
CGColorSpaceRef CGGradientGetColorSpace(CGGradientRef ref);
int CGGradientGetNumberOfColorStops(CGGradientRef ref);
CGColorRef CGGradientGetColorAtIndex(CGGradientRef c, int index);
CGFloat CGGradientGetLocationAtIndex(CGGradientRef c, int index);
void CGGradientRelease(CGGradientRef gradient);
void CGGradientRetain(CGGradientRef gradient);

