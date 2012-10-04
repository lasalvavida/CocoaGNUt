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
#import <UIKit/UIWindow.h>
#import <UIKit/UIStatusBar.h>
#import <UIKit/UIEvent.h>
#import <gtk/gtk.h>

@class UIApplication;

@protocol UIApplicationDelegate
-(void)applicationDidFinishLaunching:(UIApplication *)application;
@end

@interface UIApplication : UIResponder
{
	id<UIApplicationDelegate> delegate;
	UIWindow *keyWindow;
	GtkWidget *window;
	NSArray *windows;
}
-(void)startApplication:(int)argc withArgs:(char**)argv;
+(UIApplication *)sharedApplication;
-(GtkWidget *)getGtkWindow;
-(BOOL)sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent*)event;
-(void)touchesBegan;
-(void)touchesMoved;
-(void)touchesEnded;
@property(nonatomic, assign) id<UIApplicationDelegate> delegate;
@property(nonatomic, assign) UIWindow *keyWindow;
@property(nonatomic, readonly) NSArray *windows;
@property(nonatomic) UIStatusBarStyle statusBarStyle;
@end

