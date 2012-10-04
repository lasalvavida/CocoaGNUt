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
#import <gtk/gtk.h>
#import <sys/sysinfo.h>
#import <UIKit/UIApplication.h>
#import <UIKit/UIResponder.h>
#import <UIKit/UIView.h>
#import <UIKit/UIWindow.h>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CGContext.h>
#import <UIKit/UIKitExtern.h>
#import <UIKit/UIKeyboard.h>

typedef enum
{
	UIBarStyleDefault = 0,
	UIBarStyleBlack = 1,
	UIBarStyleBlackOpaque = 1,
	UIBarStyleBlackTranslucent = 2
}
UIBarStyle;

id principalClass; 
id delegateClass;

int UIApplicationMain(int argc, char *argv[], NSString *principalClassName, NSString *delegateClassName);

CGContextRef UIGraphicsGetCurrentContext();

id UIApplicationGetPrincipalClass();

id UIApplicationGetGlobalAnimator();

UIKeyboard* UIApplicationGetGlobalKeyboard();

void UIGraphicsPushContext(CGContextRef context);

void UIGraphicsPopContext();

double get_uptime();


