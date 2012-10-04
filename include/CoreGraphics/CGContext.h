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
#import <cairo.h>
#import <gtk/gtk.h>
#import <CoreGraphics/CGGradient.h>
#import <CoreGraphics/CGAffineTransform.h>

typedef cairo_t* CGContextRef;

enum CGBlendMode
{
	kCGBlendModeNormal,
	kCGBlendModeMultiply,
	kCGBlendModeScreen,
	kCGBlendModeOverlay,
	kCGBlendModeDarken,
	kCGBlendModeLighten,
	kCGBlendModeColorDodge,
	kCGBlendModeColorBurn,
	kCGBlendModeSoftLight,
	kCGBlendModeHardLight,
	kCGBlendModeDifference,
	kCGBlendModeExclusion,
	kCGBlendModeHue,
	kCGBlendModeSaturation,
	kCGBlendModeColor,
	kCGBlendModeLuminosity,
	kCGBlendModeClear,
	kCGBlendModeCopy,
	kCGBlendModeSourceIn,
	kCGBlendModeSourceOut,
	kCGBlendModeSourceAtop,
	kCGBlendModeDestinationOver,
	kCGBlendModeDestionationIn,
	kCGBlendModeDestinationOut,
	kCGBlendModeDestinationAtop,
	kCGBlendModeXOR,
	kCGBlendModePlusDarker,
	kCGBlendModePlusLighter
};
typedef enum CGBlendMode CGBlendMode;


enum CGPathDrawingMode
{
	kCGPathFill,
	kCGPathEOFill,
	kCGPathStroke,
	kCGPathFillStroke,
	kCGPathEOFillStroke
};
typedef enum CGPathDrawingMode CGPathDrawingMode;

enum CGTextEncoding
{
	kCGEncodingFontSpecific,
	kCGEncodingMacRoman
};
typedef enum CGTextEncoding CGTextEncoding;
void CGContextAddRect(CGContextRef c, CGRect rect);
void CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2, CGFloat radius);
void CGContextClip(CGContextRef c);
void CGContextDrawPath(CGContextRef c, CGPathDrawingMode mode);
void CGContextAddEllipseInRect(CGContextRef c, CGRect rect);
void CGContextFillEllipseInRect(CGContextRef c, CGRect rect);
void CGContextClosePath(CGContextRef c);
void CGContextSaveGState(CGContextRef c);
void CGContextRestoreGState(CGContextRef c);
void CGContextPushContext(CGRect aRect);
void CGContextPopContext();
void CGContextFlush(CGContextRef x);
void CGContextRelease(CGContextRef c);
void CGContextSetLineWidth(CGContextRef c, CGFloat width);
void CGContextSetRGBStrokeColor(CGContextRef c, CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha);
void CGContextSetRGBFillColor(CGContextRef c, CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha);
void CGContextStrokePath(CGContextRef c);
void CGContextFillPath(CGContextRef c);
void CGContextMoveToPoint(CGContextRef c, CGFloat x, CGFloat y);
void CGContextAddLineToPoint(CGContextRef c, CGFloat x, CGFloat y);
void CGContextShowText(CGContextRef c, const char *string, size_t length);
void CGContextShowTextAtPoint(CGContextRef c, CGFloat x, CGFloat y, const char *string, size_t length);
void CGContextSelectFont(CGContextRef c, const char *name, CGFloat size, CGTextEncoding textEncoding);
void CGContextDrawLinearGradient(CGContextRef c, CGGradientRef gradient, CGPoint startPoint, CGPoint endPoint, CGGradientDrawingOptions options);
void CGContextFillRect(CGContextRef c, CGRect rect);
void CGContextStrokeEllipseInRect(CGContextRef x, CGRect rect);
void CGContextTranslateCTM (CGContextRef c, CGFloat tx, CGFloat ty);
void CGContextScaleCTM(CGContextRef c, CGFloat sx, CGFloat sy);
void CGContextRotateCTM(CGContextRef c, CGFloat angle);
void CGContextConcatCTM(CGContextRef c, CGAffineTransform transform);
void CGContextSetCTM(CGContextRef c, CGAffineTransform t);
CGAffineTransform CGContextGetCTM(CGContextRef c);

