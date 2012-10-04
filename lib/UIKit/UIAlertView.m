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
#import <UIKit/UIAlertView.h>
#import <stdarg.h>
#import <UIKit/UIKit.h>

@implementation UIAlertView
@synthesize delegate;
@synthesize title;
@synthesize message;
@synthesize visible;
@synthesize numberOfButtons;
@synthesize cancelButtonIndex;
@synthesize firstOtherButtonIndex;

-(id)initWithTitle:(NSString*)titl message:(NSString*)messag delegate:(id)delegat cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitles:(NSString*)otherButtonTitles, ...;
{
	[self initWithFrame: CGRectMake(0.0, 0.0, 320.0, 460.0)];
	buttons = [[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, 0, 0)];
	[self addSubview: buttons];

	title = titl;
	dispTitle = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, bounds.size.width*.7, 37.0)];
	dispTitle.textAlignment = UITextAlignmentCenter;
	dispTitle.text = title;
	[self addSubview: dispTitle];

	message = messag;
	dispMessage = [[UITextView alloc] initWithFrame: CGRectMake(0, 0, bounds.size.width*.7, 74.0)];
	dispMessage.text = message;
	[self addSubview: dispMessage];

	delegate = delegat;
	UIButton* cancelButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
	cancelButton.bounds = CGRectMake(0, 0, bounds.size.width*.7, 37.0f);
	[cancelButton setTitle: cancelButtonTitle forState:UIControlStateNormal];
	[cancelButton addTarget:self action:@selector(receivedMessage:forEvent:) forControlEvents:UIControlStateSelected];
	
	[buttons addSubview: cancelButton];
	cancelButtonIndex = [buttons.subviews count]-1;

	if(otherButtonTitles != nil)
	{
		firstOtherButtonIndex = [buttons.subviews count];
	}

	//this is the method to load parameters for a variadic function	
	va_list args;
	va_start(args, otherButtonTitles);
	NSString* obj;
	UIButton* holdButton;
	for(obj = otherButtonTitles; obj != nil; obj = va_arg(args, NSString*))
	{
		holdButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
		holdButton.bounds = CGRectMake(0.0f, 0.0f, bounds.size.width*.7, 37.0f);
		[holdButton setTitle: obj forState:UIControlStateNormal];
		[holdButton addTarget:self action:@selector(receivedMessage:forEvent:) forControlEvents:UIControlStateSelected];
		//[buttons addSubview: holdButton];
	}
	va_end(args);
	[self layout];
	return self;
}
-(NSInteger)addButtonWithTitle:(NSString*)titl
{
	UIButton *holdButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
	holdButton.bounds = CGRectMake(0.0f, 0.0f, bounds.size.width*.7, 37.0f);
	[holdButton setTitle: titl forState:UIControlStateNormal];

	[buttons addSubview: holdButton];
	[self layout];
	return [buttons.subviews count]-1;
}
-(NSString*)buttonTitleAtIndex:(NSInteger)buttonIndex
{
	return ((UIButton*)[buttons.subviews objectAtIndex:buttonIndex]).titleLabel.text;
}
-(void)drawRect:(CGRect)rect
{
	[self layout];
	CGContextRef ref = UIGraphicsGetCurrentContext();

	CGContextSetRGBFillColor(ref, 0.0, 0.0, 0.0, 0.2);
	CGContextFillRect(ref, self.bounds);
}
-(void)show
{
	[[UIApplication sharedApplication].keyWindow addSubview: self];
}
-(void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
	[self removeFromSuperview];
}
-(void)receivedMessage:(id)sender forEvent:(UIEvent*)event
{
	int x;
	for(x=0; x<[buttons.subviews count]; x++)
	{
		if(sender == [subviews objectAtIndex:x])
		{
			[delegate alertView:self clickedButtonAtIndex:x];
			if(x == cancelButtonIndex)
			{
				[delegate alertViewCancel:self];
				[delegate alertView:self willDismissWithButtonIndex:x];
				[self dismissWithClickedButtonIndex:x animated:YES];
				[delegate alertView:self didDismissWithButtonIndex:x];
			}
			break;
		}
	}
}
-(void)layout
{
	dispTitle.frame = CGRectMake(bounds.size.width*.15, ((bounds.size.height-(dispMessage.bounds.size.height+dispTitle.bounds.size.height+[buttons.subviews count]))/2.0), bounds.size.width*.7, 37.0);		
	
	dispMessage.frame = CGRectMake(bounds.size.width*.15, ((bounds.size.height-(dispMessage.bounds.size.height+dispTitle.bounds.size.height+[buttons.subviews count]))/2.0)+37, bounds.size.width*.7, 74.0);	

	buttons.frame = CGRectMake(bounds.size.width*.15, ((bounds.size.height-(dispMessage.bounds.size.height+dispTitle.bounds.size.height+[buttons.subviews count]))/2.0)+37.0+74, bounds.size.width*.7, [buttons.subviews count]*37.0);

	int x;
	for(x=0; x<[buttons.subviews count]; x++)
	{
		((UIView*)[buttons.subviews objectAtIndex:x]).frame = CGRectMake(0.0, 37.0*x, bounds.size.width*.7, 37.0);
	}
}
@end
