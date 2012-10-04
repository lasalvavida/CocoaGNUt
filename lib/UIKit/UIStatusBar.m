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
#import <UIKit/UIStatusBar.h>
#import <cairo.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CGGradient.h>

@implementation UIStatusBar
@synthesize style;
-(id)initWithFrame:(CGRect) aRect
{
	[super initWithFrame:aRect];
	style = UIStatusBarStyleDefault;
	return self;
	
}
-(char*)getFormattedTime:(char *)clock
{
	time_t seconds = time(NULL);
	struct tm *timeinfo = localtime(&seconds);
	int hours = timeinfo->tm_hour;
	int mins = timeinfo->tm_min;
	char *timeofday;

	if(hours > 12)
	{
		hours -= 12;
		timeofday = "PM";
	}
	else
	{
		timeofday = "AM";
	}
	
	if(mins < 10)
	{
		sprintf(clock, "%d:0%d %s", hours, mins, timeofday);
	}
	else
	{
		sprintf(clock, "%d:%d %s", hours, mins, timeofday);
	}
	return clock;
}
-(void)drawRect:(CGRect)rect
{
	CGFloat components[8] = {0.9, 0.9, 0.9, 1.0, 0.75, 0.75, 0.75, 1.0};
	CGFloat locations[2] = {0.0, 1.0};
	CGPoint startPoint = CGPointMake(0.0, 0.0);
	CGPoint endPoint = CGPointMake(0.0, self.frame.size.height);

	CGContextRef ref = UIGraphicsGetCurrentContext();
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, locations, 2);
	cairo_text_extents_t extents;

	char* clock = malloc(sizeof(char)*8);
	clock = [self getFormattedTime: clock];

	cairo_text_extents(ref, clock, &extents);
	double x,y;
	x = (self.frame.size.width/2)-(extents.width/2 + extents.x_bearing);
	y = (self.frame.size.height/2)-(extents.height/2 + extents.y_bearing);

	if(self.style == UIStatusBarStyleDefault)
	{
		self.alpha = 1.0;
		CGContextSaveGState(ref);
		CGContextAddRect(ref, CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height));
		CGContextClip(ref);
		CGContextDrawLinearGradient(ref, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
		CGContextRestoreGState(ref);
	
		CGContextSetRGBStrokeColor(ref, 0.0, 0.0, 0.0, 1.0);
		CGContextSelectFont(ref, "sans-serif", 12, kCGEncodingFontSpecific);
		CGContextShowTextAtPoint(ref, x, y, clock, 4);
	}
	else if(self.style == UIStatusBarStyleBlackTranslucent)
	{
		self.alpha = 0.5;
		CGContextSetRGBStrokeColor(ref, 0.0, 0.0, 0.0, 1.0);
		CGContextFillRect(ref, CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height));
		
		CGContextSetRGBStrokeColor(ref, 0.8, 0.8, 0.8, 1.0);
		CGContextSelectFont(ref, "sans-serif", 12, kCGEncodingFontSpecific);
		CGContextShowTextAtPoint(ref, x, y, clock, 4);
	}
	else if(self.style == UIStatusBarStyleBlackOpaque)
	{
		self.alpha = 1.0;
		CGContextSetRGBStrokeColor(ref, 0.0, 0.0, 0.0, 1.0);
		CGContextFillRect(ref, CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height));

		CGContextSetRGBStrokeColor(ref, 0.8, 0.8, 0.8, 1.0);
		CGContextSelectFont(ref, "sans-serif", 12, kCGEncodingFontSpecific);
		CGContextShowTextAtPoint(ref, x, y, clock, 4);
	}

	CGContextSetRGBStrokeColor(ref, 0.4, 0.4, 0.4, 1.0);
	CGContextMoveToPoint(ref, 0, 20);
	CGContextAddLineToPoint(ref, 320, 20);
	CGContextStrokePath(ref);

	free(clock);
	CGGradientRelease(gradient);
}
@end
