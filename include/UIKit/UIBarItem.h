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
#import <UIKit/UIImage.h>

@interface UIBarItem : NSObject
{
	BOOL enabled;
	UIImage *image;
	//UIEdgeInsets imageInsets;
	NSInteger tag;
	NSString *title;
}
@property(nonatomic, getter=isEnabled) BOOL enabled;
@property(nonatomic, retain) UIImage *image;
//@property(nonatomic) UIEdgeInsets imageInsets;
@property(nonatomic) NSInteger tag;
@property(nonatomic, copy) NSString *title;
@end
