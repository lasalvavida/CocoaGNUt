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
#import <UIKit/UIView.h>
#import <UIKit/UINavigationItem.h>

@class UINavigationItem;

@interface UINavigationBar : UIView
{
	UIBarStyle barStyle;
	UIColor *tintColor;
	BOOL translucent;
	id delegate;
	NSArray *items;
}
-(id)initWithFrame:(CGRect)rect;
-(void)pushNavigationItem:(UINavigationItem *)item animated:(BOOL)animated;
-(UINavigationItem *)popNavigationItemAnimated:(BOOL)animated;
-(void)setItems:(NSArray *)items animated:(BOOL)animated;
-(void)drawRect:(CGRect)aRec;
@property(nonatomic, assign) UIBarStyle barStyle;
@property(nonatomic, retain) UIColor *tintColor;
@property(nonatomic, assign, getter=isTranslucent) BOOL translucent;
@property(nonatomic, assign) id delegate;
@property(nonatomic, copy) NSArray *items;
@property(nonatomic, readonly, retain) UINavigationItem *topItem;
@property(nonatomic, readonly, retain) UINavigationItem *backItem;
@end
