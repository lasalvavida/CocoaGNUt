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
#import <UIKit/UIResponder.h>
#import <CoreGraphics/CGAffineTransform.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIColor.h>
#import <cairo.h>

void printViewStack();

@class UITransitionAnimation;

typedef enum
{
	UIViewAnimationTransitionNone,
	UIViewAnimationTransitionFlipFromLeft,
	UIViewAnimationTransitionFlipFromRight,
	UIViewAnimationTransitionCurlUp,
	UIViewAnimationTransitionCurlDown,
}
UIViewAnimationTransition;

typedef enum
{
	UIViewAnimationCurveEaseInEaseOut,
   	UIViewAnimationCurveEaseIn,
  	UIViewAnimationCurveEaseOut,
    	UIViewAnimationCurveLinear,
}
UIViewAnimationCurve;

typedef enum
{
	UIViewContentModeScaleToFill,
	UIViewContentModeScaleAspectFit,
	UIViewContentModeScaleAspectFill,
	UIViewContentModeRedraw,
	UIViewContentModeCenter,
	UIViewContentModeTop,
	UIViewContentModeBottom,
	UIViewContentModeLeft,
	UIViewContentModeRight,
	UIViewContentModeTopLeft,
	UIViewContentModeTopRight,
	UIViewContentModeBottomLeft,
	UIViewContentModeBottomRight,
} 
UIViewContentMode;

@interface UIView : UIResponder
{
	BOOL touched;
	NSArray *subviews;
	UIView *superview;
	CGRect bounds;
	CGPoint center;
	CGFloat alpha;
	CGAffineTransform transform;
	BOOL firstResponder;
	BOOL needsDisplay;
	cairo_surface_t *layer;
	UIViewContentMode contentMode;
	UIColor *backgroundColor;
	BOOL isTransitioning;
	UITransitionAnimation *transition;
}
-(id)initWithFrame:(CGRect) aRect;
-(void)setFrame:(CGRect)aRect;
-(void)setCenter:(CGPoint)point;
-(void)setBounds:(CGRect)aRect;
-(void)setAlpha:(CGFloat)val;
-(void)setTransform:(CGAffineTransform)trans;
-(void)addSubview:(UIView *)view;
-(void)bringSubviewToFront:(UIView *)view;
-(void)sendSubviewToBack:(UIView *)view;
-(void)removeFromSuperview;
-(void)insertSubview:(UIView *)view atIndex:(NSInteger)index;
-(void)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview;
-(void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview;
-(void)exchangeSubviewAtIndex:(NSInteger)index1 withSubviewAtIndex:(NSInteger)index2;
-(BOOL)isDescendantOfView:(UIView *)view;
-(void)drawRect:(CGRect)rect;
-(CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view;
-(CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;
-(CGRect)convertRect:(CGRect)rect toView:(UIView *)view;
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)setNeedsDisplay;
-(void)receiveInput:(NSString*)input;
+(NSArray*)getViewStack;
+(void)beginAnimations:(NSString *)animationID context:(void *)context;
+(void)setAnimationTransition:(UIViewAnimationTransition)trans forView:(UIView *)view cache:(BOOL)cache;
+(void)setAnimationDuration:(NSTimeInterval)duration;
+(void)setAnimationCurve:(UIViewAnimationCurve)curve;
+(void)commitAnimations;
-(void)dealloc;
@property(nonatomic) BOOL touched;
@property(nonatomic) UIView *superview;
@property(nonatomic, copy) NSArray *subviews;
@property(nonatomic) CGRect frame;
@property(nonatomic) CGRect bounds;
@property(nonatomic) CGPoint center;
@property(nonatomic) BOOL needsDisplay;
@property(nonatomic) cairo_surface_t *layer;
@property(nonatomic) CGFloat alpha;
@property(nonatomic) CGAffineTransform transform;
@property(nonatomic) UIViewContentMode contentMode;
@property(nonatomic, copy) UIColor *backgroundColor;
@property(nonatomic) BOOL isTransitioning;
@property(nonatomic) UITransitionAnimation *transition;
@end
