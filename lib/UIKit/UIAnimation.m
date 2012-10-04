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
#import <UIKit/UIAnimation.h>
#import <UIKit/UIImageView.h>

@implementation UIAnimation
-(id)initWithTarget:(id)obj
{
	self = [super init];
	target = obj;
	curve = kUIAnimationCurveEaseOut;
	canAnimate = NO;
	duration = 2.0;
	return self;
}
-(id)target
{
	return target;
}
-(void)setDelegate:(id)del
{
	delegate = del;
}
-(id)delegate
{
	return delegate;
}
-(void)setAction:(SEL)act
{
	action = act;
}
-(SEL)action
{
	return action;
}
-(float)duration
{
	return duration;
}
-(void)setDuration:(float)dur
{
	duration = dur;
}
-(void)setAnimationCurve:(UIAnimationCurve)animationCurve
{
	curve = animationCurve;
}
-(float)progressForFraction:(float)fraction
{
	if(curve == kUIAnimationCurveEaseIn)
	{
		return fraction*fraction;
	}
	else if(curve == kUIAnimationCurveEaseOut)
	{
		return (-1.0*(fraction-1.0)*(fraction-1.0))+1.0;
	}
	else if(curve == kUIAnimationCurveLinear)
	{
		return fraction;
	}
	else if(curve == kUIAnimationCurveEaseInEaseOut)
	{
		if(fraction < 0.5)
		{
			return 2.0*fraction*fraction;
		}
		else
		{
			return -2.0*fraction*fraction+4*fraction-1;
		}
	}
	return 0.0;
}
-(void)setProgress:(float)prog
{
	progress = prog;
}
-(float)progress
{
	return progress;
}
-(void)stopAnimation
{
	canAnimate = NO;
}
-(void)startAnimation
{
	canAnimate= YES;
}
-(BOOL)canAnimate
{
	return canAnimate;
}
@end

@implementation UIAlphaAnimation
-(void)setProgress:(float)prog
{
	[super setProgress:prog];
	prog = [self progressForFraction:prog];
	((UIView*)target).alpha = (startAlpha+(endAlpha-startAlpha)*prog);
}
-(float)startAlpha
{
	return startAlpha;
}
-(void)setStartAlpha:(float)alpha
{
	startAlpha = alpha;
}
-(void)setEndAlpha:(float)alpha
{
	endAlpha = alpha;
}
@end

@implementation UIFrameAnimation
-(void)setProgress:(float)prog
{
	[super setProgress:prog];
	prog = [self progressForFraction:prog];
	((UIView*)target).frame = CGRectMake((startFrame.origin.x+(endFrame.origin.x-startFrame.origin.x)*prog), (startFrame.origin.y+(endFrame.origin.y-startFrame.origin.y)*prog), (startFrame.size.width+(endFrame.size.width-startFrame.size.width)*prog), (startFrame.size.height+(endFrame.size.height-startFrame.size.height)*prog));
}
-(CGRect)startFrame
{
	return startFrame;
}
-(void)setStartFrame:(CGRect)frame
{
	startFrame = frame;
}
-(void)setEndFrame:(CGRect)frame
{
	endFrame = frame;
}
@end

@implementation UITransformAnimation
-(void)setProgress:(float)prog
{
	[super setProgress:prog];
	prog = [self progressForFraction:prog];
	((UIView*)target).transform = CGAffineTransformMake((startTransform.xx+(endTransform.xx-startTransform.xx)*prog), (startTransform.yx+(endTransform.yx-startTransform.yx)*prog), (startTransform.xy+(endTransform.xy-startTransform.xy)*prog), (startTransform.yy+(endTransform.yy-startTransform.yy)*prog),
(startTransform.x0+(endTransform.x0-startTransform.x0)*prog),(startTransform.y0+(endTransform.y0-startTransform.y0)*prog));
}
-(CGAffineTransform)startTransform
{
	return startTransform;
}
-(void)setStartTransform:(CGAffineTransform)transform
{
	startTransform = transform;
}
-(void)setEndTransform:(CGAffineTransform)transform
{
	endTransform = transform;
}
@end

@implementation UIBoundsAnimation
-(void)setProgress:(float)prog
{
	[super setProgress:prog];
	prog = [self progressForFraction:prog];
	((UIView*)target).bounds = CGRectMake((startPoint.x+(endPoint.x-startPoint.x)*prog), (startPoint.y+(endPoint.y-startPoint.y)*prog), ((UIView*)target).bounds.size.width, ((UIView*)target).bounds.size.height);
}
-(CGPoint)startPoint
{
	return startPoint;
}
-(void)setStartPoint:(CGPoint)point
{
	startPoint = point;
}
-(void)setEndPoint:(CGPoint)point
{
	endPoint = point;
}
@end

@implementation UIImageAnimation
-(void)setProgress:(float)prog
{
	[super setProgress:prog];
	prog = [self progressForFraction:prog];
	int imageNum = [images count]*prog;
	((UIImageView*)target).displayedImage = [images objectAtIndex: imageNum];
}
-(NSArray*)images
{
	return images;
}
-(void)setImages:(NSArray*)imageSet;
{
	images = imageSet;
}
@end

@implementation UITransitionAnimation
-(void)setProgress:(float)prog
{
	[super setProgress:prog];
	prog = [self progressForFraction:prog];
	if(transition == UIViewAnimationTransitionNone)
	{
		[startView removeFromSuperview];
		[startView.superview addSubview:endView];
		[self stopAnimation];
	}
	else if(transition == UIViewAnimationTransitionFlipFromLeft)
	{
		if(prog < 0.5)
		{
			CGAffineTransform transform = startView.transform;
			transform = CGAffineTransformMake(1-(prog*2.0), transform.yx, -0.3*(prog*2.0), transform.yy,
transform.x0, transform.y0);
			startView.transform = transform;
		}
		else
		{
			if(sentinel == 0)
			{
				[startView removeFromSuperview];
				[startView.superview addSubview:endView];
				sentinel++;
			}
			CGAffineTransform transform = endView.transform;
			transform = CGAffineTransformMake((prog-.5)*2.0, transform.yx, -0.3+(0.3*(prog*2.0)), transform.yy, transform.x0, transform.y0);
			endView.transform = transform;
		}
	}
	else if(transition == UIViewAnimationTransitionFlipFromRight)
	{
		if(prog < 0.5)
		{
			CGAffineTransform transform = startView.transform;
			transform = CGAffineTransformMake(1-(prog*2.0), transform.yx, 0.3*(prog*2.0), transform.yy,
transform.x0, transform.y0);
			startView.transform = transform;
		}
		else
		{
			if(sentinel == 0)
			{
				[startView removeFromSuperview];
				[startView.superview addSubview:endView];
				sentinel++;
			}
			CGAffineTransform transform = endView.transform;
			transform = CGAffineTransformMake((prog-.5)*2.0, transform.yx, 0.3-(0.3*(prog*2.0)), transform.yy, transform.x0, transform.y0);
			endView.transform = transform;
		}
	}
	else if(transition == UIViewAnimationTransitionCurlUp)
	{
		[startView.superview addSubview:endView];
		[startView.superview sendSubviewToBack:endView];
		CGAffineTransform transform = startView.transform;
		transform = CGAffineTransformMake(transform.xx, transform.yx, transform.xy, 1-prog, transform.x0, (startView.bounds.size.height*prog)-startView.bounds.size.height);
		startView.transform = transform;
		if(prog == 1)
		{
			[startView removeFromSuperview];
		}
	}
	else if(transition == UIViewAnimationTransitionCurlDown)
	{
		[startView.superview addSubview:endView];
		[startView.superview sendSubviewToBack:endView];
		CGAffineTransform transform = startView.transform;
		transform = CGAffineTransformMake(transform.xx, transform.yx, transform.xy, 1-prog, transform.x0, startView.bounds.size.height-(startView.bounds.size.height*prog));
		startView.transform = transform;
		if(prog == 1)
		{
			[startView removeFromSuperview];
		}
	}
}
-(UIView*)startView
{
	return startView;
}
-(void)setStartView:(UIView*)view
{
	startView = view;
}
-(void)setEndView:(UIView*)view
{
	endView = view;
}
-(void)setTransition:(UIViewAnimationTransition)trans
{
	transition = trans;
}
@end
