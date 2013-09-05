//
//  AppDelegate.m
//  Retination
//
//  Created by Craig Hockenberry on 6/27/13.
//  Copyright (c) 2013 The Iconfactory. All rights reserved.
//

#import "AppDelegate.h"

#import "VisionView.h"

@interface AppDelegate () <NSWindowDelegate>

@end

@implementation AppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)awakeFromNib
{
	NSRect viewFrame = [self.visionView frame];
	NSRect screenRect = [self.window convertRectToScreen:viewFrame];

	[self.visionView setSampleRect:screenRect];
	[self.visionView setVisionDefectType:VisionDefectTritanomaly];
}

#pragma mark - Actions

- (IBAction)changeVisionDefect:(id)sender
{
	NSInteger selectedTag = [[self.visionDefectPopUpButton selectedItem] tag];
	
	[self.visionView setVisionDefectType:(VisionDefectType)selectedTag];
}

- (IBAction)toggleColors:(id)sender
{
	if ([self.visionView sampleImage]) {
		[self.visionView setSampleImage:nil];
	}
	else {
		NSImage *colorsImage = [NSImage imageNamed:@"Colors"];
		
		[self.visionView setSampleImage:colorsImage];
	}
}

#pragma mark - NSWindowDelegate

- (void)windowDidMove:(NSNotification *)notification
{
	NSLog(@"%s called", __PRETTY_FUNCTION__);
	
	if ([notification object] == self.window) {
		NSRect viewFrame = [self.visionView frame];
		NSRect screenRect = [self.window convertRectToScreen:viewFrame];
		
		[self.visionView setSampleRect:screenRect];
	}
}


@end
