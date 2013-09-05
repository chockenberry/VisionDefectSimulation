//
//  VisionDefectSimulation.h
//  xScope
//
//  Created by Craig Hockenberry on 8/29/11.
//  Copyright 2011 The Iconfactory. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	VisionDefectNone = 0,
	VisionDefectPresbyopia,
	VisionDefectProtanopia,
	VisionDefectDeuteranopia,
	VisionDefectTritanopia,
	VisionDefectProtanomaly,
	VisionDefectDeuteranomaly,
	VisionDefectTritanomaly
} VisionDefectType;

extern const NSUInteger defaultVisionDefectDimension;

@interface VisionDefectSimulation : NSObject

+ (NSData *)dataForVisionDefect:(VisionDefectType)type withDimension:(NSUInteger)dimension;

+ (CIFilter *)filterForVisionDefect:(VisionDefectType)type withBackingScaleFactor:(CGFloat)backingScaleFactor;

+ (NSString *)nameForVisionDefect:(VisionDefectType)type;

@end
