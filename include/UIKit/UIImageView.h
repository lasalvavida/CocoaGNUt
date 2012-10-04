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
#import <UIKit/UIView.h>
#import <UIKit/UIImage.h>

@class UIImageAnimation;

@interface UIImageView : UIView
{
	UIImage *image;
	UIImage *highlightedImage;
	NSArray *animationImages;
	NSArray *highlightedAnimationImages;
	NSTimeInterval animationDuration;
	NSInteger animationRepeatCount;
	BOOL userInteractionEnabled;
	BOOL highlighted;
	UIImage *displayedImage;
	UIImageAnimation *animation;
	UIImageAnimation *highlightedAnimation;
}
-(id)initWithImage:(UIImage *)img;
-(id)initWithImage:(UIImage *)img highlightedImage:(UIImage *)highlightedImg;
-(void)startAnimating;
-(void)stopAnimating;
-(BOOL)isAnimating;
-(void)drawRect:(CGRect)rect;
@property(nonatomic, retain) UIImage *image;
@property(nonatomic, retain) UIImage *highlightedImage;
@property(nonatomic, copy) NSArray *animationImages;
@property(nonatomic, copy) NSArray *highlightedAnimationImages;
@property(nonatomic) NSTimeInterval animationDuration;
@property(nonatomic) NSInteger animationRepeatCount;
@property(nonatomic, getter=isUserInteractionEnabled) BOOL userInteractionEnabled;
@property(nonatomic, getter=isHighlighted) BOOL highlighted;
@property(nonatomic) UIImage* displayedImage;
@end
