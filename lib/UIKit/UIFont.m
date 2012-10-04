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
#import <UIKit/UIFont.h>
#import <UIKit/UIKit.h>

@implementation UIFont
@synthesize familyName;
@synthesize fontName;
@synthesize pointSize;
@synthesize ascender;
@synthesize descender;
@synthesize capHeight;
@synthesize xHeight;
@synthesize lineHeight;
@synthesize leading; /*deprecated*/
+(UIFont*)fontWithName:(NSString*)fontName size:(CGFloat)fontSize
{
	UIFont* hold = [[UIFont alloc] initWithName:fontName andSize:fontSize];
	return hold;
}
-(id)initWithName:(NSString*)name andSize:(CGFloat)size
{
	PangoFont* font;

	PangoContext* context = pango_context_new();
	PangoFontMap* map = pango_cairo_font_map_get_default();
	pango_context_set_font_map(context, map);

	[self init];

	PangoFontDescription *description = pango_font_description_from_string([[name stringByAppendingString: [NSString stringWithFormat:@" %f", size]] UTF8String]); 
	font = pango_context_load_font(context, description);

	if(font == NULL)
	{
		printf("No font matched.\n");
	}
	
	cairo_surface_t* def = cairo_image_surface_create(CAIRO_FORMAT_ARGB32, 320.0f, 480.0f);
	CGContextRef ref = cairo_create(def);

	cairo_text_extents_t extents;
	
	PangoFontMetrics* metrics = pango_font_get_metrics(font, pango_language_get_default());

	fontName = name;	
	pointSize = size;
	ascender = pango_font_metrics_get_ascent(metrics)/PANGO_SCALE;
	descender = pango_font_metrics_get_descent(metrics)/PANGO_SCALE;

	capHeight = ascender;

	xHeight = ascender/2.0;

	lineHeight = ascender+descender;
	leading = lineHeight;
	cairo_surface_destroy(def);
	return self;
}
-(UIFont*)fontWithSize:(CGFloat)size
{
	pointSize = size;
	return self;
}
+(UIFont*)systemFontOfSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:@"helvetica" size:fontSize];
}
+(UIFont*)boldSystemFontOfSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:@"helvetica bold" size:fontSize];
}
+(UIFont*)italicSystemFontOfSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:@"helvetica italic" size:fontSize];
}
+(NSArray*)familyNames
{
	PangoFontMap* fontmap;
	PangoFontFamily **families;
	int n_families;


	NSArray* ret = [NSArray array];

	fontmap = pango_cairo_font_map_get_default();
	pango_font_map_list_families(fontmap, &families, &n_families);

	int x;
	for(x=0; x<n_families; x++)
	{
		ret = [ret arrayByAddingObject: [[NSString alloc] initWithCString: pango_font_family_get_name(families[x]) encoding: NSUTF8StringEncoding]];
	}
	return ret;
}
+(NSArray*)fontNamesForFamilyName:(NSString*)familyName
{
	PangoFontMap* fontmap;
	PangoFontFamily **families;
	int n_families;

	fontmap = pango_cairo_font_map_get_default();
	pango_font_map_list_families(fontmap, &families, &n_families);

	PangoFontFace **faces;
	int n_faces;
	int x;
	for(x=0; x<n_families; x++)
	{
		if(strcmp([familyName UTF8String], pango_font_family_get_name(families[x])))
		{
			pango_font_family_list_faces(families[x], &faces, &n_faces);
			break;
		} 
	}
	NSArray* ret = [NSArray array];
	for(x=0; x<n_faces; x++)
	{
		ret = [ret arrayByAddingObject: [[NSString alloc] initWithCString: pango_font_face_get_face_name(faces[x])]];
	}
	return ret;
}
+(CGFloat)labelFontSize
{
	return 17;
}
+(CGFloat)buttonFontSize
{
	return 18;
}
+(CGFloat)smallSystemFontSize
{
	return 12;
}
+(CGFloat)systemFontSize
{
	return 14;
}
@end
