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
#import <CoreGraphics/CGImage.h>
#import <CoreGraphics/CGGeometry.h>
#import <CoreGraphics/CGContext.h>


enum UIImageOrientation
{
	UIImageOrientationUp,
	UIImageOrientationDown,
	UIImageOrientationLeft,
	UIImageOrientationRight,
	UIImageOrientationUpMirrored,
	UIImageOrientationDownMirrored,
	UIImageOrientationLeftMirrored,
	UIImageOrientationRightMirrored,
};
typedef enum UIImageOrientation UIImageOrientation;

@interface UIImage : NSObject
{
	UIImageOrientation imageOrientation;
	CGSize size;
	CGFloat scale;
	CGImageRef CGImage;
	NSInteger leftCapWidth;
	NSInteger topCapHeight;
}
+(UIImage*)imageNamed:(NSString *)name;
+(UIImage*)imageWithContentsOfFile:(NSString *)path;
+(UIImage*)imageWithData:(NSData *)data;
+(UIImage*)imageWithCGImage:(CGImageRef)cgImage;
+(UIImage*)imageWithCGImage:(CGImageRef)imageRef scale:(CGFloat)sc orientation:(UIImageOrientation)orient;
-(UIImage*)stretchableImageWithLeftCapWidth:(NSInteger)leftCapW topCapHeight:(NSInteger)topCapH;
-(id)initWithContentsOfFile:(NSString*)path;
-(id)initWithData:(NSData*)data;
-(id)initWithCGImage:(CGImageRef)cgImage;
-(id)initWithCGImage:(CGImageRef)imageRef scale:(CGFloat)scaleFactor orientation:(UIImageOrientation)orientation;
-(void)drawAtPoint:(CGPoint)point;
-(void)drawAtPoint:(CGPoint)point blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;
-(void)drawInRect:(CGRect)rect;
-(void)drawInRect:(CGRect)rect blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;
-(void)drawAsPatternInRect:(CGRect)rect;
@property(nonatomic) UIImageOrientation imageOrientation;
@property(nonatomic, readonly) CGSize size;
@property(nonatomic) CGFloat scale; //no support for iOS 4.0 yet
@property(nonatomic, readonly) CGImageRef CGImage;
@property(nonatomic, readonly) NSInteger leftCapWidth;
@property(nonatomic, readonly) NSInteger topCapHeight;
@end

