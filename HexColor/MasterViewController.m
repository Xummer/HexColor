//
//  MasterViewController.m
//  HexColor
//
//  Created by Xummer on 13-11-8.
//  Copyright (c) 2013年 Xummer. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController ()<NSTextDelegate>
@property (weak) IBOutlet NSTextField *inputTextField;
@property (weak) IBOutlet NSTextFieldCell *colorLabel;
@property (weak) IBOutlet NSColorWell *colorWell;

@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)loadView {
    [super loadView];
    [_colorWell addObserver:self forKeyPath:@"color" options:0 context:NULL];    
}

- (IBAction)caculateColorView:(id)sender {
    NSString *inputStr = [_inputTextField stringValue];

    if (inputStr.length > 0) {
        unsigned long resInt = strtoul([inputStr UTF8String],0,16);
        
        UInt16 pixel565 = (UInt16)resInt;
        
        UInt16 red_mask = 0xF800;
        UInt16 green_mask = 0x7F0;
        UInt16 blue_mask = 0x1F;
        
        UInt8 red_value = (pixel565 & red_mask) >> 11;
        UInt8 green_value = (pixel565 & green_mask) >> 5;
        UInt8 blue_value = (pixel565 & blue_mask);
        
        UInt8 red = red_value << 3;
        UInt8 green = green_value << 2;
        UInt8 blue = blue_value <<3;
        
        NSLog(@"resInt %lu %d r:%d g:%d b:%d", resInt, pixel565, red, green, blue);
        NSColor *color =  [NSColor colorWithRed:(float)red/255.0f green:(float)green/255.0f blue:(float)blue/255.0f alpha:1];
        [_colorWell setColor:color];
        
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"color"]) {
        
        NSColor *color = [_colorWell color];
        
        CGFloat red_compent = color.redComponent;
        CGFloat green_compent = color.greenComponent;
        CGFloat blue_compent = color.blueComponent;
        
        UInt8 red = red_compent * 0xFF;
        UInt8 green = green_compent * 0xFF;
        UInt8 blue = blue_compent * 0xFF;
        
        UInt8 red_value = red >> 3;
        UInt8 green_value = green >> 2;
        UInt8 blue_value = blue >> 3;
        
        NSString *colorStr = [NSString stringWithFormat:@"r:%d g:%d b:%d", red, green, blue];
        UInt16 pixel565 = (red_value << 11) | (green_value << 5) | blue_value;
        
        [_colorLabel setStringValue:colorStr];
        [_colorLabel setBackgroundColor:color];
        [_colorLabel setTextColor:color];
        [_inputTextField setStringValue:[NSString stringWithFormat:@"%x", pixel565]];
    }
}

@end
