//
//  VisionView.h
//  Retination
//
//  Created by Craig Hockenberry on 6/27/13.
//  Copyright (c) 2013 The Iconfactory. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "VisionDefectSimulation.h"

@interface VisionView : NSView

- (void)setVisionDefectType:(VisionDefectType)newVisionDefectType;
- (VisionDefectType)visionDefectType;

- (void)setSampleRect:(NSRect)newSampleRect;
- (NSRect)sampleRect;

- (void)setSampleImage:(NSImage *)newSampleImage;
- (NSImage *)sampleImage;

@end
