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
#import <UIKit/UIKit.h>
#import <UIKit/UINavigationBar.h>
#import <UIKit/UIColor.h>

@implementation UINavigationBar
@synthesize barStyle;
@synthesize tintColor;
@synthesize translucent;
@synthesize delegate;
@synthesize items;
@dynamic topItem;
@dynamic backItem;
-(id)initWithFrame:(CGRect)rect
{
	printf("Here\n");
	self = [super initWithFrame:rect];
	tintColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.25 alpha:1.0];
	return self;
}
-(void)pushNavigationItem:(UINavigationItem *)item animated:(BOOL)animated
{
}
-(void)setTintColor:(UIColor*)color
{
}
-(UINavigationItem *)popNavigationItemAnimated:(BOOL)animated
{
}

-(void)setItems:(NSArray *)items animated:(BOOL)animated
{
}

-(void)drawRect:(CGRect)aRect
{
	CGFloat* colorComponents = calloc(4, sizeof(CGFloat));
	CGColorGetComponents(tintColor.CGColor, &colorComponents);
	CGFloat components[8] = {1.0, 1.0, 1.0, 0.75, 1.0, 1.0, 1.0, 0.5};
	CGFloat locations[2] = {0.0, 1.0};
	CGPoint startPoint = CGPointMake(0.0, 0.0);
	CGPoint endPoint = CGPointMake(0.0, self.frame.size.height/2.0);

	CGContextRef ref = UIGraphicsGetCurrentContext();
	CGContextSetRGBFillColor(ref, colorComponents[0], colorComponents[1], colorComponents[2], colorComponents[3]);
	CGContextFillRect(ref, self.bounds);
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, locations, 2);

	CGContextAddRect(ref, CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height));
	CGContextClip(ref);
	CGContextDrawLinearGradient(ref, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
	CGContextSetRGBStrokeColor(ref, 0.4, 0.4, 0.4, 1.0);
	CGContextMoveToPoint(ref, 0, bounds.size.height);
	CGContextAddLineToPoint(ref, bounds.size.width, bounds.size.height);
	CGContextStrokePath(ref);
	free(colorComponents);
}
@end
