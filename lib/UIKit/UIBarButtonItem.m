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
#import <UIKit/UIBarButtonItem.h>
#import <UIKit/UIImage.h>
#import <UIKit/UIImageView.h>
#import <UIKit/UIButton.h>

@implementation UIBarButtonItem
@synthesize target;
@synthesize action;
@synthesize itemStyle;
@synthesize possibleTitles;
@synthesize width;
@synthesize tintColor;
@synthesize drawView;
-(id)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem target:(id)tar action:(SEL)act
{
	item = systemItem;
	target = tar;
	action = act;

	return self;
}
-(id)initWithCustomView:(UIView *)customView
{
	drawView = customView;
	item = -1;
	return self;
}
-(id)initWithImage:(UIImage *)img style:(UIBarButtonItemStyle)style target:(id)tar action:(SEL)act
{
	drawView = [[UIImageView alloc] initWithImage:img];
	item = -1;
	//if too big, resize image
	itemStyle = style;
	target = tar;
	action = act;
	return self;	
} 
-(id)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)tar action:(SEL)act
{
	/*
	drawView = [[UIButton buttonWithType: UIButtonTypeRoundedRect] setTitle:title forState:UIControlStateNormal];
	item = -1;
	//set button text
	itemStyle = style;
	target = tar;
	action = act;
	*/
	return self;	
}
-(id)initWithImage:(UIImage *)img landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style target:(id)tar action:(SEL)act
{
	drawView = [[UIImageView alloc] initWithImage:img];
	item = -1;
	landscapeDrawView = [[UIImageView alloc] initWithImage:landscapeImagePhone];
	itemStyle = style;
	target = tar;
	action = act;
	return self;
}
-(void)drawRect:(CGRect)rect
{
	/*
	if(item != -1)
	{
		if(item == UIBarButtonSystemItemDone)
		{
			const CGFloat* colorComponents = CGColorGetComponents(tintColor.CGColor);
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

			cairo_text_extents_t extents;
			cairo_text_extents(ref, "Done", &extents);
			double x,y;
			x = (self.frame.size.width/2)-(extents.width/2 + extents.x_bearing);
			y = (self.frame.size.height/2)-(extents.height/2 + extents.y_bearing);
			CGContextSetRGBStrokeColor(ref, 0.0, 0.0, 0.0, 1.0);
			CGContextSelectFont(ref, "sans-serif", 12, kCGEncodingFontSpecific);
			CGContextShowTextAtPoint(ref, x, y, clock, 4);
		}
		if(item == UIBarButtonSystemItemCancel)
		{
			const CGFloat* colorComponents = CGColorGetComponents(tintColor.CGColor);
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

			cairo_text_extents_t extents;
			cairo_text_extents(ref, "Cancel", &extents);
			double x,y;
			x = (self.frame.size.width/2)-(extents.width/2 + extents.x_bearing);
			y = (self.frame.size.height/2)-(extents.height/2 + extents.y_bearing);
			CGContextSetRGBStrokeColor(ref, 0.0, 0.0, 0.0, 1.0);
			CGContextSelectFont(ref, "sans-serif", 12, kCGEncodingFontSpecific);
			CGContextShowTextAtPoint(ref, x, y, clock, 4);
		}
		if(item == UIBarButtonSystemItemEdit)
		{
			const CGFloat* colorComponents = CGColorGetComponents(tintColor.CGColor);
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

			cairo_text_extents_t extents;
			cairo_text_extents(ref, "Edit", &extents);
			double x,y;
			x = (self.frame.size.width/2)-(extents.width/2 + extents.x_bearing);
			y = (self.frame.size.height/2)-(extents.height/2 + extents.y_bearing);
			CGContextSetRGBStrokeColor(ref, 0.0, 0.0, 0.0, 1.0);
			CGContextSelectFont(ref, "sans-serif", 12, kCGEncodingFontSpecific);
			CGContextShowTextAtPoint(ref, x, y, clock, 4);
		}
		if(item == UIBarButtonSystemItemSave)
		{
			const CGFloat* colorComponents = CGColorGetComponents(tintColor.CGColor);
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

			cairo_text_extents_t extents;
			cairo_text_extents(ref, "Save", &extents);
			double x,y;
			x = (self.frame.size.width/2)-(extents.width/2 + extents.x_bearing);
			y = (self.frame.size.height/2)-(extents.height/2 + extents.y_bearing);
			CGContextSetRGBStrokeColor(ref, 0.0, 0.0, 0.0, 1.0);
			CGContextSelectFont(ref, "sans-serif", 12, kCGEncodingFontSpecific);
			CGContextShowTextAtPoint(ref, x, y, clock, 4);
		}
		if(item == UIBarButtonSystemItemAdd)
		{
		}
		if(item == UIBarButtonSystemItemFlexibleSpace)
		{
		}
		if(item == UIBarButtonSystemItemFixedSpace)
		{
		}
		if(item == UIBarButtonSystemItemCompose)
		{
		}
		if(item == UIBarButtonSystemItemReply)
		{
		}
		if(item == UIBarButtonSystemItemAction)
		{
		}
		if(item == UIBarButtonSystemItemOrganize)
		{
		}
		if(item == UIBarButtonSystemItemBookmarks)
		{
		}
		if(item == UIBarButtonSystemItemSearch)
		{
		}
		if(item == UIBarButtonSystemItemRefresh)
		{
		}
		if(item == UIBarButtonSystemItemStop)
		{
		}
		if(item == UIBarButtonSystemItemCamera)
		{
		}
		if(item == UIBarButtonSystemItemTrash)
		{
		}
		if(item == UIBarButtonSystemItemPlay)
		{
		}
		if(item == UIBarButtonSystemItemPause)
		{
		}
		if(item == UIBarButtonSystemItemRewind)
		{
		}
		if(item == UIBarButtonSystemItemFastForward)
		{
		}
		if(item == UIBarButtonSystemItemUndo)
		{
		}
		if(item == UIBarButtonSystemItemRedo)
		{
		}
		if(item == UIBarButtonSystemItemPageCurl)
		{
		}
	}
	*/
}
@end
