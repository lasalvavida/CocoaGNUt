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
#import <UIKit/UIKeyboard.h>
#import <UIKit/UIKit.h>

/*As it stands, the keyboard doesn't support landscape as the accelerometer hasn't been programmed yet. When that happens, this code needs to be modified. This can be done one of two ways:
-make the size allocation for the keys more dynamic
-add extra potential subviews and swap them the same way that it works now*/

NSString* rowChar1Caps[10] = {@"Q", @"W", @"E", @"R", @"T", @"Y", @"U", @"I", @"O", @"P"};
NSString* rowChar1Lower[10] = {@"q", @"w", @"e", @"r", @"t", @"y", @"u", @"i", @"o", @"p"};

NSString* rowChar2Caps[9] = {@"A", @"S", @"D", @"F", @"G", @"H", @"J", @"K", @"L"};
NSString* rowChar2Lower[9] = {@"a", @"s", @"d", @"f", @"g", @"h", @"j", @"k", @"l"};

NSString* rowChar3Caps[7] = {@"Z", @"X", @"C", @"V", @"B", @"N", @"M"};
NSString* rowChar3Lower[7] = {@"z", @"x", @"c", @"v", @"b", @"n", @"m"};

NSString* rowSym1Reg[10] = {@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0"};
NSString* rowSym1Alt[10] = {@"[", @"]", @"{", @"}", @"#", @"%", @"^", @"*", @"+", @"="};

NSString* rowSym2Reg[10] = {@"-", @"/", @":", @";", @"(", @")", @"$", @"&", @"@", @"\""};
NSString* rowSym2Alt[10] = {@"_", @"\\", @"|", @"~", @"<", @">", @"¢", @"£", @"¥", @"·"};

NSString* rowSym3Reg[5] = {@".", @",", @"?", @"!", @"'"};

@implementation UIKeySpacebar
-(void)drawRect:(CGRect)rect
{
	CGFloat components[8] = {0.9, 0.9, 0.9, 1.0, 0.75, 0.75, 0.75, 1.0};
	CGFloat locations[2] = {0.0, 1.0};
	CGPoint startPoint = CGPointMake(0.0, 0.0);
	CGPoint endPoint = CGPointMake(0.0, self.frame.size.height);

	CGContextRef ref = UIGraphicsGetCurrentContext();
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, locations, 2);

	CGContextSaveGState(ref);
	CGContextAddRect(ref, CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height));
	CGContextClip(ref);
	CGContextDrawLinearGradient(ref, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
	CGContextRestoreGState(ref);

	cairo_text_extents_t extents;
	cairo_text_extents(ref, "space", &extents);
	int x, y;
	x = (self.frame.size.width/2)-(extents.width + extents.x_bearing);
	y = (self.frame.size.height/2)-(extents.height + extents.y_bearing);

	CGContextSetRGBStrokeColor(ref, 0.5, 0.5, 0.5, 1.0);
	CGContextSelectFont(ref, "sans-serif", 18, kCGEncodingFontSpecific);
	CGContextShowTextAtPoint(ref, x, y, "space", 1);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[((UIKeyboard*)self.superview).target receiveInput: @" "];
}
@end

@implementation UIKeyBackspace
-(void)drawRect:(CGRect)rect
{
	CGFloat components[8] = {0.55, 0.58, 0.62, 1.0, .27, .33, .4, 1.0};
	CGFloat locations[2] = {0.0, 1.0};
	CGPoint startPoint = CGPointMake(0.0, 0.0);
	CGPoint endPoint = CGPointMake(0.0, self.frame.size.height);

	CGContextRef ref = UIGraphicsGetCurrentContext();
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, locations, 2);

	CGContextSaveGState(ref);
	CGContextAddRect(ref, CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height));
	CGContextClip(ref);
	CGContextDrawLinearGradient(ref, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
	CGContextRestoreGState(ref);

	cairo_move_to(ref, self.frame.size.width/8, self.frame.size.height/2);
	cairo_line_to(ref, self.frame.size.width/4, self.frame.size.height/4);
	cairo_line_to(ref, self.frame.size.width-self.frame.size.width/8, self.frame.size.height/4);
	cairo_line_to(ref, self.frame.size.width-self.frame.size.width/8, self.frame.size.height-self.frame.size.height/4);
	cairo_line_to(ref, self.frame.size.width/4, self.frame.size.height-self.frame.size.height/4);
	cairo_line_to(ref, self.frame.size.width/8, self.frame.size.height/2);

	cairo_set_source_rgba(ref, 1.0, 1.0, 1.0, 1.0);
	cairo_fill(ref);

	cairo_move_to(ref, self.frame.size.width/2-self.frame.size.width/8, self.frame.size.height/2-self.frame.size.height/8);
	cairo_line_to(ref, self.frame.size.width/2+self.frame.size.width/8, self.frame.size.height/2+self.frame.size.height/8);
	cairo_move_to(ref, self.frame.size.width/2+self.frame.size.width/8, self.frame.size.height/2-self.frame.size.height/8);
	cairo_line_to(ref, self.frame.size.width/2-self.frame.size.width/8, self.frame.size.height/2+self.frame.size.height/8);
	
	cairo_set_source_rgba(ref, 0.55, 0.58, 0.62, 1.0);
	cairo_stroke(ref);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[((UIKeyboard*)self.superview).target receiveInput: nil];
}
@end

@implementation UIKeyReturn
-(void)drawRect:(CGRect)rect
{
	CGFloat components[8] = {0.55, 0.58, 0.62, 1.0, .27, .33, .4, 1.0};
	CGFloat locations[2] = {0.0, 1.0};
	CGPoint startPoint = CGPointMake(0.0, 0.0);
	CGPoint endPoint = CGPointMake(0.0, self.frame.size.height);

	CGContextRef ref = UIGraphicsGetCurrentContext();
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, locations, 2);

	CGContextSaveGState(ref);
	CGContextAddRect(ref, CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height));
	CGContextClip(ref);
	CGContextDrawLinearGradient(ref, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
	CGContextRestoreGState(ref);

	cairo_text_extents_t extents;
	cairo_text_extents(ref, "return", &extents);
	int x, y;
	x = (self.frame.size.width/2)-(extents.width + extents.x_bearing);
	y = (self.frame.size.height/2)-(extents.height + extents.y_bearing);

	CGContextSetRGBStrokeColor(ref, 1.0, 1.0, 1.0, 1.0);
	CGContextSelectFont(ref, "sans-serif", 18, kCGEncodingFontSpecific);
	CGContextShowTextAtPoint(ref, x, y, "return", 1);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[((UIKeyboard*)self.superview).target receiveInput: @"\n"];
}
@end

@implementation UIKeyTogglePrimary
-(void)drawRect:(CGRect)rect
{
	CGFloat components[8] = {0.55, 0.58, 0.62, 1.0, .27, .33, .4, 1.0};
	CGFloat locations[2] = {0.0, 1.0};
	CGPoint startPoint = CGPointMake(0.0, 0.0);
	CGPoint endPoint = CGPointMake(0.0, self.frame.size.height);

	CGContextRef ref = UIGraphicsGetCurrentContext();
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, locations, 2);

	CGContextSaveGState(ref);
	CGContextAddRect(ref, CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height));
	CGContextClip(ref);
	CGContextDrawLinearGradient(ref, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
	CGContextRestoreGState(ref);

	if(((UIKeyboard*)self.superview).mode == UIKeyboardModeCharCaps || ((UIKeyboard*)self.superview).mode == UIKeyboardModeCharLower)
	{
		cairo_text_extents_t extents;
		cairo_text_extents(ref, ".?123", &extents);
		int x, y;
		x = (self.frame.size.width/2)-(extents.width + extents.x_bearing);
		y = (self.frame.size.height/2)-(extents.height + extents.y_bearing);

		CGContextSetRGBStrokeColor(ref, 1.0, 1.0, 1.0, 1.0);
		CGContextSelectFont(ref, "sans-serif", 18, kCGEncodingFontSpecific);
		CGContextShowTextAtPoint(ref, x, y, ".?123", 1);
	}
	if(((UIKeyboard*)self.superview).mode == UIKeyboardModeSymReg || ((UIKeyboard*)self.superview).mode == UIKeyboardModeSymAlt)
	{
		cairo_text_extents_t extents;
		cairo_text_extents(ref, "ABC", &extents);
		int x, y;
		x = (self.frame.size.width/2)-(extents.width + extents.x_bearing);
		y = (self.frame.size.height/2)-(extents.height + extents.y_bearing);

		CGContextSetRGBStrokeColor(ref, 1.0, 1.0, 1.0, 1.0);
		CGContextSelectFont(ref, "sans-serif", 18, kCGEncodingFontSpecific);
		CGContextShowTextAtPoint(ref, x, y, "ABC", 1);
	}
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(((UIKeyboard*)self.superview).mode == UIKeyboardModeCharCaps || ((UIKeyboard*)self.superview).mode == UIKeyboardModeCharLower)
	{
		[((UIKeyboard*)self.superview) setMode: UIKeyboardModeSymReg];
	}
	else if(((UIKeyboard*)self.superview).mode == UIKeyboardModeSymReg || ((UIKeyboard*)self.superview).mode == UIKeyboardModeSymAlt)
	{
		[((UIKeyboard*)self.superview) setMode: UIKeyboardModeCharCaps];
	}
}
@end

@implementation UIKeyToggleSecondary
-(void)drawRect:(CGRect)rect
{
	CGFloat components[8] = {0.55, 0.58, 0.62, 1.0, .27, .33, .4, 1.0};
	CGFloat locations[2] = {0.0, 1.0};
	CGPoint startPoint = CGPointMake(0.0, 0.0);
	CGPoint endPoint = CGPointMake(0.0, self.frame.size.height);

	CGContextRef ref = UIGraphicsGetCurrentContext();
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, locations, 2);

	CGContextSaveGState(ref);
	CGContextAddRect(ref, CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height));
	CGContextClip(ref);
	CGContextDrawLinearGradient(ref, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
	CGContextRestoreGState(ref);

	if(((UIKeyboard*)self.superview).mode == UIKeyboardModeCharCaps)
	{
		cairo_move_to(ref, self.frame.size.width/2, self.frame.size.height/4);
		cairo_line_to(ref, self.frame.size.width-self.frame.size.width/8, self.frame.size.height/2);
		cairo_line_to(ref, self.frame.size.width-self.frame.size.width/4, self.frame.size.height/2);
		cairo_line_to(ref, self.frame.size.width-self.frame.size.width/4, self.frame.size.height-self.frame.size.height/4);
		cairo_line_to(ref, self.frame.size.width/4, self.frame.size.height-self.frame.size.height/4);
		cairo_line_to(ref, self.frame.size.width/4, self.frame.size.height/2);
		cairo_line_to(ref, self.frame.size.width/8, self.frame.size.height/2);
		cairo_line_to(ref, self.frame.size.width/2, self.frame.size.height/4);

		CGContextSetRGBStrokeColor(ref, 1.0, 1.0, 1.0, 1.0);
		cairo_fill(ref);
	}
	else if(((UIKeyboard*)self.superview).mode == UIKeyboardModeCharLower)
	{
		cairo_move_to(ref, self.frame.size.width/2, self.frame.size.height/4);
		cairo_line_to(ref, self.frame.size.width-self.frame.size.width/8, self.frame.size.height/2);
		cairo_line_to(ref, self.frame.size.width-self.frame.size.width/4, self.frame.size.height/2);
		cairo_line_to(ref, self.frame.size.width-self.frame.size.width/4, self.frame.size.height-self.frame.size.height/4);
		cairo_line_to(ref, self.frame.size.width/4, self.frame.size.height-self.frame.size.height/4);
		cairo_line_to(ref, self.frame.size.width/4, self.frame.size.height/2);
		cairo_line_to(ref, self.frame.size.width/8, self.frame.size.height/2);
		cairo_line_to(ref, self.frame.size.width/2, self.frame.size.height/4);

		CGContextSetRGBStrokeColor(ref, 1.0, 1.0, 1.0, 1.0);
		cairo_stroke(ref);
	}
	else if(((UIKeyboard*)self.superview).mode == UIKeyboardModeSymReg)
	{
		cairo_text_extents_t extents;
		cairo_text_extents(ref, "#+=", &extents);
		int x, y;
		x = (self.frame.size.width/2)-(extents.width + extents.x_bearing);
		y = (self.frame.size.height/2)-(extents.height + extents.y_bearing);

		CGContextSetRGBStrokeColor(ref, 1.0, 1.0, 1.0, 1.0);
		CGContextSelectFont(ref, "sans-serif", 16, kCGEncodingFontSpecific);
		CGContextShowTextAtPoint(ref, x, y, "#+=", 1);
	}
	else if(((UIKeyboard*)self.superview).mode == UIKeyboardModeSymAlt)
	{
		cairo_text_extents_t extents;
		cairo_text_extents(ref, "123", &extents);
		int x, y;
		x = (self.frame.size.width/2)-(extents.width + extents.x_bearing);
		y = (self.frame.size.height/2)-(extents.height + extents.y_bearing);

		CGContextSetRGBStrokeColor(ref, 1.0, 1.0, 1.0, 1.0);
		CGContextSelectFont(ref, "sans-serif", 16, kCGEncodingFontSpecific);
		CGContextShowTextAtPoint(ref, x, y, "123", 1);
	}
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(((UIKeyboard*)self.superview).mode == UIKeyboardModeCharCaps)
	{
		[((UIKeyboard*)self.superview) setMode: UIKeyboardModeCharLower];
	}
	else if(((UIKeyboard*)self.superview).mode == UIKeyboardModeCharLower)
	{
		[((UIKeyboard*)self.superview) setMode: UIKeyboardModeCharCaps];
	}
	else if(((UIKeyboard*)self.superview).mode == UIKeyboardModeSymReg)
	{
		[((UIKeyboard*)self.superview) setMode: UIKeyboardModeSymAlt];
	}
	else if(((UIKeyboard*)self.superview).mode == UIKeyboardModeSymAlt)
	{
		[((UIKeyboard*)self.superview) setMode: UIKeyboardModeSymReg];
	}
}
@end

@implementation UIKey
-(void)setKey:(NSString*)string
{
	key = string;
}
-(void)drawRect:(CGRect)rect
{
	CGFloat components[8] = {0.9, 0.9, 0.9, 1.0, 0.75, 0.75, 0.75, 1.0};
	CGFloat locations[2] = {0.0, 1.0};
	CGPoint startPoint = CGPointMake(0.0, 0.0);
	CGPoint endPoint = CGPointMake(0.0, self.frame.size.height);

	CGContextRef ref = UIGraphicsGetCurrentContext();
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, locations, 2);

	CGContextSaveGState(ref);
	CGContextAddRect(ref, CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height));
	CGContextClip(ref);
	CGContextDrawLinearGradient(ref, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
	CGContextRestoreGState(ref);

	cairo_text_extents_t extents;
	cairo_text_extents(ref, [key UTF8String], &extents);
	int x, y;
	x = (self.frame.size.width/2)-(extents.width + extents.x_bearing);
	y = (self.frame.size.height/2)-(extents.height + extents.y_bearing);

	CGContextSetRGBStrokeColor(ref, 0.0, 0.0, 0.0, 1.0);
	CGContextSelectFont(ref, "sans-serif", 20, kCGEncodingFontSpecific);
	CGContextShowTextAtPoint(ref, x, y, [key UTF8String], 1);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[((UIKeyboard*)self.superview.superview).target receiveInput: key];
}
@end

@implementation UIKeyboard
@synthesize mode;
@synthesize target;
-(id)initKeyboard
{
	self = [super initWithFrame: CGRectMake(0.0f, 480.0f, 320.0f, 216.0f)];

	charKeyCaps = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
	charKeyLower = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
	symKeyReg = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
	symKeyAlt = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];

	mode = UIKeyboardModeCharCaps;

	int x;

	//set up charKeyCaps
	int posX=0;
	int posY=10;
	for(x=0; x<10; x++)
	{
		posX += 2;
		[charKeyCaps addSubview: [[UIKey alloc] initWithFrame: CGRectMake(posX, posY, 28, 40)]];
		posX += 30;
	}
	for(x=0; x<10; x++)
	{
		[((UIKey*)[charKeyCaps.subviews objectAtIndex:x]) setKey: rowChar1Caps[x]];
	}

	posX=16;
	posY=60;
	for(x=0; x<9; x++)
	{
		posX += 2;
		[charKeyCaps addSubview: [[UIKey alloc] initWithFrame: CGRectMake(posX, posY, 28, 40)]];
		posX += 30;
	}
	for(x=0; x<9; x++)
	{
		[((UIKey*)[charKeyCaps.subviews objectAtIndex:x+10]) setKey: rowChar2Caps[x]];
	}

	posX=48;
	posY=110;
	for(x=0; x<7; x++)
	{
		posX += 2;
		[charKeyCaps addSubview: [[UIKey alloc] initWithFrame: CGRectMake(posX, posY, 28, 40)]];
		posX += 30;
	}
	for(x=0; x<7; x++)
	{
		[((UIKey*)[charKeyCaps.subviews objectAtIndex:x+19]) setKey: rowChar3Caps[x]];
	}

	//set up charKeyLower
	posX=0;
	posY=10;
	for(x=0; x<10; x++)
	{
		posX += 2;
		[charKeyLower addSubview: [[UIKey alloc] initWithFrame: CGRectMake(posX, posY, 28, 40)]];
		posX += 30;
	}
	for(x=0; x<10; x++)
	{
		[((UIKey*)[charKeyLower.subviews objectAtIndex:x]) setKey: rowChar1Lower[x]];
	}

	posX=16;
	posY=60;
	for(x=0; x<9; x++)
	{
		posX += 2;
		[charKeyLower addSubview: [[UIKey alloc] initWithFrame: CGRectMake(posX, posY, 28, 40)]];
		posX += 30;
	}
	for(x=0; x<9; x++)
	{
		[((UIKey*)[charKeyLower.subviews objectAtIndex:x+10]) setKey: rowChar2Lower[x]];
	}

	posX=48;
	posY=110;
	for(x=0; x<7; x++)
	{
		posX += 2;
		[charKeyLower addSubview: [[UIKey alloc] initWithFrame: CGRectMake(posX, posY, 28, 40)]];
		posX += 30;
	}
	for(x=0; x<7; x++)
	{
		[((UIKey*)[charKeyLower.subviews objectAtIndex:x+19]) setKey: rowChar3Lower[x]];
	}
	
	//set up symKeyReg
	posX=0;
	posY=10;
	for(x=0; x<10; x++)
	{
		posX += 2;
		[symKeyReg addSubview: [[UIKey alloc] initWithFrame: CGRectMake(posX, posY, 28, 40)]];
		posX += 30;
	}
	for(x=0; x<10; x++)
	{
		[((UIKey*)[symKeyReg.subviews objectAtIndex:x]) setKey: rowSym1Reg[x]];
	}

	posX=0;
	posY=60;
	for(x=0; x<10; x++)
	{
		posX += 2;
		[symKeyReg addSubview: [[UIKey alloc] initWithFrame: CGRectMake(posX, posY, 28, 40)]];
		posX += 30;
	}
	for(x=0; x<10; x++)
	{
		[((UIKey*)[symKeyReg.subviews objectAtIndex:x+10]) setKey: rowSym2Reg[x]];
	}

	posX=48;
	posY=110;
	for(x=0; x<5; x++)
	{
		posX += 2;
		[symKeyReg addSubview: [[UIKey alloc] initWithFrame: CGRectMake(posX, posY, 40, 40)]];
		posX += 42;
	}
	for(x=0; x<5; x++)
	{
		[((UIKey*)[symKeyReg.subviews objectAtIndex:x+20]) setKey: rowSym3Reg[x]];
	}

	//set up symKeyAlt
	posX=0;
	posY=10;
	for(x=0; x<10; x++)
	{
		posX += 2;
		[symKeyAlt addSubview: [[UIKey alloc] initWithFrame: CGRectMake(posX, posY, 28, 40)]];
		posX += 30;
	}
	for(x=0; x<10; x++)
	{
		[((UIKey*)[symKeyAlt.subviews objectAtIndex:x]) setKey: rowSym1Alt[x]];
	}

	posX=0;
	posY=60;
	for(x=0; x<10; x++)
	{
		posX += 2;
		[symKeyAlt addSubview: [[UIKey alloc] initWithFrame: CGRectMake(posX, posY, 28, 40)]];
		posX += 30;
	}
	for(x=0; x<10; x++)
	{
		[((UIKey*)[symKeyAlt.subviews objectAtIndex:x+10]) setKey: rowSym2Alt[x]];
	}

	posX=48;
	posY=110;
	for(x=0; x<5; x++)
	{
		posX += 2;
		[symKeyAlt addSubview: [[UIKey alloc] initWithFrame: CGRectMake(posX, posY, 40, 40)]];
		posX += 42;
	}
	for(x=0; x<5; x++)
	{
		[((UIKey*)[symKeyAlt.subviews objectAtIndex:x+20]) setKey: rowSym3Reg[x]];
	}

	UIKeySpacebar *spacebar = [[UIKeySpacebar alloc] initWithFrame:CGRectMake(82.0f, 160.0f, 158.0f, 34.0f)];
	UIKeyBackspace *backspace = [[UIKeyBackspace alloc] initWithFrame:CGRectMake(278.0f, 110.0f, 40.0f, 40.0f)];
	UIKeyReturn *ret = [[UIKeyReturn alloc] initWithFrame:CGRectMake(242.0f, 160.0f, 78.0f, 34.0f)];
	togglePrimary = [[UIKeyTogglePrimary alloc] initWithFrame: CGRectMake(2.0f, 160.0f, 78.0f, 34.0f)];
	toggleSecondary = [[UIKeyToggleSecondary alloc] initWithFrame: CGRectMake(2, 110.0f, 40.0f, 40.0f)];

	[self addSubview: spacebar];
	[self addSubview: backspace];
	[self addSubview: ret];
	[self addSubview: togglePrimary];
	[self addSubview: toggleSecondary];
	[self addSubview: charKeyCaps];
	return self;
}
-(void)setMode:(UIKeyboardMode)keyMode
{
	mode = keyMode;
	if(keyMode == UIKeyboardModeCharCaps)
	{
		[[subviews objectAtIndex:[subviews count]-1] removeFromSuperview];
		[self addSubview: charKeyCaps];
	}
	else if(keyMode == UIKeyboardModeCharLower)
	{
		[[subviews objectAtIndex:[subviews count]-1] removeFromSuperview];
		[self addSubview: charKeyLower];
	}
	else if(keyMode == UIKeyboardModeSymReg)
	{
		[[subviews objectAtIndex:[subviews count]-1] removeFromSuperview];
		[self addSubview: symKeyReg];
	}
	else if(keyMode == UIKeyboardModeSymAlt)
	{
		[[subviews objectAtIndex:[subviews count]-1] removeFromSuperview];
		[self addSubview: symKeyAlt];
	}
	[togglePrimary setNeedsDisplay];
	[toggleSecondary setNeedsDisplay];
}
-(void)drawRect:(CGRect)rect
{
	CGFloat components[8] = {0.55, 0.58, 0.62, 1.0, .27, .33, .4, 1.0};
	CGFloat locations[2] = {0.0, 1.0};
	CGPoint startPoint = CGPointMake(0.0, 0.0);
	CGPoint endPoint = CGPointMake(0.0, self.frame.size.height);

	CGContextRef ref = UIGraphicsGetCurrentContext();
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, locations, 2);

	CGContextSaveGState(ref);
	CGContextAddRect(ref, CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height));
	CGContextClip(ref);
	CGContextDrawLinearGradient(ref, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
	CGContextRestoreGState(ref);
}
-(void)show
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration: .5];
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y-self.frame.size.height, self.frame.size.width, self.frame.size.height);
	[UIView commitAnimations];
}
-(void)dismiss
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration: .5];
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height);
	[UIView commitAnimations];
}
@end
