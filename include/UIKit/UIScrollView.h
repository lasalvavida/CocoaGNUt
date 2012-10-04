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
#import <UIKit/UIKitExtern.h>
#import <CoreGraphics/CGGeometry.h>

gboolean autoScroll();
gboolean bounce();

@class UIEvent;
@class UITouch;

@interface UIScrollView : UIView
{
	CGSize contentSize;
	CGPoint contentOffset;
	UIEdgeInsets contentInset;
	BOOL bounces;
	BOOL decelerating;
	BOOL directionalLockEnabled;
	BOOL xLock, yLock;
	UITouch* touch;
	UITouch* prevTouch;
	UITouch* thirdTouch;
	UITouch* origTouch;
	int moveCount;
}
-(id)initWithFrame:(CGRect)aRect;
-(void)setBounds:(CGRect)aBounds;
-(void)setContentOffset:(CGPoint)cOffset animated:(BOOL)animated;
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
@property(nonatomic) CGPoint contentOffset;
@property(nonatomic) UIEdgeInsets contentInset;
@property(nonatomic) CGSize contentSize;
@property(nonatomic) BOOL bounces;
@property(nonatomic, readonly, getter=isDecelerating) BOOL decelerating;
@property(nonatomic, getter=isDirectionalLockEnabled) BOOL directionalLockEnabled;
@end
