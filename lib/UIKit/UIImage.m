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
#import <UIKit/UIImage.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CGDataProvider.h>
#import <CoreGraphics/CGColorSpace.h>
#import <gdk/gdk.h>

@implementation UIImage
@synthesize imageOrientation;
@synthesize size;
@synthesize scale;
@synthesize CGImage;
@synthesize leftCapWidth;
@synthesize topCapHeight;
+(UIImage*)imageNamed:(NSString *)name
{
	//look through system cache and local directory for image with that name
}
+(UIImage*)imageWithContentsOfFile:(NSString *)path
{
	return [[UIImage alloc] initWithContentsOfFile:path];
}
+(UIImage*)imageWithData:(NSData *)data
{
	return [[UIImage alloc] initWithData:data];
}
+(UIImage*)imageWithCGImage:(CGImageRef)cgImage
{
	return [[UIImage alloc] initWithCGImage:cgImage];
}
+(UIImage*)imageWithCGImage:(CGImageRef)imageRef scale:(CGFloat)sc orientation:(UIImageOrientation)orient
{
	UIImage* ret = [UIImage imageWithCGImage:imageRef];
	ret.scale = sc;
	ret.imageOrientation = orient;
	return ret;
}
-(UIImage*)stretchableImageWithLeftCapWidth:(NSInteger)leftCapW topCapHeight:(NSInteger)topCapH
{
	leftCapWidth = leftCapW;
	topCapHeight = topCapH;
	return self;
}
-(id)initWithContentsOfFile:(NSString*)path
{
	GError *gerror = NULL;
	GdkPixbuf* pixbuf = gdk_pixbuf_new_from_file([path UTF8String], &gerror);
	cairo_format_t format;
	//uncomment below to use gerror for debugging
	/*
	if(!pixbuf)d
	{
		printf("error message: %s\n", gerror->message);
		exit(1);
	}
	*/
	imageOrientation = UIImageOrientationUp;
	size = CGSizeMake(gdk_pixbuf_get_width(pixbuf), gdk_pixbuf_get_height(pixbuf));

	format = CAIRO_FORMAT_ARGB32;

	cairo_surface_t *surface = cairo_image_surface_create(format, size.width, size.height);
	CGContextRef ref = cairo_create(surface);
	gdk_cairo_set_source_pixbuf(ref, pixbuf, 0, 0);
	cairo_paint(ref);
	
	CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, cairo_image_surface_get_data(surface), cairo_image_surface_get_stride(surface)*size.height, NULL);

	CGImage = CGImageCreate(size.width, size.height, gdk_pixbuf_get_bits_per_sample(pixbuf), gdk_pixbuf_get_bits_per_sample(pixbuf)*gdk_pixbuf_get_n_channels(pixbuf), cairo_image_surface_get_stride(surface), CGColorSpaceCreateDeviceRGB(), 0, dataProvider, NULL, NULL, 0);
	leftCapWidth = 0;
	topCapHeight = 0;
	return self;
}
-(id)initWithData:(NSData*)data
{
	//this won't work until I figure out what is happening with UIImageJPEGRepresentation
	return self;
}
-(id)initWithCGImage:(CGImageRef)cgImage
{
	CGImage = cgImage;
	size = CGSizeMake(CGImageGetWidth(cgImage), CGImageGetHeight(cgImage));
	imageOrientation = UIImageOrientationUp;
	leftCapWidth = 0;
	topCapHeight = 0;
	return self;
}
-(id)initWithCGImage:(CGImageRef)imageRef scale:(CGFloat)scaleFactor orientation:(UIImageOrientation)orientation
{
	CGImage = imageRef;
	size = CGSizeMake(CGImageGetWidth(imageRef), CGImageGetHeight(imageRef));
	imageOrientation = orientation;
	scale = scaleFactor;
	leftCapWidth = 0;
	topCapHeight = 0;
	return self;
}

-(void)drawAtPoint:(CGPoint)point
{
	CGContextRef ref = UIGraphicsGetCurrentContext();
	cairo_set_source_surface(ref, CGImage, point.x, point.y);
	cairo_paint(ref);
}
-(void)drawAtPoint:(CGPoint)point blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha
{
	CGContextRef ref = UIGraphicsGetCurrentContext();
	CGContextSaveGState(ref);
	cairo_set_source_surface(ref, CGImage, point.x, point.y);

	if(imageOrientation == UIImageOrientationDown)
	{
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, 180);
		CGContextTranslateCTM(ref, -size.width * 0.5, -size.height *0.5);
	}
	if(imageOrientation == UIImageOrientationLeft)
	{
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, -90);
		CGContextTranslateCTM(ref, size.height * 0.5, size.width * 0.5);
	}
	if(imageOrientation == UIImageOrientationRight)
	{
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, 90);
		CGContextTranslateCTM(ref, size.height * 0.5, size.width * 0.5);
	}
	if(imageOrientation == UIImageOrientationUpMirrored)
	{
		CGContextConcatCTM(ref, CGAffineTransformMake(1, 0, 0, -1, 0, size.height));
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, 180);
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
	}
	if(imageOrientation == UIImageOrientationDownMirrored)
	{
		CGContextConcatCTM(ref, CGAffineTransformMake(1, 0, 0, -1, 0, size.height));
	}
	if(imageOrientation == UIImageOrientationLeftMirrored)
	{
		CGContextConcatCTM(ref, CGAffineTransformMake(1, 0, 0, -1, 0, size.height));
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, -90);
		CGContextTranslateCTM(ref, size.height * 0.5, size.width * 0.5);
	}
	if(imageOrientation == UIImageOrientationRightMirrored)
	{
		CGContextConcatCTM(ref, CGAffineTransformMake(1, 0, 0, -1, 0, size.height));
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, 90);
		CGContextTranslateCTM(ref, size.height * 0.5, size.width * 0.5);
	}

	if(blendMode == kCGBlendModeNormal)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_OVER);
	}
	if(blendMode == kCGBlendModeMultiply)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_MULTIPLY);
	}
	if(blendMode == kCGBlendModeScreen)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_SCREEN);
	}
	if(blendMode == kCGBlendModeOverlay)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_OVERLAY);
	}
	if(blendMode == kCGBlendModeDarken)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_DARKEN);
	}
	if(blendMode == kCGBlendModeLighten)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_LIGHTEN);
	}
	if(blendMode == kCGBlendModeColorDodge)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_COLOR_DODGE);
	}
	if(blendMode == kCGBlendModeColorBurn)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_COLOR_BURN);
	}
	if(blendMode == kCGBlendModeSoftLight)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_SOFT_LIGHT);
	}
	if(blendMode == kCGBlendModeHardLight)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_HARD_LIGHT);
	}
	if(blendMode == kCGBlendModeDifference)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_DIFFERENCE);
	}
	if(blendMode == kCGBlendModeExclusion)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_EXCLUSION);
	}
	if(blendMode == kCGBlendModeHue)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_HSL_HUE);
	}
	if(blendMode == kCGBlendModeSaturation)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_HSL_SATURATION);
	}
	if(blendMode == kCGBlendModeColor)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_HSL_COLOR);
	}
	if(blendMode == kCGBlendModeLuminosity)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_HSL_LUMINOSITY);
	}
	if(blendMode == kCGBlendModeClear)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_CLEAR);
	}
	if(blendMode == kCGBlendModeCopy)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_SOURCE);
	}
	if(blendMode == kCGBlendModeSourceIn)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_IN);
	}
	if(blendMode == kCGBlendModeSourceOut)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_OUT);
	}
	if(blendMode == kCGBlendModeSourceAtop)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_ATOP);
	}
	if(blendMode == kCGBlendModeDestinationOver)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_OVER);
	}
	if(blendMode == kCGBlendModeDestionationIn)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_DEST_IN);
	}
	if(blendMode == kCGBlendModeDestinationOut)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_DEST_OUT);
	}
	if(blendMode == kCGBlendModeDestinationAtop)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_DEST_ATOP);
	}
	if(blendMode == kCGBlendModeXOR)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_XOR);
	}
	if(blendMode == kCGBlendModePlusDarker)
	{
		//unsupported
		cairo_set_operator(ref, CAIRO_OPERATOR_DARKEN);
	}
	if(blendMode == kCGBlendModePlusLighter)
	{
		//unsupported
		cairo_set_operator(ref, CAIRO_OPERATOR_LIGHTEN);
	}
	cairo_paint(ref);
	CGContextRestoreGState(ref);
}
-(void)drawInRect:(CGRect)rect
{
	CGContextRef ref = UIGraphicsGetCurrentContext();
	CGContextSaveGState(ref);
	cairo_set_source_surface(ref, CGImage, rect.origin.x, rect.origin.y);
	if(imageOrientation == UIImageOrientationDown)
	{
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, 180);
		CGContextTranslateCTM(ref, -size.width * 0.5, -size.height *0.5);
	}
	if(imageOrientation == UIImageOrientationLeft)
	{
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, -90);
		CGContextTranslateCTM(ref, size.height * 0.5, size.width * 0.5);
	}
	if(imageOrientation == UIImageOrientationRight)
	{
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, 90);
		CGContextTranslateCTM(ref, size.height * 0.5, size.width * 0.5);
	}
	if(imageOrientation == UIImageOrientationUpMirrored)
	{
		CGContextConcatCTM(ref, CGAffineTransformMake(1, 0, 0, -1, 0, size.height));
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, 180);
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
	}
	if(imageOrientation == UIImageOrientationDownMirrored)
	{
		CGContextConcatCTM(ref, CGAffineTransformMake(1, 0, 0, -1, 0, size.height));
	}
	if(imageOrientation == UIImageOrientationLeftMirrored)
	{
		CGContextConcatCTM(ref, CGAffineTransformMake(1, 0, 0, -1, 0, size.height));
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, -90);
		CGContextTranslateCTM(ref, size.height * 0.5, size.width * 0.5);
	}
	if(imageOrientation == UIImageOrientationRightMirrored)
	{
		CGContextConcatCTM(ref, CGAffineTransformMake(1, 0, 0, -1, 0, size.height));
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, 90);
		CGContextTranslateCTM(ref, size.height * 0.5, size.width * 0.5);
	}

	cairo_paint(ref);
	CGContextRestoreGState(ref);
}
-(void)drawInRect:(CGRect)rect blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha
{
	CGContextRef ref = UIGraphicsGetCurrentContext();
	CGContextSaveGState(ref);
	cairo_set_source_surface(ref, CGImage, rect.origin.x, rect.origin.y);
	if(imageOrientation == UIImageOrientationDown)
	{
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, 180);
		CGContextTranslateCTM(ref, -size.width * 0.5, -size.height *0.5);
	}
	if(imageOrientation == UIImageOrientationLeft)
	{
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, -90);
		CGContextTranslateCTM(ref, size.height * 0.5, size.width * 0.5);
	}
	if(imageOrientation == UIImageOrientationRight)
	{
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, 90);
		CGContextTranslateCTM(ref, size.height * 0.5, size.width * 0.5);
	}
	if(imageOrientation == UIImageOrientationUpMirrored)
	{
		CGContextConcatCTM(ref, CGAffineTransformMake(1, 0, 0, -1, 0, size.height));
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, 180);
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
	}
	if(imageOrientation == UIImageOrientationDownMirrored)
	{
		CGContextConcatCTM(ref, CGAffineTransformMake(1, 0, 0, -1, 0, size.height));
	}
	if(imageOrientation == UIImageOrientationLeftMirrored)
	{
		CGContextConcatCTM(ref, CGAffineTransformMake(1, 0, 0, -1, 0, size.height));
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, -90);
		CGContextTranslateCTM(ref, size.height * 0.5, size.width * 0.5);
	}
	if(imageOrientation == UIImageOrientationRightMirrored)
	{
		CGContextConcatCTM(ref, CGAffineTransformMake(1, 0, 0, -1, 0, size.height));
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, 90);
		CGContextTranslateCTM(ref, size.height * 0.5, size.width * 0.5);
	}

	if(blendMode == kCGBlendModeNormal)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_OVER);
	}
	if(blendMode == kCGBlendModeMultiply)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_MULTIPLY);
	}
	if(blendMode == kCGBlendModeScreen)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_SCREEN);
	}
	if(blendMode == kCGBlendModeOverlay)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_OVERLAY);
	}
	if(blendMode == kCGBlendModeDarken)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_DARKEN);
	}
	if(blendMode == kCGBlendModeLighten)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_LIGHTEN);
	}
	if(blendMode == kCGBlendModeColorDodge)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_COLOR_DODGE);
	}
	if(blendMode == kCGBlendModeColorBurn)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_COLOR_BURN);
	}
	if(blendMode == kCGBlendModeSoftLight)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_SOFT_LIGHT);
	}
	if(blendMode == kCGBlendModeHardLight)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_HARD_LIGHT);
	}
	if(blendMode == kCGBlendModeDifference)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_DIFFERENCE);
	}
	if(blendMode == kCGBlendModeExclusion)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_EXCLUSION);
	}
	if(blendMode == kCGBlendModeHue)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_HSL_HUE);
	}
	if(blendMode == kCGBlendModeSaturation)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_HSL_SATURATION);
	}
	if(blendMode == kCGBlendModeColor)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_HSL_COLOR);
	}
	if(blendMode == kCGBlendModeLuminosity)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_HSL_LUMINOSITY);
	}
	if(blendMode == kCGBlendModeClear)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_CLEAR);
	}
	if(blendMode == kCGBlendModeCopy)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_SOURCE);
	}
	if(blendMode == kCGBlendModeSourceIn)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_IN);
	}
	if(blendMode == kCGBlendModeSourceOut)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_OUT);
	}
	if(blendMode == kCGBlendModeSourceAtop)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_ATOP);
	}
	if(blendMode == kCGBlendModeDestinationOver)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_OVER);
	}
	if(blendMode == kCGBlendModeDestionationIn)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_DEST_IN);
	}
	if(blendMode == kCGBlendModeDestinationOut)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_DEST_OUT);
	}
	if(blendMode == kCGBlendModeDestinationAtop)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_DEST_ATOP);
	}
	if(blendMode == kCGBlendModeXOR)
	{
		cairo_set_operator(ref, CAIRO_OPERATOR_XOR);
	}
	if(blendMode == kCGBlendModePlusDarker)
	{
		//unsupported
		cairo_set_operator(ref, CAIRO_OPERATOR_DARKEN);
	}
	if(blendMode == kCGBlendModePlusLighter)
	{
		//unsupported
		cairo_set_operator(ref, CAIRO_OPERATOR_LIGHTEN);
	}
	CGContextTranslateCTM(ref, rect.origin.x, rect.origin.y);
	CGContextAddRect(ref, CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height));
	CGContextClip(ref);
	cairo_paint(ref);
	CGContextRestoreGState(ref);
}
-(void)drawAsPatternInRect:(CGRect)rect
{
	CGContextRef ref = UIGraphicsGetCurrentContext();
	CGContextSaveGState(ref);
	cairo_set_source_surface(ref, CGImage, rect.origin.x, rect.origin.y);
	if(imageOrientation == UIImageOrientationDown)
	{
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, 180);
		CGContextTranslateCTM(ref, -size.width * 0.5, -size.height *0.5);
	}
	if(imageOrientation == UIImageOrientationLeft)
	{
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, -90);
		CGContextTranslateCTM(ref, size.height * 0.5, size.width * 0.5);
	}
	if(imageOrientation == UIImageOrientationRight)
	{
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, 90);
		CGContextTranslateCTM(ref, size.height * 0.5, size.width * 0.5);
	}
	if(imageOrientation == UIImageOrientationUpMirrored)
	{
		CGContextConcatCTM(ref, CGAffineTransformMake(1, 0, 0, -1, 0, size.height));
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, 180);
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
	}
	if(imageOrientation == UIImageOrientationDownMirrored)
	{
		CGContextConcatCTM(ref, CGAffineTransformMake(1, 0, 0, -1, 0, size.height));
	}
	if(imageOrientation == UIImageOrientationLeftMirrored)
	{
		CGContextConcatCTM(ref, CGAffineTransformMake(1, 0, 0, -1, 0, size.height));
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, -90);
		CGContextTranslateCTM(ref, size.height * 0.5, size.width * 0.5);
	}
	if(imageOrientation == UIImageOrientationRightMirrored)
	{
		CGContextConcatCTM(ref, CGAffineTransformMake(1, 0, 0, -1, 0, size.height));
		CGContextTranslateCTM(ref, size.width * 0.5, size.height * 0.5);
		CGContextRotateCTM(ref, 90);
		CGContextTranslateCTM(ref, size.height * 0.5, size.width * 0.5);
	}
	CGContextTranslateCTM(ref, rect.origin.x, rect.origin.y);
	CGContextAddRect(ref, CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height));
	CGContextClip(ref);

	int x;
	int y;
	for(x=0; x<(rect.size.width/size.width); x++)
	{
		cairo_paint(ref);
		for(y=0; y<(rect.size.height/size.height); y++)
		{
			cairo_paint(ref);
			CGContextTranslateCTM(ref, 0, size.height);
		}
	}
}
@end
