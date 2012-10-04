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
#import <cairo.h>
#import <CoreGraphics/CGGeometry.h>

#define CGAffineTransformIdentity CGAffineTransformMakeIdentity()

typedef cairo_matrix_t CGAffineTransform;

CGAffineTransform CGAffineTransformMake(CGFloat a, CGFloat b, CGFloat c, CGFloat d, CGFloat tx, CGFloat ty);
CGAffineTransform CGAffineTransformMakeRotation(CGFloat angle);
CGAffineTransform CGAffineTransformMakeScale(CGFloat sx, CGFloat sy);
CGAffineTransform CGAffineTransformMakeTranslation(CGFloat tx, CGFloat ty);
CGAffineTransform CGAffineTransformMakeIdentity();
CGAffineTransform CGAffineTransformTranslate(CGAffineTransform t, CGFloat tx, CGFloat ty);
CGAffineTransform CGAffineTransformScale(CGAffineTransform t, CGFloat sx, CGFloat sy);
CGAffineTransform CGAffineTransformRotate(CGAffineTransform t, CGFloat angle);
CGAffineTransform CGAffineTransformInvert(CGAffineTransform t);
CGAffineTransform CGAffineTransformConcat(CGAffineTransform t1, CGAffineTransform t2);
CGPoint CGPointApplyAffineTransform(CGPoint point, CGAffineTransform t);
CGSize CGSizeApplyAffineTransform(CGSize size, CGAffineTransform t);
CGRect CGRectApplyAffineTransform(CGRect rect, CGAffineTransform t);
int CGAffineTransformIsIdentity(CGAffineTransform t);
int CGAffineTransformEqualToTransform(CGAffineTransform t1, CGAffineTransform t2);

