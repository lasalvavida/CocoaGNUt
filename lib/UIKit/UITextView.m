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
#import <UIKit/UITextView.h>
#import <UIKit/UIKit.h>

@implementation UITextViewCursor
@synthesize cursor;
-(void)drawRect:(CGRect)rect
{
	CGContextRef ref = UIGraphicsGetCurrentContext();
	cairo_rectangle(ref, cursor.x, cursor.y, 2, ((UITextView*)self.superview).font.ascender);
	cairo_set_source_rgb(ref, 0.0f, 0.0f, 1.0f);
	cairo_fill(ref);
}
@end

@implementation UITextView
@synthesize text;
@synthesize font;
@synthesize textColor;
@synthesize editable;
@synthesize textAlignment;
@synthesize selectedRange;
@synthesize inputAccessoryView;
@synthesize inputView;
-(id)initWithFrame:(CGRect)aRect
{
	self = [super initWithFrame: aRect];
	font = [UIFont fontWithName:@"Helvetica" size:17];
	textColor = [UIColor blackColor];
	textAlignment = UITextAlignmentLeft;

	label = [[UILabel alloc] initWithFrame: aRect];
	label.font = font;
	label.textColor = textColor;
	label.textAlignment = textAlignment;
	label.lineBreakMode = UILineBreakModeWordWrap;
	label.numberOfLines = -1;
	label.contentMode = UIViewContentModeTop;

	cursorView = [[UITextViewCursor alloc] initWithFrame: aRect];
	cursorView.cursor = CGPointMake(0.0f, 0.0f);

	[self addSubview: label];
	[self addSubview: cursorView];

	return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

	startTouch = [touches anyObject];

	[super touchesBegan:touches withEvent:event];

	selectedRange = [self coordinatesToRange:[startTouch locationInView:self]];
	cursorView.cursor = [self rangeToCoordinates: selectedRange];
	[cursorView setNeedsDisplay];

}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

	if(CGPointEqualToPoint([[touches anyObject] locationInView:self], [startTouch locationInView:self]))
	{
		selectedRange = [self coordinatesToRange:[startTouch locationInView:self]];
		cursorView.cursor = [self rangeToCoordinates: selectedRange];
		[cursorView setNeedsDisplay];
	}

	[super touchesEnded:touches withEvent:event];
}
-(NSRange)coordinatesToRange:(CGPoint)point
{
	CGContextRef ref = cairo_create(self.layer);
	cairo_text_extents_t extents;
	cairo_text_extents(ref, [text UTF8String], &extents);
	CGContextSelectFont(ref, [[font fontName] UTF8String], [font pointSize], kCGEncodingFontSpecific);

	NSMutableArray *strings = [NSMutableArray arrayWithCapacity:0];
	NSString* display = @"";

	int lines = 0;
	int x;
	NSRange textPiece;
	textPiece.length = 1;
	for(x=0; x<[text length]-1; x++)
	{
		textPiece.location = x;
		[strings addObject: [text substringWithRange:textPiece]];
	}

	CGFloat xCoord = point.x+self.bounds.origin.x;
	CGFloat yCoord = point.y+self.bounds.origin.y;

	BOOL sentinel = NO;
	NSRange range;

	int hold;

	for(x=0; x<[strings count]; x++)
	{
		if([[strings objectAtIndex:x] isEqualToString: @" "])
		{
			hold = x;
		}
		display = [display stringByAppendingString: ((NSString*)[strings objectAtIndex:x])];
		cairo_text_extents(ref, [display UTF8String], &extents);
		if(sentinel)
		{
			if(extents.width > xCoord)
			{
				range.location = x;
				return range;
			}
		}
		else if(extents.width > bounds.size.width)
		{
			if([strings objectAtIndex:x] != @" ")
			{
				x = hold;
			}
			else
			{
				x--;
			}
			lines++;
			display = @"";
		}
		if(lines == (int)(yCoord/font.lineHeight))
		{
			sentinel = YES;
		}
	}
	return range;
}
-(CGPoint)rangeToCoordinates:(NSRange)range
{
	CGContextRef ref = cairo_create(self.layer);
	cairo_text_extents_t extents;
	cairo_text_extents(ref, [text UTF8String], &extents);
	CGContextSelectFont(ref, [[font fontName] UTF8String], [font pointSize], kCGEncodingFontSpecific);

	NSMutableArray *strings = [NSMutableArray arrayWithCapacity:0];
	NSString* display = @"";

	int lines = 0;
	int x;
	NSRange textPiece;
	textPiece.length = 1;
	for(x=0; x<[text length]-1; x++)
	{
		textPiece.location = x;
		[strings addObject: [text substringWithRange:textPiece]];
	}

	BOOL sentinel = NO;

	int hold;

	for(x=0; x<[strings count]; x++)
	{
		if([[strings objectAtIndex:x] isEqualToString: @" "])
		{
			hold = x;
		}
		display = [display stringByAppendingString: ((NSString*)[strings objectAtIndex:x])];
		cairo_text_extents(ref, [display UTF8String], &extents);
		if(extents.width > bounds.size.width)
		{
			if([strings objectAtIndex:x] != @" ")
			{
				x = hold;
			}
			else
			{
				x--;
			}
			lines++;
			display = @"";
		}
		if(x == range.location)
		{
			return CGPointMake(extents.width, lines*font.lineHeight);
		}
	}
	return CGPointMake(0.0f, 0.0f);
}
-(BOOL)hasText
{
	if(text != nil)
	{
		if([text length] != 0)
		{
			return YES;
		}
	}
	return NO;
}
-(void)drawRect:(CGRect)rect
{
	CGContextRef ref = cairo_create(self.layer);
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
	lines++;
	label.numberOfLines = lines;
	label.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, lines*font.lineHeight);
	contentSize = CGSizeMake(label.frame.size.width, label.frame.size.height);
	cursorView.frame = label.frame;

	if(!init)
	{
		cairo_surface_destroy(label.layer);
		label.layer = cairo_image_surface_create(CAIRO_FORMAT_ARGB32, label.bounds.size.width, label.bounds.size.height);
	}
}
-(void)scrollRangeToVisible:(NSRange)range
{
	CGPoint point = [self rangeToCoordinates:range];
	if(!CGRectContainsPoint(self.frame, point))
	{
		if(point.x+self.bounds.size.width > label.bounds.size.width)
		{
			point.x = label.bounds.size.width-self.bounds.size.width;
		}
		if(point.y+self.bounds.size.height > label.bounds.size.height)
		{
			point.y = label.bounds.size.height-self.bounds.size.height;
		}
		[self setContentOffset: CGPointMake(point.x, point.y) animated: YES];
	}
}
-(void)setText:(NSString *)txt
{
	text = txt;
	label.text = txt;
	
	[self setNeedsDisplay];
	[cursorView setNeedsDisplay];
	[label setNeedsDisplay];
}
-(void)setFont:(UIFont*)fnt
{
	font = fnt;
	label.font = fnt;
}
-(void)setTextColor:(UIColor*)color
{
	textColor = color;
	label.textColor = color;
}
-(void)receiveInput:(NSString*)input
{
	if(input == nil)
	{
		[self setText:[[text substringToIndex: selectedRange.location] stringByAppendingString: [text substringFromIndex: selectedRange.location+1]]];
		selectedRange.location--;
	}
	else
	{
		NSString *part1 = [text substringToIndex: selectedRange.location+1];
		NSString *part2 = [text substringFromIndex: selectedRange.location+1];
		part1 = [part1 stringByAppendingString: input];
		[self setText:[part1 stringByAppendingString:part2]];
		selectedRange.location++;
	}
	cursorView.cursor = [self rangeToCoordinates: selectedRange];
	[cursorView setNeedsDisplay];
	[self scrollRangeToVisible: selectedRange];
}
-(BOOL)resignFirstResponder
{
	if(firstResponder)
	{
		[UIApplicationGetGlobalKeyboard() dismiss];
	}
	firstResponder = NO;
	return YES;
}
-(BOOL)becomeFirstResponder
{
	if([self canBecomeFirstResponder])
	{
		firstResponder = YES;
		[UIApplicationGetGlobalKeyboard() show];
		UIApplicationGetGlobalKeyboard().target=self;
		return YES;
	}
	else
	{
		return NO;
	}
}
@end
