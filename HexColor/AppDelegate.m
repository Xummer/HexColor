//
//  AppDelegate.m
//  HexColor
//
//  Created by Xummer on 13-11-8.
//  Copyright (c) 2013年 Xummer. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) IBOutlet MasterViewController *masterVCtrl;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    self.masterVCtrl =
     [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
    [_window.contentView addSubview:_masterVCtrl.view];
    [_masterVCtrl view].frame = ((NSView *)[_window contentView]).bounds;
}

@end
