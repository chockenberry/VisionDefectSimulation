//
//  AppDelegate.h
//  Retination
//
//  Created by Craig Hockenberry on 6/27/13.
//  Copyright (c) 2013 The Iconfactory. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class VisionView;

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet VisionView *visionView;
@property (assign) IBOutlet NSPopUpButton *visionDefectPopUpButton;

@end
