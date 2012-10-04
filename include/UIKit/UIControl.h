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
#import <Foundation/Foundation.h>
#import <UIKit/UIResponder.h>
#import <UIKit/UITouch.h>
#import <UIKit/UIEvent.h>

enum
{
	UIControlStateNormal = 0,
	UIControlStateHighlighted = 1 << 0,
	UIControlStateDisabled = 1 << 1,
	UIControlStateSelected = 1 << 2,
	UIControlStateApplication = 0x00FF0000,
	UIControlStateReserved = 0xFF000000
};

typedef enum
{
	UIControlContentVerticalAlignmentCenter = 0,
	UIControlContentVerticalAlignmentTop = 1,
	UIControlContentVerticalAlignmentBottom = 2,
	UIControlContentVerticalAlignmentFill = 3,
} 
UIControlContentVerticalAlignment;

typedef enum
{
	UIControlContentHorizontalAlignmentCenter = 0,
	UIControlContentHorizontalAlignmentLeft = 1,
	UIControlContentHorizontalAlignmentRight = 2,
	UIControlContentHorizontalAlignmentFill = 3,
}
UIControlContentHorizontalAlignment;

enum
{
	UIControlEventTouchDown = 1 << 0,
	UIControlEventTouchDownRepeat = 1 << 1,
	UIControlEventDragInside = 1 << 2,
	UIControlEventDragOutside = 1 << 3,
	UIControlEventDragEnter = 1 << 4,
	UIControlEventTouchUpInside = 1 << 6,
	UIControlEventTouchUpOutside = 1 << 7,
	UIControlEventTouchCancel = 1 << 8,

	UIControlEventValueChanged = 1 << 12,
	
	UIControlEventEditingDidBegin = 1 << 16,
	UIControlEventEditingChanged = 1 << 17,
	UIControlEventEditingDidEnd = 1 << 18,
	UIControlEventEditingDidEndOnExit = 1 << 19,
	
	UIControlEventAllTouchEvents = 0x00000FFF,
	UIControlEventAllEditingEvents = 0x000F0000,
	UIControlEventApplicationReserved = 0x0F000000,
	UIControlEventSystemReserved = 0xF0000000,
	UIControlEventAllEvents = 0xFFFFFFFF
};

typedef NSUInteger UIControlEvents;
typedef NSUInteger UIControlState;

@interface UIControlTarget : NSObject
{
	id target;
	SEL action;
	UIControlEvents events;
}
@property(nonatomic) id target;
@property(nonatomic) SEL action;
@property(nonatomic) UIControlEvents events;
@end

@interface UIControl : UIView
{
	UIControlState state;
	BOOL enabled;
	BOOL selected;
	BOOL highlighted;
	UIControlContentVerticalAlignment contentVerticalAlignment;
	UIControlContentHorizontalAlignment contentHorizontalAlignment;
	BOOL tracking;
	BOOL touchInside;
	NSMutableArray* targets;
	UIEvent *lastEvent;
	BOOL shouldTrackContinuously;
}
-(id)init;
-(void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent*)event;
-(void)sendActionsForControlEvents:(UIControlEvents)controlEvents;
-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
-(void)removeTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
-(NSArray*)actionsForTarget:(id)target forControlEvent:(UIControlEvents)controlEvent;
-(NSSet*)allTargets;
-(UIControlEvents)allControlEvents;
-(BOOL)beginTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event;
-(BOOL)continueTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event;
-(void)endTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event;
-(void)cancelTrackingWithEvent:(UIEvent*)event;
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

@property(nonatomic, readonly) UIControlState state;
@property(nonatomic, getter=isEnabled) BOOL enabled;
@property(nonatomic, getter=isSelected) BOOL selected;
@property(nonatomic, getter=isHighlighted) BOOL highlighted;
@property(nonatomic) UIControlContentVerticalAlignment contentVerticalAlignment;
@property(nonatomic) UIControlContentHorizontalAlignment contentHorizontalAlignment;
@property(nonatomic, readonly, getter=isTracking) BOOL tracking;
@property(nonatomic, readonly, getter=isTouchInside) BOOL touchInside;
@end

