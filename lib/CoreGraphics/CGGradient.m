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
#import <CoreGraphics/CGGradient.h>
#import <Foundation/NSArray.h>

CGGradientRef CGGradientCreateWithColorComponents(CGColorSpaceRef space, const CGFloat components[], const CGFloat locations[], size_t count)
{
	CGColorRef colors[count];
	int x;
	int y;
	CGFloat colorInit[CGColorSpaceGetColorTableCount(space)+1];
	for(x=0; x<count; x++)
	{
		for(y=0; y<CGColorSpaceGetColorTableCount(space)+1; y++)
		{
			colorInit[y] = components[y+x*(CGColorSpaceGetColorTableCount(space)+1)];
		}
		colors[x] = CGColorCreate(space, colorInit);
	}

	NSArray* colorArray = [NSArray arrayWithObjects:colors count:count];

	return [[NSGradient alloc]initWithColors:colorArray atLocations:locations colorSpace:space];
}

CGGradientRef CGGradientCreateWithColors(CGColorSpaceRef space, CFArrayRef colors, const CGFloat locations[])
{
	return [[NSGradient alloc]initWithColors:((NSArray*)colors) atLocations:locations colorSpace:space];
}

CGColorSpaceRef CGGradientGetColorSpace(CGGradientRef ref)
{
	return [ref colorSpace];
}

int CGGradientGetNumberOfColorStops(CGGradientRef ref)
{
	return [ref numberOfColorStops];
}

CGColorRef CGGradientGetColorAtIndex(CGGradientRef c, int index)
{
	CGColorRef color;
	[c getColor:&color location:NULL atIndex:index];
	return color;
}

CGFloat CGGradientGetLocationAtIndex(CGGradientRef c, int index)
{
	CGColorRef color = nil;
	CGFloat location;
	[c getColor:&color location:&location atIndex:index];
	return location;
}

void CGGradientRelease(CGGradientRef gradient)
{
	[gradient release];
}

void CGGradientRetain(CGGradientRef gradient)
{
	[gradient retain];
}


