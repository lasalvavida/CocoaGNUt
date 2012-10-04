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
#import <CoreGraphics/CGContext.h>
#import <stdlib.h>

void CGContextAddRect(CGContextRef c, CGRect rect)
{
	cairo_rectangle(c, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
}

void CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2, CGFloat radius)
{
	cairo_arc(c, (x1+x2)/2, (y1+y2)/2, radius, 0, 1);
}

void CGContextClip(CGContextRef c)
{
	cairo_clip(c);
}

void CGContextDrawPath(CGContextRef c, CGPathDrawingMode mode)
{
	if(mode == kCGPathFill)
	{
		cairo_set_fill_rule(c, CAIRO_FILL_RULE_WINDING);
		cairo_fill(c);
	}
	else if(mode == kCGPathEOFill)
	{
		cairo_set_fill_rule(c, CAIRO_FILL_RULE_EVEN_ODD);
		cairo_fill(c);
	}
	else if(mode == kCGPathStroke)
	{
		cairo_stroke(c);
	}
	else if(mode == kCGPathFillStroke)
	{
		cairo_set_fill_rule(c, CAIRO_FILL_RULE_WINDING);
		cairo_fill(c);
		cairo_stroke(c);
	}
	else if(mode == kCGPathEOFillStroke)
	{
		cairo_set_fill_rule(c, CAIRO_FILL_RULE_EVEN_ODD);
		cairo_fill(c);
		cairo_stroke(c);
	}
}

void CGContextAddEllipseInRect(CGContextRef c, CGRect rect)
{
	cairo_save(c);
	cairo_translate(c, rect.origin.x + rect.size.width / 2.0, rect.origin.y + rect.size.height / 2.0);
	cairo_scale(c, rect.size.width / 2.0, rect.size.height / 2.0);
	cairo_arc(c, 0.0, 0.0, 1.0, 0.0, 2 * M_PI);
	cairo_restore(c);
}

void CGContextFillEllipseInRect(CGContextRef c, CGRect rect)
{
	CGContextAddEllipseInRect(c, rect);
	CGContextFillPath(c);
}

void CGContextClosePath(CGContextRef c)
{
	cairo_close_path(c);
}

void CGContextSaveGState(CGContextRef c)
{
	cairo_save(c);
}

void CGContextRestoreGState(CGContextRef c)
{
	cairo_restore(c);
}

void CGContextFlush(CGContextRef x)
{
	//still working on this
}

void CGContextRelease(CGContextRef c)
{
	cairo_destroy(c);
}

void CGContextSetLineWidth(CGContextRef c, CGFloat width)
{
	cairo_set_line_width(c, width);
}

void CGContextSetRGBStrokeColor(CGContextRef c, CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha)
{
	cairo_set_source_rgba(c, red, green, blue, alpha);
}

void CGContextSetRGBFillColor(CGContextRef c, CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha)
{
	cairo_set_source_rgba(c, red, green, blue, alpha);
}

void CGContextStrokePath(CGContextRef c)
{
	cairo_stroke(c);
}

void CGContextFillPath(CGContextRef c)
{
	cairo_fill(c);
}

void CGContextMoveToPoint(CGContextRef c, CGFloat x, CGFloat y)
{
	cairo_move_to(c, x, y);
}

void CGContextAddLineToPoint(CGContextRef c, CGFloat x, CGFloat y)
{
	cairo_line_to(c, x, y);
}

void CGContextShowText(CGContextRef c, const char *string, size_t length)
{
	cairo_show_text(c, string);
}

void CGContextShowTextAtPoint(CGContextRef c, CGFloat x, CGFloat y, const char *string, size_t length)
{
	cairo_move_to(c, x, y);
	cairo_show_text(c, string);
}

void CGContextSelectFont(CGContextRef c, const char *name, CGFloat size, CGTextEncoding textEncoding)
{
	cairo_set_font_size(c, size);
	cairo_select_font_face(c, name, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
}

void CGContextDrawLinearGradient(CGContextRef c, CGGradientRef gradient, CGPoint startPoint, CGPoint endPoint, CGGradientDrawingOptions options)
{
	cairo_pattern_t *pat;

	pat = cairo_pattern_create_linear(startPoint.x, startPoint.y, endPoint.x, endPoint.y);
	int x;
	CGColorRef hold;
	CGFloat* components = calloc(4, sizeof(CGFloat));
	for(x=0; x<CGGradientGetNumberOfColorStops(gradient); x++)
	{
		hold = CGColorGetColorUsingColorSpace(CGGradientGetColorAtIndex(gradient, x), CGColorSpaceCreateDeviceRGB());
		CGColorGetComponents(hold, &components);
		cairo_pattern_add_color_stop_rgba(pat, CGGradientGetLocationAtIndex(gradient, x), components[0], components[1], components[2], components[3]);
	}

	cairo_rectangle(c, 0.0, 0.0, 320.0, 480.0);
	cairo_set_source(c, pat);
	cairo_fill(c);
	cairo_pattern_destroy(pat);
	free(components);
}

void CGContextFillRect(CGContextRef c, CGRect rect)
{
	cairo_rectangle(c, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
	cairo_fill(c);
}

void CGContextStrokeEllipseInRect(CGContextRef c, CGRect rect)
{
	//cairo_scale(c, 1, rect.size.height/rect.size.width);
	cairo_arc(c, rect.origin.x+(rect.size.width/2), rect.origin.y+(rect.size.width/2), rect.size.width/2, 0, 2*M_PI);
	cairo_stroke(c);
	//cairo_scale(c, 1, rect.size.width/rect.size.height);
}

void CGContextTranslateCTM(CGContextRef c, CGFloat tx, CGFloat ty)
{
	cairo_translate(c, tx, ty);
}

void CGContextScaleCTM(CGContextRef c, CGFloat sx, CGFloat sy)
{
	cairo_scale(c, sx, sy);
}

void CGContextRotateCTM(CGContextRef c, CGFloat angle)
{
	cairo_rotate(c, angle);
}

void CGContextConcatCTM(CGContextRef c, CGAffineTransform transform)
{
	CGContextSetCTM(c, CGAffineTransformConcat(CGContextGetCTM(c), transform));
}

void CGContextSetCTM(CGContextRef c, CGAffineTransform t)
{
	cairo_set_matrix(c, &t);
}

CGAffineTransform CGContextGetCTM(CGContextRef c)
{
	CGAffineTransform t;
	cairo_get_matrix(c, &t);
	return t;
}
