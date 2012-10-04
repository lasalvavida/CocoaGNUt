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
#import <UIKit/UILabel.h>
#import <UIKit/UIKit.h>

@implementation UILabel
@synthesize text;
@synthesize font;
@synthesize textColor;
@synthesize textAlignment;
@synthesize lineBreakMode;
@synthesize enabled;
@synthesize adjustsFontSizeToFitWidth;
@synthesize baselineAdjustment;
@synthesize numberOfLines;
@synthesize minimumFontSize;
@synthesize highlightedTextColor;
@synthesize highlighted;
@synthesize shadowColor;
@synthesize shadowOffset;
@synthesize userInteractionEnabled;
-(id)initWithFrame:(CGRect)rect
{
	self = [super initWithFrame: rect];
	self.backgroundColor = [UIColor whiteColor];
	self.textColor = [UIColor blackColor];
	self.font = [UIFont fontWithName:@"Helvetica" size:17];
	self.textAlignment = UITextAlignmentLeft;
	self.lineBreakMode = UILineBreakModeWordWrap;
	self.numberOfLines = 1;
	return self;
}
-(void)drawRect:(CGRect)frame
{
	[self drawTextInRect:frame];
}
-(CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
	return CGRectMake(0,0,0,0);
}
-(void)drawTextInRect:(CGRect)frame
{
	CGContextRef ref = UIGraphicsGetCurrentContext();

	
	CGFloat* components = calloc(4, sizeof(CGFloat));
	CGColorGetComponents(highlightedTextColor.CGColor, &components);
	CGContextSetRGBStrokeColor(ref, components[0], components[1], components[2], components[3]);
	CGContextFillRect(ref, self.bounds);

	CGContextSelectFont(ref, [[font fontName] UTF8String], [font pointSize], kCGEncodingFontSpecific);
	CGColorGetComponents(textColor.CGColor, &components);
	CGContextSetRGBStrokeColor(ref, components[0], components[1], components[2], components[3]);

	if(lineBreakMode == UILineBreakModeWordWrap)
	{
		if(numberOfLines == -1)
		{
			CGContextRef ref = UIGraphicsGetCurrentContext();
			CGContextSelectFont(ref, [[font fontName] UTF8String], [font pointSize], kCGEncodingFontSpecific);
			cairo_text_extents_t extents;
			cairo_text_extents(ref, [text UTF8String], &extents);

			int lines = 0;
			NSString* display = @"";
			NSArray *strings = [text componentsSeparatedByString: @" "];
			int x;
			for(x=0; x<[strings count]; x++)
			{
				display = [display stringByAppendingString: ((NSString*)[strings objectAtIndex:x])];
				cairo_text_extents(ref, [display UTF8String], &extents);
				if(extents.width > bounds.size.width)
				{
					x--;
					lines++;
					display = @"";
				}
				else
				{
					display = [display stringByAppendingString: @" "];
				}
			}
			numberOfLines = lines;
		}

		int line;
		int maxLine = numberOfLines;
		NSArray *strings = [text componentsSeparatedByString: @" "];
		int holdX = 0;
		cairo_text_extents_t extents;

		if(frame.size.height < font.lineHeight*maxLine)
		{
			maxLine = frame.size.height/font.lineHeight;
		}
		for(line=0; line < maxLine; line++)
		{
			int x;

			cairo_text_extents(ref, " ", &extents);

			CGFloat spaceLength = extents.width;
			NSString *display = @"";
			NSString *backup = @"";
			for(x=holdX; x<[strings count]; x++)
			{
				backup = [display copy];
				display = [display stringByAppendingString: ((NSString*)[strings objectAtIndex:x])];
				cairo_text_extents(ref, [display UTF8String], &extents);
				if(extents.width > bounds.size.width)
				{
					display = [backup copy];
					break;
				}
				else
				{
					display = [display stringByAppendingString: @" "];
				}	
			}
			holdX = x;
			cairo_text_extents(ref, [display UTF8String], &extents);

			if(textAlignment == UITextAlignmentLeft)
			{
				cairo_move_to(ref, 0, ((bounds.size.height-font.lineHeight*maxLine)/2.0)-(extents.height/2.0)+(font.lineHeight*(line+1)));
			}
			else if(textAlignment == UITextAlignmentCenter)
			{
				cairo_move_to(ref, (bounds.size.width-extents.width)/2.0, ((bounds.size.height-font.lineHeight*maxLine)/2.0)-(extents.height/2.0)+(font.lineHeight*(line+1)));
			}
			else if(textAlignment == UITextAlignmentRight)
			{
				cairo_move_to(ref, (bounds.size.width-extents.width), ((bounds.size.height-font.lineHeight*maxLine)/2.0)-(extents.height/2.0)+(font.lineHeight*(line+1)));
			}
			double ptx, pty;
			cairo_get_current_point(ref, &ptx, &pty);

			CGColorGetComponents(shadowColor.CGColor, &components);
			CGContextSetRGBStrokeColor(ref, components[0], components[1], components[2], components[3]);

			cairo_move_to(ref, ptx+shadowOffset.width, pty+shadowOffset.height);
			cairo_text_path(ref, [display UTF8String]);
		
			cairo_fill(ref);

			CGColorGetComponents(textColor.CGColor, &components);
			CGContextSetRGBStrokeColor(ref, components[0], components[1], components[2], components[3]);

			cairo_move_to(ref, ptx, pty);
			cairo_text_path(ref, [display UTF8String]);
		
			cairo_fill(ref);
		}
	}	
	else if(lineBreakMode == UILineBreakModeCharacterWrap)
	{
		int line;
		int maxLine = numberOfLines;
		cairo_text_extents_t extents;
		const char* string = [text UTF8String];
		int holdX = 0;
		char* hold = malloc(sizeof(char));
		NSMutableArray *strings = [NSMutableArray arrayWithCapacity:0];

		int x;
		for(x=0; x<[text length]-1; x++)
		{
			hold[0] = string[x];
			[strings addObject: [[NSString alloc] initWithCharacters:(unichar const*)hold length:1]];
		}

		if(frame.size.height < font.lineHeight*maxLine)
		{
			maxLine = frame.size.height/font.lineHeight*maxLine;
		}

		for(line=0; line < maxLine; line++)
		{	
			cairo_text_extents(ref, " ", &extents);

			CGFloat spaceLength = extents.width;
			NSString *display = @"";
			NSString *backup = @"";
			for(x=holdX; x<[strings count]; x++)
			{
				backup = [display copy];
				display = [display stringByAppendingString: ((NSString*)[strings objectAtIndex:x])];
				cairo_text_extents(ref, [display UTF8String], &extents);
				if(extents.width > bounds.size.width)
				{
					display = [backup copy];
					break;
				}
			}
			holdX = x;
			cairo_text_extents(ref, [display UTF8String], &extents);

			if(textAlignment == UITextAlignmentLeft)
			{
				cairo_move_to(ref, 0, ((bounds.size.height-font.lineHeight*maxLine)/2.0)-(extents.height/2.0)+(font.lineHeight*(line+1)));
			}
			else if(textAlignment == UITextAlignmentCenter)
			{
				cairo_move_to(ref, (bounds.size.width-extents.width)/2.0, ((bounds.size.height-font.lineHeight*maxLine)/2.0)-(extents.height/2.0)+(font.lineHeight*(line+1)));
			}
			else if(textAlignment == UITextAlignmentRight)
			{
				cairo_move_to(ref, (bounds.size.width-extents.width), ((bounds.size.height-font.lineHeight*maxLine)/2.0)-(extents.height/2.0)+(font.lineHeight*(line+1)));
			}
			double ptx, pty;
			cairo_get_current_point(ref, &ptx, &pty);

			CGColorGetComponents(shadowColor.CGColor, &components);
			CGContextSetRGBStrokeColor(ref, components[0], components[1], components[2], components[3]);

			cairo_move_to(ref, ptx+shadowOffset.width, pty+shadowOffset.height);
			cairo_text_path(ref, [display UTF8String]);
		
			cairo_fill(ref);

			CGColorGetComponents(textColor.CGColor, &components);
			CGContextSetRGBStrokeColor(ref, components[0], components[1], components[2], components[3]);

			cairo_move_to(ref, ptx, pty);
			cairo_text_path(ref, [display UTF8String]);
		
			cairo_fill(ref);
		}
	}
	else if(lineBreakMode == UILineBreakModeClip)
	{
		int line = 0;
		int maxLine = numberOfLines;

		cairo_text_extents_t extents;
		cairo_text_extents(ref, [text UTF8String], &extents);

		cairo_surface_t *surface;
		CGContextRef surfaceCtx;

		if(frame.size.height < font.lineHeight*maxLine)
		{
			maxLine = frame.size.height/font.lineHeight*maxLine;
		}
		
		for(line=0; line<maxLine; line++)
		{
			surface = cairo_image_surface_create(CAIRO_FORMAT_ARGB32, bounds.size.width, extents.height);
			surfaceCtx = cairo_create(surface);
			CGContextSelectFont(surfaceCtx, [[font fontName] UTF8String], [font pointSize], kCGEncodingFontSpecific);
			CGContextShowTextAtPoint(surfaceCtx, -bounds.size.width*line, extents.height, [text UTF8String], [text length]);
			cairo_destroy(surfaceCtx);

			if(textAlignment == UITextAlignmentLeft)
			{
				cairo_set_source_surface(ref, surface, 0, ((bounds.size.height-font.lineHeight*maxLine)/2.0)+(extents.height/2.0)+(font.lineHeight*(line)));
			}
			else if(textAlignment == UITextAlignmentCenter)
			{
				cairo_set_source_surface(ref, surface, (bounds.size.width-extents.width)/2.0, ((bounds.size.height-font.lineHeight*maxLine)/2.0)-(extents.height/2.0)+(font.lineHeight*(line+1)));
			}
			else if(textAlignment == UITextAlignmentRight)
			{
				cairo_set_source_surface(ref, surface, (bounds.size.width-extents.width), ((bounds.size.height-font.lineHeight*maxLine)/2.0)-(extents.height/2.0)+(font.lineHeight*(line+1)));
			}
			cairo_paint(ref);
		}
	}
	else if(lineBreakMode == UILineBreakModeHeadTruncation)
	{
		const char* letters = [text UTF8String];

		char* hold = malloc(sizeof(char));
		int line;
		NSString *textLine = @"";
		int maxLine = numberOfLines;
		NSArray *strings = [text componentsSeparatedByString: @" "];
		NSString *display = @"";
		NSString *backup = @"";
		int holdX = 0;
		cairo_text_extents_t extents;

		if(frame.size.height < font.lineHeight*maxLine)
		{
			maxLine = frame.size.height/font.lineHeight*maxLine;
		}
		for(line=0; line < maxLine; line++)
		{
			int x;

			cairo_text_extents(ref, " ", &extents);

			CGFloat spaceLength = extents.width;
			display = @"";
			backup = @"";
			if(line == maxLine-1)
			{
				for(x=[text length]-1; x>=0; x--)
				{
					hold[0] = letters[x];
					textLine = [[NSString stringWithUTF8String: hold] stringByAppendingString: textLine];
					display = [@"..." stringByAppendingString: textLine];
					cairo_text_extents(ref, [display UTF8String], &extents);
					if(extents.width > bounds.size.width)
					{	
						display = [display substringFromIndex:1];
						break;
					}	
				}
			}
			else
			{
				for(x=holdX; x<[strings count]; x++)
				{
					backup = [display copy];
					display = [display stringByAppendingString: ((NSString*)[strings objectAtIndex:x])];
					cairo_text_extents(ref, [display UTF8String], &extents);
					if(extents.width > bounds.size.width)
					{
						display = [backup copy];
						break;
					}
					else
					{
						display = [display stringByAppendingString: @" "];
					}	
				}
				holdX = x;
				cairo_text_extents(ref, [display UTF8String], &extents);
			}

			if(textAlignment == UITextAlignmentLeft)
			{
				cairo_move_to(ref, 0, ((bounds.size.height-font.lineHeight*maxLine)/2.0)-(extents.height/2.0)+(font.lineHeight*(line+1)));
			}
			else if(textAlignment == UITextAlignmentCenter)
			{
				cairo_move_to(ref, (bounds.size.width-extents.width)/2.0, ((bounds.size.height-font.lineHeight*maxLine)/2.0)-(extents.height/2.0)+(font.lineHeight*(line+1)));
			}
			else if(textAlignment == UITextAlignmentRight)
			{
				cairo_move_to(ref, (bounds.size.width-extents.width), ((bounds.size.height-font.lineHeight*maxLine)/2.0)-(extents.height/2.0)+(font.lineHeight*(line+1)));
			}
			double ptx, pty;
			cairo_get_current_point(ref, &ptx, &pty);

			CGColorGetComponents(shadowColor.CGColor, &components);
			CGContextSetRGBStrokeColor(ref, components[0], components[1], components[2], components[3]);

			cairo_move_to(ref, ptx+shadowOffset.width, pty+shadowOffset.height);
			cairo_text_path(ref, [display UTF8String]);
		
			cairo_fill(ref);

			CGColorGetComponents(textColor.CGColor, &components);
			CGContextSetRGBStrokeColor(ref, components[0], components[1], components[2], components[3]);

			cairo_move_to(ref, ptx, pty);
			cairo_text_path(ref, [display UTF8String]);
		
			cairo_fill(ref);
		}
	}
	else if(lineBreakMode == UILineBreakModeTailTruncation)
	{
		const char* letters = [text UTF8String];

		char* hold = malloc(sizeof(char));
		int line;
		NSString *textLine = @"";
		int maxLine = numberOfLines;
		NSArray *strings = [text componentsSeparatedByString: @" "];
		NSString *display = @"";
		NSString *backup = @"";
		int holdX = 0;
		cairo_text_extents_t extents;

		if(frame.size.height < font.lineHeight*maxLine)
		{
			maxLine = frame.size.height/font.lineHeight*maxLine;
		}
		for(line=0; line < maxLine; line++)
		{
			int x;

			cairo_text_extents(ref, " ", &extents);

			CGFloat spaceLength = extents.width;
			display = @"";
			backup = @"";
			if(line == maxLine-1)
			{
				for(x=0; x<[text length]; x++)
				{
					hold[0] = letters[x];
					textLine = [textLine stringByAppendingString: [NSString stringWithUTF8String: hold]];
					display = [textLine stringByAppendingString: @"..."];
					cairo_text_extents(ref, [display UTF8String], &extents);
					if(extents.width > bounds.size.width)
					{
						textLine = [textLine substringToIndex: [textLine length]-2];
				
						display = [textLine stringByAppendingString: @"..."];
						break;
					}	
				}
			}
			else
			{
				for(x=holdX; x<[strings count]; x++)
				{
					backup = [display copy];
					display = [display stringByAppendingString: ((NSString*)[strings objectAtIndex:x])];
					cairo_text_extents(ref, [display UTF8String], &extents);
					if(extents.width > bounds.size.width)
					{
						display = [backup copy];
						break;
					}
					else
					{
						display = [display stringByAppendingString: @" "];
					}	
				}
				holdX = x;
				cairo_text_extents(ref, [display UTF8String], &extents);
			}

			if(textAlignment == UITextAlignmentLeft)
			{
				cairo_move_to(ref, 0, ((bounds.size.height-font.lineHeight*maxLine)/2.0)-(extents.height/2.0)+(font.lineHeight*(line+1)));
			}
			else if(textAlignment == UITextAlignmentCenter)
			{
				cairo_move_to(ref, (bounds.size.width-extents.width)/2.0, ((bounds.size.height-font.lineHeight*maxLine)/2.0)-(extents.height/2.0)+(font.lineHeight*(line+1)));
			}
			else if(textAlignment == UITextAlignmentRight)
			{
				cairo_move_to(ref, (bounds.size.width-extents.width), ((bounds.size.height-font.lineHeight*maxLine)/2.0)-(extents.height/2.0)+(font.lineHeight*(line+1)));
			}
			double ptx, pty;
			cairo_get_current_point(ref, &ptx, &pty);

			CGColorGetComponents(shadowColor.CGColor, &components);
			CGContextSetRGBStrokeColor(ref, components[0], components[1], components[2], components[3]);

			cairo_move_to(ref, ptx+shadowOffset.width, pty+shadowOffset.height);
			cairo_text_path(ref, [display UTF8String]);
		
			cairo_fill(ref);

			CGColorGetComponents(textColor.CGColor, &components);
			CGContextSetRGBStrokeColor(ref, components[0], components[1], components[2], components[3]);

			cairo_move_to(ref, ptx, pty);
			cairo_text_path(ref, [display UTF8String]);
		
			cairo_fill(ref);
		}
	}
	else if(lineBreakMode == UILineBreakModeMiddleTruncation)
	{
		const char* letters = [text UTF8String];

		NSString *line1 = [NSString string];
		NSString *line2 = [NSString string];
		int tracker1 = 0;
		int tracker2 = [text length]-1;

		char* hold = malloc(sizeof(char));
		int line;
		int maxLine = numberOfLines;
		NSArray *strings = [text componentsSeparatedByString: @" "];
		NSString *display = @"";
		NSString *backup = @"";
		int holdX = 0;
		cairo_text_extents_t extents;

		if(frame.size.height < font.lineHeight*maxLine)
		{
			maxLine = frame.size.height/font.lineHeight*maxLine;
		}
		for(line=0; line < maxLine; line++)
		{
			int x;

			cairo_text_extents(ref, " ", &extents);

			CGFloat spaceLength = extents.width;
			display = @"";
			backup = @"";
			if(line == maxLine-1)
			{
				for(x=0; x<([text length]-1)/2.0; x++)
				{
					hold[0] = letters[tracker1];
					line1 = [line1 stringByAppendingString: [NSString stringWithUTF8String: hold]];
					hold[0] = letters[tracker2];
					line2 = [[NSString stringWithUTF8String: hold] stringByAppendingString: line2];

					tracker1++;
					tracker2--;
			
					display = [[line1 stringByAppendingString: @"..."] stringByAppendingString: line2];
					cairo_text_extents(ref, [display UTF8String], &extents);
					if(extents.width > bounds.size.width)
					{
						line1 = [line1 substringToIndex: [line1 length]-2];
						line2 = [line2 substringFromIndex: 1];
						display = [[line1 stringByAppendingString: @"..."] stringByAppendingString: line2];
						break;
					}	
				}
			}
			else
			{
				for(x=holdX; x<[strings count]; x++)
				{
					backup = [display copy];
					display = [display stringByAppendingString: ((NSString*)[strings objectAtIndex:x])];
					cairo_text_extents(ref, [display UTF8String], &extents);
					if(extents.width > bounds.size.width)
					{
						display = [backup copy];
						break;
					}
					else
					{
						display = [display stringByAppendingString: @" "];
					}	
				}
				holdX = x;
				cairo_text_extents(ref, [display UTF8String], &extents);
			}

			if(textAlignment == UITextAlignmentLeft)
			{
				cairo_move_to(ref, 0, ((bounds.size.height-font.lineHeight*maxLine)/2.0)-(extents.height/2.0)+(font.lineHeight*(line+1)));
			}
			else if(textAlignment == UITextAlignmentCenter)
			{
				cairo_move_to(ref, (bounds.size.width-extents.width)/2.0, ((bounds.size.height-font.lineHeight*maxLine)/2.0)-(extents.height/2.0)+(font.lineHeight*(line+1)));
			}
			else if(textAlignment == UITextAlignmentRight)
			{
				cairo_move_to(ref, (bounds.size.width-extents.width), ((bounds.size.height-font.lineHeight*maxLine)/2.0)-(extents.height/2.0)+(font.lineHeight*(line+1)));
			}
			double ptx, pty;
			cairo_get_current_point(ref, &ptx, &pty);

			CGColorGetComponents(shadowColor.CGColor, &components);
			CGContextSetRGBStrokeColor(ref, components[0], components[1], components[2], components[3]);

			cairo_move_to(ref, ptx+shadowOffset.width, pty+shadowOffset.height);
			cairo_text_path(ref, [display UTF8String]);
		
			cairo_fill(ref);

			CGColorGetComponents(textColor.CGColor, &components);
			CGContextSetRGBStrokeColor(ref, components[0], components[1], components[2], components[3]);

			cairo_move_to(ref, ptx, pty);
			cairo_text_path(ref, [display UTF8String]);
		
			cairo_fill(ref);
		}
	}
	free(components);
}
@end
