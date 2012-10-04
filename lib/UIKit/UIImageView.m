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
#import <UIKit/UIImageView.h>
#import <UIKit/UIAnimation.h>
#import <UIKit/UIAnimator.h>
#import <CoreGraphics/CGImage.h>

@implementation UIImageView
@synthesize image;
@synthesize highlightedImage;
@synthesize animationImages;
@synthesize highlightedAnimationImages;
@synthesize animationDuration;
@synthesize animationRepeatCount;
@synthesize userInteractionEnabled;
@synthesize highlighted;
@synthesize displayedImage;

-(id)initWithImage:(UIImage *)img
{
	self = [super initWithFrame: CGRectMake(0.0f, 0.0f, CGImageGetWidth(img.CGImage), CGImageGetHeight(img.CGImage))];
	image = img;

	animationRepeatCount = 0;
	return self;
}
-(id)initWithImage:(UIImage *)img highlightedImage:(UIImage *)highlightedImg
{
	self = [self initWithImage:img];
	
	highlightedImage = highlightedImg;
	return self;
}
-(void)startAnimating
{
	if(animation == nil)
	{
		animation = [[UIImageAnimation alloc] initWithTarget:self];
		[animation setImages:animationImages];
		[animation setDuration:[animationImages count]*(1.0/30.0)];
	}
	if(highlightedAnimation == nil)
	{
		highlightedAnimation = [[UIImageAnimation alloc] initWithTarget:self];
		[animation setImages:highlightedAnimationImages];
		[animation setDuration:[highlightedAnimationImages count]*(1.0/30.0)];
	}
	if(!highlighted)
	{
		[[UIAnimator sharedAnimator] addAnimation:animation];
		[animation startAnimation];
	}
	else
	{
		[[UIAnimator sharedAnimator] addAnimation:highlightedAnimation];
		[highlightedAnimation startAnimation];
	}
}
-(void)stopAnimating
{
	[animation stopAnimation];
	[highlightedAnimation stopAnimation];
}
-(BOOL)isAnimating
{
	if(!highlighted)
	{
		return [animation canAnimate];
	}
	else
	{
		return [highlightedAnimation canAnimate];
	}
}
-(void)drawRect:(CGRect)rect
{
	if(![self isAnimating])
	{
		if(!highlighted)
		{
			displayedImage = image;
		}
		else
		{
			displayedImage = highlightedImage;
		}
	}
	[displayedImage drawInRect:rect];
}
@end
