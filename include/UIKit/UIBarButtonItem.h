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
#import <UIKit/UIBarItem.h>
#import <UIKit/UIView.h>

typedef enum
{
	UIBarButtonSystemItemDone,
	UIBarButtonSystemItemCancel,
	UIBarButtonSystemItemEdit,
	UIBarButtonSystemItemSave,
	UIBarButtonSystemItemAdd,
	UIBarButtonSystemItemFlexibleSpace,
	UIBarButtonSystemItemFixedSpace,
	UIBarButtonSystemItemCompose,
	UIBarButtonSystemItemReply,
	UIBarButtonSystemItemAction,
	UIBarButtonSystemItemOrganize,
	UIBarButtonSystemItemBookmarks,
	UIBarButtonSystemItemSearch,
	UIBarButtonSystemItemRefresh,
	UIBarButtonSystemItemStop,
	UIBarButtonSystemItemCamera,
	UIBarButtonSystemItemTrash,
	UIBarButtonSystemItemPlay,
	UIBarButtonSystemItemPause,
	UIBarButtonSystemItemRewind,
	UIBarButtonSystemItemFastForward,
	UIBarButtonSystemItemUndo,
	UIBarButtonSystemItemRedo,
	UIBarButtonSystemItemPageCurl
}
UIBarButtonSystemItem;

typedef enum
{
	UIBarButtonItemStylePlain,
	UIBarButtonItemStyleBordered,
	UIBarButtonItemStyleDone,
}
UIBarButtonItemStyle;

@interface UIBarButtonItem : UIBarItem
{
	id target;
	SEL action;
	UIBarButtonItemStyle itemStyle;
	NSSet *possibleTitles;
	CGFloat width;
	UIColor *tintColor;
	UIBarButtonSystemItem item;
	UIView *drawView;
	UIView *landscapeDrawView;
}
-(id)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem target:(id)tar action:(SEL)act;
-(id)initWithCustomView:(UIView *)customView;
-(id)initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style target:(id)tar action:(SEL)act;
-(id)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)tar action:(SEL)act;
-(id)initWithImage:(UIImage *)img landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style target:(id)tar action:(SEL)act;
-(void)drawRect:(CGRect)rect;
@property(nonatomic, assign) id target;
@property(nonatomic) SEL action;
@property(nonatomic) UIBarButtonItemStyle itemStyle;
@property(nonatomic, copy) NSSet *possibleTitles;
@property(nonatomic) CGFloat width;
@property(nonatomic, retain) UIColor *tintColor;
@property(nonatomic) UIView *drawView;
@end

