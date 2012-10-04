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
#import <CoreGraphics/CGGeometry.h>

CGPoint CGPointMake(CGFloat x, CGFloat y)
{
	CGPoint ret;
	ret.x = x;
	ret.y = y;
	return ret;
}

CGRect CGRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
	CGRect ret;
	ret.origin.x = x;
	ret.origin.y = y;
	ret.size.width = width;
	ret.size.height = height;
	return ret;
}

CGSize CGSizeMake(CGFloat width, CGFloat height)
{
	CGSize ret;
	ret.width = width;
	ret.height = height;
	return ret;
}

bool CGRectContainsPoint(CGRect rect, CGPoint point)
{
	if(point.x > rect.origin.x && point.x < rect.origin.x+rect.size.width && point.y > rect.origin.y && point.y < rect.origin.y+rect.size.height)
	{
		return 1;
	}
	return 0;
}

bool CGPointEqualToPoint(CGPoint p1, CGPoint p2)
{
	if(p1.x != p2.x)
	{
		return 0;
	}
	if(p1.y != p2.y)
	{
		return 0;
	}
	return 1;
}

bool CGSizeEqualToSize(CGSize s1, CGSize s2)
{
	if(s1.width != s2.width)
	{
		return 0;
	}
	if(s1.height != s2.height)
	{
		return 0;
	}
	return 1;
}

bool CGRectEqualToRect(CGRect r1, CGRect r2)
{
	if(!CGPointEqualToPoint(r1.origin, r2.origin))
	{
		return 0;
	}
	if(!CGSizeEqualToSize(r1.size, r2.size))
	{
		return 0;
	}
	return 1;
}
	
CGRect CGRectIntersection(CGRect r1, CGRect r2)
{
	CGRect ret;
	if(r1.origin.x < r2.origin.x)
	{
		ret.origin.x = r2.origin.x;
		ret.size.width = r1.origin.x+r1.size.width-r2.origin.x;
	}
	else
	{
		ret.origin.x = r1.origin.x;
		ret.size.width = r2.origin.x+r2.size.width-r1.origin.x;
	}
	if(r1.origin.y < r2.origin.y)
	{
		ret.origin.y = r2.origin.y;
		ret.size.height = r1.origin.y+r1.size.height-r2.origin.y;
	}
	else
	{
		ret.origin.y = r1.origin.y;
		ret.size.height = r2.origin.y+r2.size.height-r1.origin.y;
	}
	return ret;
}

CGRect CGRectStandardize(CGRect rect)
{
	if(rect.size.width < 0)
	{
		rect.origin.x += rect.size.width;
		rect.size.width = fabs(rect.size.width);
	}
	if(rect.size.height < 0)
	{
		rect.origin.y += rect.size.height;
		rect.size.height = fabs(rect.size.height);
	}
	return rect;
}

CGFloat CGRectGetMinX(CGRect rect)
{
	rect = CGRectStandardize(rect);
	return rect.origin.x;
}

CGFloat CGRectGetMinY(CGRect rect)
{
	rect = CGRectStandardize(rect);
	return rect.origin.y;
}

CGFloat CGRectGetMidX(CGRect rect)
{
	rect = CGRectStandardize(rect);
	return rect.origin.x + rect.size.width/2.0;
}

CGFloat CGRectGetMidY(CGRect rect)
{
	rect = CGRectStandardize(rect);
	return rect.origin.y + rect.size.height/2.0;
}

CGFloat CGRectGetMaxX(CGRect rect)
{
	rect = CGRectStandardize(rect);
	return rect.origin.x + rect.size.width;
}

CGFloat CGRectGetMaxY(CGRect rect)
{
	rect = CGRectStandardize(rect);
	return rect.origin.y + rect.size.height;
}

