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
#import <CoreGraphics/CGColor.h>

CGColorRef CGColorCreate(CGColorSpaceRef colorspace, const CGFloat components[])
{
	return [NSColor colorWithColorSpace:colorspace components:components count:CGColorSpaceGetColorTableCount(colorspace)+1];
}

CGColorRef CGColorCreateCopyWithAlpha(CGColorRef color, CGFloat alpha)
{
	return color;
}

CGColorRef CGColorCreateGenericCMYK(CGFloat cyan, CGFloat magenta, CGFloat yellow, CGFloat black, CGFloat alpha)
{
	return [NSColor colorWithDeviceCyan:cyan magenta:magenta yellow:yellow black:black alpha:alpha];
}

CGColorRef CGColorCreateGenericGray(CGFloat gray, CGFloat alpha)
{
	return [NSColor colorWithDeviceWhite:gray alpha:alpha];
}

CGColorRef CGColorCreateGenericRGB(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha)
{
	return [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
}

bool CGColorEqualToColor(CGColorRef color1, CGColorRef color2)
{
	if([[color1 colorSpace] colorSpaceModel] != [[color2 colorSpace] colorSpaceModel])
	{
		return 0;
	}
	CGFloat components1[[color1 numberOfComponents]];
	CGFloat components2[[color2 numberOfComponents]];
	[color1 getComponents:(CGFloat*)&components1];
	[color2 getComponents:(CGFloat*)&components2];
	int x;

	for(x=0; x<[color1 numberOfComponents]; x++)
	{
		if(components1[x] != components2[x])
		{
			return 0;
		}
	}
	return 1;
}

CGFloat CGColorGetAlpha(CGColorRef color)
{
	return [color alphaComponent];
}

CGColorSpaceRef CGColorGetColorSpace(CGColorRef color)
{
	return [color colorSpace];
}

void CGColorGetComponents(CGColorRef color, CGFloat** arr)
{
	[color getComponents:*arr];
}

size_t CGColorGetNumberOfComponents(CGColorRef color)
{
	return [color numberOfComponents];
}

CGColorRef CGColorGetColorUsingColorSpace(CGColorRef color, CGColorSpaceRef space)
{
	return [color colorUsingColorSpace:space];
}


