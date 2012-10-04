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
#import <UIKit/UIColor.h>
#import <CoreGraphics/CGColorSpace.h>
#import <math.h>

void hsv_to_rgb(CGFloat* inputComponents, CGFloat* outputComponents)
{
	CGFloat h = inputComponents[0];
	CGFloat s = inputComponents[1];
	CGFloat v = inputComponents[2];

	CGFloat H = h;
	while(H < 0)
	{
		H+=360;
	}
	while(H >= 360)
	{
		H-=360;
	}
	if(v <= 0)
	{
		outputComponents[0] = outputComponents[1] = outputComponents[2] = 0;
	}
	else if(s <= 0)
	{
		outputComponents[0] = outputComponents[1] = outputComponents[2] = v;
	}
	else
	{
		CGFloat hf = H / 60.0;
		int i = (int)floor(hf);
		CGFloat f = hf-i;
		CGFloat pv = v * (1-s);
		CGFloat qv = v * (1-s*f);
		CGFloat tv = v * (1-s*(1-f));
		switch(i)
		{
			case 0:
				outputComponents[0] = v;
				outputComponents[1] = tv;
				outputComponents[2] =  pv;
				break;
			case 1:
				outputComponents[0] = qv;
				outputComponents[1] = v;
				outputComponents[2] = pv;
				break;
			case 2:
				outputComponents[0] = pv; 
				outputComponents[1] = v;
				outputComponents[2] = tv;
				break;
			case 3:
				outputComponents[0] = pv;
				outputComponents[1] = qv;
				outputComponents[2] = v;
				break;
			case 4:
				outputComponents[0] = tv;
				outputComponents[1] = pv;
				outputComponents[2] = v;
				break;
			case 5:
				outputComponents[0] = v; 
				outputComponents[1] = pv;
				outputComponents[2] = qv;
				break;
			case 6:
				outputComponents[0] = v;
				outputComponents[1] = tv;
				outputComponents[2] = pv;
				break;
			case -1:
				outputComponents[0] = v;
				outputComponents[1] = pv;
				outputComponents[2] = qv;
				break;
			default:
				outputComponents[0] = outputComponents[1] = outputComponents[2] = v;
				printf("There was an error in color conversion, probably fatal.");
				break;			
		}		
	}
	
}

@implementation UIColor
@synthesize CGColor;
-(id)copyWithZone:(NSZone*)zone
{
	UIColor *ret = [UIColor alloc];
	CGFloat* components = calloc(4, sizeof(CGFloat));
	CGColorGetComponents(CGColor, &components);
	ret = [ret initWithRed:components[0] green:components[1] blue:components[2] alpha:components[3]];
	return ret;
}
+(UIColor *)colorWithWhite:(CGFloat)white alpha:(CGFloat) alpha
{
	return [[UIColor alloc] initWithWhite:white alpha:alpha];
}

+(UIColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha
{
	return [[UIColor alloc] initWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}
+(UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
	return [[UIColor alloc] initWithRed:red green:green blue:blue alpha:alpha];
}

+(UIColor *)colorWithCGColor:(CGColorRef)cgColor
{
	return [[UIColor alloc] initWithCGColor:cgColor];
}

-(UIColor *)colorWithAlphaComponent:(CGFloat)alpha
{
	[self init];
	self.CGColor = CGColorCreateCopyWithAlpha(self.CGColor, alpha);
	return self;
}

-(UIColor *)initWithWhite:(CGFloat)white alpha:(CGFloat)alpha
{
	[self init];
	self.CGColor = CGColorCreateGenericGray(white, alpha);
	return self;
}

-(UIColor *)initWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha
{
	[self init];
	CGFloat *componentsIn = malloc(sizeof(CGFloat)*3);
	componentsIn[0] = hue;
	componentsIn[1] = saturation;
	componentsIn[2] = brightness;
	CGFloat *componentsOut = malloc(sizeof(CGFloat)*4);
	componentsOut[3] = alpha;
	hsv_to_rgb(componentsIn, componentsOut);
	self.CGColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), componentsOut);
	return self;
}

-(UIColor *)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
	[self init];
	self.CGColor = CGColorCreateGenericRGB(red, green, blue, alpha);
	return self;
}

-(UIColor *)initWithCGColor:(CGColorRef)cgColor
{
	[self init];
	self.CGColor = cgColor;
	return self;
}

+(UIColor *)blackColor
{
	return [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:1.0];
}

+(UIColor *)darkGrayColor
{
	return [[UIColor alloc] initWithRed:0.333 green:0.333 blue:0.333 alpha:1.0];
}

+(UIColor *)lightGrayColor
{
	return [[UIColor alloc] initWithRed:0.667 green:0.667 blue:0.667 alpha:1.0];
}

+(UIColor *)whiteColor
{
	return [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
}

+(UIColor *)grayColor
{
	return [[UIColor alloc] initWithRed:.5 green:.5 blue:.5 alpha:1.0];
}

+(UIColor *)redColor
{
	return [[UIColor alloc] initWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
}

+(UIColor *)greenColor
{
	return [[UIColor alloc] initWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
}

+(UIColor *)blueColor
{
	return [[UIColor alloc] initWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
}

+(UIColor *)cyanColor
{
	return [[UIColor alloc] initWithRed:0.0 green:1.0 blue:1.0 alpha:1.0];
}

+(UIColor *)yellowColor
{
	return [[UIColor alloc] initWithRed:1.0 green:1.0 blue:0.0 alpha:1.0];
}

+(UIColor *)magentaColor
{
	return [[UIColor alloc] initWithRed:1.0 green:0.0 blue:1.0 alpha:1.0];
}

+(UIColor *)orangeColor
{
	return [[UIColor alloc] initWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
}

+(UIColor *)purpleColor
{
	return [[UIColor alloc] initWithRed:0.5 green:0.0 blue:0.5 alpha:1.0];
}

+(UIColor *)brownColor
{
	return [[UIColor alloc] initWithRed:.60 green:.40 blue:.20 alpha:1.0];
}

+(UIColor *)clearColor
{
	return [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
}

+(UIColor *)lightTextColor
{
	return [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:.6];
}
+(UIColor *)darkTextColor
{
	return [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
}
+(UIColor *)groupTableViewBackgroundColor
{
	return [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
}
+(UIColor *)viewFlipsideBackgroundColor
{
	return [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
}
+(UIColor *)scrollViewTexturedBackgroundColor
{
	return [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
}

-(void)set
{
}

-(void)setFill
{
}

-(void)setStroke
{
}
@end
