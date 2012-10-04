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
#import <CoreGraphics/CGAffineTransform.h>
#import <math.h>

CGAffineTransform CGAffineTransformMake(CGFloat a, CGFloat b, CGFloat c, CGFloat d, CGFloat tx, CGFloat ty)
{
	CGAffineTransform ret;
	cairo_matrix_init(&ret, a, b, c, d, tx, ty);
	return ret; 
}

CGAffineTransform CGAffineTransformMakeRotation(CGFloat angle)
{
	CGAffineTransform ret;
	cairo_matrix_init_rotate(&ret, angle*M_PI/180);
	return ret;
}

CGAffineTransform CGAffineTransformMakeScale(CGFloat sx, CGFloat sy)
{
	CGAffineTransform ret;
	cairo_matrix_init_scale(&ret, sx, sy);
	return ret;
}

CGAffineTransform CGAffineTransformMakeTranslation(CGFloat tx, CGFloat ty)
{
	CGAffineTransform ret;
	cairo_matrix_init_translate(&ret, tx, ty);
	return ret;
}

CGAffineTransform CGAffineTransformMakeIdentity()
{
	CGAffineTransform ret;
	cairo_matrix_init_identity(&ret);
	return ret;
}

CGAffineTransform CGAffineTransformTranslate(CGAffineTransform t, CGFloat tx, CGFloat ty)
{
	cairo_matrix_translate(&t, tx, ty);
	return t;
}

CGAffineTransform CGAffineTransformScale(CGAffineTransform t, CGFloat sx, CGFloat sy)
{
	cairo_matrix_scale(&t, sx, sy);
	return t;
}

CGAffineTransform CGAffineTransformRotate(CGAffineTransform t, CGFloat angle)
{
	cairo_matrix_rotate(&t, angle*M_PI/180);
	return t;
}

CGAffineTransform CGAffineTransformInvert(CGAffineTransform t)
{
	cairo_matrix_invert(&t);
	return t;
}

CGAffineTransform CGAffineTransformConcat(CGAffineTransform t1, CGAffineTransform t2)
{
	CGAffineTransform ret;
	cairo_matrix_multiply(&ret, &t1, &t2);
	return ret;
}

CGPoint CGPointApplyAffineTransform(CGPoint point, CGAffineTransform t)
{
	double xhold, yhold;
	xhold = (double)point.x;
	yhold = (double)point.y;
	cairo_matrix_transform_point(&t, &xhold, &yhold);
	return CGPointMake(((float)xhold), ((float)yhold));
}

CGSize CGSizeApplyAffineTransform(CGSize size, CGAffineTransform t)
{
	double xhold, yhold;
	xhold = (double)size.width;
	yhold = (double)size.height;
	cairo_matrix_transform_distance(&t, &xhold, &yhold);
	return CGSizeMake(((float)xhold), ((float)yhold));
}

CGRect CGRectApplyAffineTransform(CGRect rect, CGAffineTransform t)
{
	CGPoint origin = CGPointApplyAffineTransform(rect.origin, t);
	CGSize size = CGSizeApplyAffineTransform(rect.size, t);
	return CGRectMake(origin.x, origin.y, size.width, size.height);
}

int CGAffineTransformIsIdentity(CGAffineTransform t)
{
	return CGAffineTransformEqualToTransform(t, CGAffineTransformIdentity);
}
int CGAffineTransformEqualToTransform(CGAffineTransform t1, CGAffineTransform t2)
{
	if(t1.xx != t2.xx)
		return 0;
	if(t1.yx != t2.yx)
		return 0;
	if(t1.xy != t2.xy)
		return 0;
	if(t1.yy != t2.yy)
		return 0;
	if(t1.x0 != t2.x0)
		return 0;
	if(t1.y0 != t2.y0)
		return 0;
	return 1;
}
