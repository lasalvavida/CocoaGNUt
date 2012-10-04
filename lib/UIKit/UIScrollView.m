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
#import <UIKit/UIScrollView.h>
#import <cairo.h>
#import <CoreGraphics/CGContext.h>
#import <UIKit/UITouch.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIAnimator.h>
#include <math.h>

@implementation UIScrollView
@synthesize contentOffset;
@synthesize bounces;
@synthesize contentSize;
@synthesize decelerating;
@synthesize directionalLockEnabled;
-(id)initWithFrame:(CGRect)aRect
{
	self = [super initWithFrame:aRect];
	bounces = YES;
	directionalLockEnabled = YES;
	contentOffset = CGPointMake(0.0f, 0.0f);
	return self;
}
-(void)setBounds:(CGRect)aBounds
{
	CGRect hold = aBounds;
	if(!xLock)
	{
		if(hold.origin.x < 0)
		{
			hold = CGRectMake(0, hold.origin.y, hold.size.width, hold.size.height);
		}
		if(hold.origin.x+hold.size.width > contentSize.width)
		{
			hold = CGRectMake(contentSize.width - hold.size.width, hold.origin.y, hold.size.width, hold.size.height);
		}
	}
	if(!yLock)
	{
		if(hold.origin.y < 0)
		{
			hold = CGRectMake(hold.origin.x, 0, hold.size.width, hold.size.height);
		}
		if(hold.origin.y+hold.size.height > contentSize.height)
		{
			hold = CGRectMake(hold.origin.x, contentSize.height - hold.size.height, hold.size.width, hold.size.height);
		}
	}
	
	[super setBounds:hold];
}
-(void)setContentOffset:(CGPoint)cOffset animated:(BOOL)animated
{
	if(animated)
	{
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:.5];
	}
	
	self.bounds = CGRectMake(contentOffset.x, contentOffset.y, bounds.size.width, bounds.size.height);
	
	if(animated)
	{
		[UIView commitAnimations];
	}
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	moveCount=0;
	if(self.bounds.size.height >= contentSize.height)
	{
		yLock = YES;
	}
	else
	{
		yLock = NO;
	}
	if(self.bounds.size.width >= contentSize.width)
	{
		xLock = YES;
	}
	else
	{
		yLock = NO;
	}
	touch = [touches anyObject];
	prevTouch = [touches anyObject];
	thirdTouch = [touches anyObject];
	origTouch = [touches anyObject];

	[[UIAnimator sharedAnimator]removeAnimationsForTarget:self];

	[super touchesBegan:touches withEvent:event];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	thirdTouch = prevTouch;
	prevTouch = touch;
	touch = [touches anyObject];
	
	moveCount++;
	
	if((moveCount == 3) && directionalLockEnabled)
	{
		CGFloat slope = (([touch locationInView: self].y - [origTouch locationInView: self].y)/([touch locationInView: self].x - [origTouch locationInView: self].x));
		if([touch locationInView: self].x - [origTouch locationInView: self].x == 0)
		{
			xLock = YES;
		}
		else if(slope < (1.0/3.0) && slope > (-1.0/3.0))
		{
			yLock = YES;
		}
		else if(slope < -3 && slope > 3)
		{
			xLock = YES;
		}
	}

	if(!xLock)
	{
		self.bounds = CGRectMake(self.bounds.origin.x - ([touch locationInView: self].x - [touch previousLocationInView: self].x), self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
	}
	if(!yLock)
	{
		self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y - ([touch locationInView: self].y - [touch previousLocationInView: self].y), self.bounds.size.width, self.bounds.size.height);
	}	
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[UIView beginAnimations:nil context:nil];
	touch = [touches anyObject];
	CGFloat xVelocity = (touch.location.x-thirdTouch.location.x)/(touch.timestamp-thirdTouch.timestamp);
	CGFloat yVelocity = (touch.location.y-thirdTouch.location.y)/(touch.timestamp-thirdTouch.timestamp);
	if(touch.timestamp - thirdTouch.timestamp == 0)
	{
		xVelocity = 0;
		yVelocity = 0;
	}
	printf("%f\n", yVelocity);
	if(xVelocity != 0 || yVelocity != 0)
	{
		decelerating = YES;
	}
	/*
	if(xVelocity > 100)
	{
		xVelocity = 90;
	}
	if(yVelocity > 90)
	{
		yVelocity = 90;
	}
	*/
	if(!xLock && fabs(xVelocity)>50)
	{
		self.bounds = CGRectMake(self.bounds.origin.x - xVelocity*2.0 + .5*(-10.0)*4.0, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
	}
	if(!yLock && fabs(yVelocity)>50)
	{
		self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y - yVelocity*2.0 + .5*(-10.0)*4.0, self.bounds.size.width, self.bounds.size.height);
	}
	[UIView setAnimationDuration:1.0f];
	[UIView commitAnimations];
}
@end
