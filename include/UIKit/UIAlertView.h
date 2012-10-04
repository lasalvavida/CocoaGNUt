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
#import <UIKit/UIButton.h>
#import <UIKit/UITextView.h>

@interface UIAlertView : UIView
{
	id delegate;
	NSString* title;
	NSString* message;
	UILabel* dispTitle;
	UITextView* dispMessage;
	BOOL visible;
	NSInteger numberOfButtons;
	NSInteger cancelButtonIndex;
	NSInteger firstOtherButtonIndex;
	UIView* buttons;
}
-(id)initWithTitle:(NSString*)titl message:(NSString*)messag delegate:(id)delegat cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitles:(NSString*)otherButtonTitles, ...;
-(NSInteger)addButtonWithTitle:(NSString*)titl;
-(NSString*)buttonTitleAtIndex:(NSInteger)buttonIndex;
-(void)drawRect:(CGRect)rect;
-(void)show;
-(void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;
-(void)receivedMessage:(id)sender forEvent:(UIEvent*)event;
-(void)layout;
@property(nonatomic, assign) id delegate;
@property(nonatomic, copy) NSString* title;
@property(nonatomic, copy) NSString* message;
@property(nonatomic, readonly, getter=isVisible) BOOL visible;
@property(nonatomic, readonly) NSInteger numberOfButtons;
@property(nonatomic) NSInteger cancelButtonIndex;
@property(nonatomic) NSInteger firstOtherButtonIndex;
@end

@protocol UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;
-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex;
-(void)alertViewCancel:(UIAlertView *)alertView;
-(BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView;
-(void)didPresentAlertView:(UIAlertView *)alertView;
-(void)willPresentAlertView:(UIAlertView *)alertView;
@end
