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
#import <gdk/gdk.h>
#import <CoreGraphics/CGDataProvider.h>
#import <CoreGraphics/CGColorSpace.h>

typedef cairo_surface_t* CGImageRef;

enum
{
	kCGBitmapAlphaInfoMask = 0x1F,
	kCGBitmapFloatComponents = (1 << 8),
	kCGBitmapByteOrderMask = 0x7000,
	kCGBitmapByteOrderDefault = (0 << 12),
	kCGBitmapByteOrder16Little = (1 << 12),
	kCGBitmapByteOrder32Little = (2 << 12),
	kCGBitmapByteOrder16Big = (3 << 12),
	kCGBitmapByteOrder32Big = (4 << 12)
};
typedef uint32_t CGBitmapInfo;

CGImageRef CGImageCreate(size_t width, size_t height, size_t bitsPerComponent, size_t bitsPerPixel, size_t bytesPerRow, CGColorSpaceRef colorspace, CGBitmapInfo bitmapInfo, CGDataProviderRef provider, const CGFloat decode[], bool shouldInterpolate, CGColorRenderingIntent intent);
CGImageRef CGImageCreateCopy(CGImageRef image);
CGImageRef CGImageCreateWithJPEGDataProvider(CGDataProviderRef source, const CGFloat decode[], bool shouldInterpolate, CGColorRenderingIntent intent);
CGImageRef CGImageCreateWithPNGDataProvider(CGDataProviderRef source, const CGFloat decode[], bool shouldInterpolate, CGColorRenderingIntent intent);
size_t CGImageGetHeight(CGImageRef image);
size_t CGImageGetWidth(CGImageRef image);
