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

@implementation UIResponder
-(UIResponder *)nextResponder
{
	return nil;
}
-(BOOL)isFirstResponder
{
	return NO;
}
-(BOOL)canBecomeFirstResponder
{
	return NO;
}
-(BOOL)becomeFirstResponder
{
	if([self canBecomeFirstResponder])
	{
		//become first responder
		return YES;
	}
	else
	{
		return NO;
	}
}
-(BOOL)canResignFirstResponder
{
	return YES;
}
-(BOOL)resignFirstResponder
{
	return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}
@end

