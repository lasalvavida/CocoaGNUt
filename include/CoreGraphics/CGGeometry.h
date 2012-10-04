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
#import <stdbool.h>
#import <math.h>

typedef float CGFloat;

struct CGPoint
{
	CGFloat x;
	CGFloat y;
};
typedef struct CGPoint CGPoint;

struct CGSize
{
	CGFloat width;
	CGFloat height;
};
typedef struct CGSize CGSize;

struct CGRect
{
	CGPoint origin;
	CGSize size;
};
typedef struct CGRect CGRect;


CGPoint CGPointMake(CGFloat x, CGFloat y);

CGRect CGRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height);

CGSize CGSizeMake(CGFloat width, CGFloat height);

bool CGRectContainsPoint(CGRect rect, CGPoint point);

bool CGPointEqualToPoint(CGPoint p1, CGPoint p2);

bool CGSizeEqualToSize(CGSize s1, CGSize s2);

bool CGRectEqualToRect(CGRect r1, CGRect r2);

CGRect CGRectStandardize(CGRect rect);

CGFloat CGRectGetMinX(CGRect rect);
CGFloat CGRectGetMinY(CGRect rect);
CGFloat CGRectGetMidX(CGRect rect);
CGFloat CGRectGetMidY(CGRect rect);
CGFloat CGRectGetMaxX(CGRect rect);
CGFloat CGRectGetMaxY(CGRect rect);

const CGPoint CGPointZero;
const CGRect CGRectZero;
const CGSize CGSizeZero;
	
