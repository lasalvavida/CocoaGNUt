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
#import <CoreGraphics/CGAffineTransform.h>
#import <UIKit/UIView.h>

typedef enum 
{
    kUIAnimationCurveEaseInEaseOut,
    kUIAnimationCurveEaseIn,
    kUIAnimationCurveEaseOut,
    kUIAnimationCurveLinear, 
} 
UIAnimationCurve;

@interface UIAnimation : NSObject
{
	id target;
	id delegate;
	UIAnimationCurve curve;
	SEL action;
	float duration;
	float progress;
	float canAnimate;
}
-(id)initWithTarget:(id)obj;
-(id)target;
-(void)setDelegate:(id)del;
-(id)delegate;
-(void)setAction:(SEL)action;
-(SEL)action;
-(void)setDuration:(float)dur;
-(float)duration;
-(void)setAnimationCurve:(UIAnimationCurve)animationCurve;
-(float)progressForFraction:(float)fraction;
-(void)setProgress:(float)prog;
-(float)progress;
-(void)stopAnimation;
-(void)startAnimation;
-(BOOL)canAnimate;
@end

#import <CoreGraphics/CGGeometry.h>

@interface UIAlphaAnimation : UIAnimation
{
	float startAlpha;
	float endAlpha;
}
-(void)setProgress:(float)progress;
-(float)startAlpha;
-(void)setStartAlpha:(float)alpha;
-(void)setEndAlpha:(float)alpha;
@end

@interface UIFrameAnimation : UIAnimation
{
	CGRect startFrame;
	CGRect endFrame;
}
-(void)setProgress:(float)prog;
-(CGRect)startFrame;
-(void)setStartFrame:(CGRect)frame;
-(void)setEndFrame:(CGRect)frame;
@end

@interface UITransformAnimation : UIAnimation
{
	CGAffineTransform startTransform;
	CGAffineTransform endTransform;
}
-(void)setProgress:(float)prog;
-(CGAffineTransform)startTransform;
-(void)setStartTransform:(CGAffineTransform)transform;
-(void)setEndTransform:(CGAffineTransform)transform;
@end

@interface UIBoundsAnimation : UIAnimation
{
	CGPoint startPoint;
	CGPoint endPoint;
}
-(void)setProgress:(float)prog;
-(CGPoint)startPoint;
-(void)setStartPoint:(CGPoint)point;
-(void)setEndPoint:(CGPoint)point;
@end

@interface UIImageAnimation : UIAnimation
{
	NSArray *images;
}
-(void)setProgress:(float)prog;
-(NSArray*)images;
-(void)setImages:(NSArray*)imageSet;
@end

@interface UITransitionAnimation : UIAnimation
{
	UIView* startView;
	UIView* endView;
	UIViewAnimationTransition transition;
	int sentinel;
}
-(void)setProgress:(float)prog;
-(UIView*)startView;
-(void)setStartView:(UIView*)view;
-(void)setEndView:(UIView*)view;
-(void)setTransition:(UIViewAnimationTransition)trans;
@end
