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
#import <CoreGraphics/CGImage.h>

CGImageRef CGImageCreate(size_t width, size_t height, size_t bitsPerComponent, size_t bitsPerPixel, size_t bytesPerRow, CGColorSpaceRef colorspace, CGBitmapInfo bitmapInfo, CGDataProviderRef provider, const CGFloat decode[], bool shouldInterpolate, CGColorRenderingIntent intent)
{
	//no support for colorspaces, bitmapinfo, decode, interpolation, or intent; I need a little more practice with image manipulation
	cairo_format_t format;

	if(bitsPerComponent == 8)
	{
		if(bitsPerPixel == 8)
		{
			format = CAIRO_FORMAT_A8;
		}
		else
		{
			format = CAIRO_FORMAT_ARGB32;
		}
	}
	else if(bitsPerComponent == 1)
	{
		format = CAIRO_FORMAT_A1;
	}
	else
	{
		format = CAIRO_FORMAT_INVALID;
	}
	cairo_surface_t* surface = cairo_image_surface_create_for_data(provider.data, format, width, height, bytesPerRow);

	return surface;
}

CGImageRef CGImageCreateCopy(CGImageRef image)
{
	return cairo_image_surface_create_for_data(cairo_image_surface_get_data(image), cairo_image_surface_get_format(image), cairo_image_surface_get_width(image), cairo_image_surface_get_height(image), cairo_image_surface_get_stride(image));
}

CGImageRef CGImageCreateWithJPEGDataProvider(CGDataProviderRef source, const CGFloat decode[], bool shouldInterpolate, CGColorRenderingIntent intent)
{
}

CGImageRef CGImageCreateWithPNGDataProvider(CGDataProviderRef source, const CGFloat decode[], bool shouldInterpolate, CGColorRenderingIntent intent)
{
	char name[L_tmpnam];
	mkstemp(name);
	FILE *file = fopen(name, "r");
	fwrite(source.data, 1, sizeof(source.data), file);
	
	cairo_surface_t* surface = cairo_image_surface_create_from_png(name);
	fclose(file);
	remove(name);
	return surface;
}

size_t CGImageGetHeight(CGImageRef image)
{
	return cairo_image_surface_get_height(image);
}

size_t CGImageGetWidth(CGImageRef image)
{
	return cairo_image_surface_get_width(image);
}
