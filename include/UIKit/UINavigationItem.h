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
#import <UIKit/UIBarButtonItem.h>

@interface UINavigationItem : NSObject
{
	NSString *title;
	NSString *prompt;
	UIBarButtonItem *backBarButtonItem;
	BOOL hidesBackButton;
	UIView *titleView;
	UIBarButtonItem *leftBarButtonItem;
	UIBarButtonItem *rightBarButtonItem;
}
-(id)initWithTitle:(NSString *)title;
-(void)setHidesBackButton:(BOOL)hidesBackButton animated:(BOOL)animated;
-(void)setLeftBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated;
-(void)setRightBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *prompt;
@property(nonatomic, retain) UIBarButtonItem *backBarButtonItem;
@property(nonatomic, assign) BOOL hidesBackButton;
@property(nonatomic, retain) UIView *titleView;
@property(nonatomic, retain) UIBarButtonItem *leftBarButtonItem;
@property(nonatomic, retain) UIBarButtonItem *rightBarButtonItem;
@end



