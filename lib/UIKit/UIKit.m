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
#import <UIKit/UIKit.h>
#import <UIKit/UIAnimator.h>
#import <UIKit/UIKeyboard.h>
#include <sys/timeb.h>

id principalClass, delegateClass;
CGContextRef* contexts;
id globalAnimator;
UIKeyboard *globalKeyboard;
int count = 0;

int UIApplicationMain(int argc, char **argv, NSString *principalClassName, NSString *delegateClassName)
{
	if(principalClassName != nil)
	{
		principalClass = [[NSClassFromString(principalClassName) alloc] init];
	}
	else
	{
		principalClass = [[UIApplication alloc] init];
	}
	if(delegateClassName != nil)
	{
		delegateClass = [[NSClassFromString(delegateClassName) alloc] init];
	}
	else
	{
		delegateClass = nil;
	}
	((UIApplication *)principalClass).delegate = delegateClass;
	globalAnimator = [[UIAnimator alloc] init];
	globalKeyboard = [[UIKeyboard alloc] initKeyboard];
	[principalClass startApplication:argc withArgs:argv];
	return 0;
}

id UIApplicationGetPrincipalClass()
{
	return principalClass;
}

id UIApplicationGetGlobalAnimator()
{
	return globalAnimator;
}

UIKeyboard* UIApplicationGetGlobalKeyboard()
{
	return globalKeyboard;
}

id getDelegateClass()
{
	return delegateClass;
}

CGContextRef UIGraphicsGetCurrentContext()
{
	return contexts[count-1];
}

void UIGraphicsPushContext(CGContextRef context)
{
	count++;
	contexts = realloc(contexts, sizeof(CGContextRef)*count);
	contexts[count-1] = context;
}

void UIGraphicsPopContext()
{
	count--;
	cairo_destroy(contexts[count]);
	contexts = realloc(contexts, sizeof(CGContextRef)*count);
}

double get_uptime()
{
	struct timeb tp;
	ftime(&tp);
	return tp.time + (((double)tp.millitm)*.001);
}

