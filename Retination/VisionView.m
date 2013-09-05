//
//  VisionView.m
//  Retination
//
//  Created by Craig Hockenberry on 6/27/13.
//  Copyright (c) 2013 The Iconfactory. All rights reserved.
//

#import "VisionView.h"

#import <Quartz/Quartz.h>

// NOTE: This code is designed to work in as many different development environments as possible. Hence, there is no requirement
// for ARC, properties, or new Objective-C syntax. Basically, if you can use CIImage, you shouldn't have any problems using this code.

@implementation VisionView
{
	NSImage *sampleImage;
	NSRect sampleRect;
	VisionDefectType visionDefectType;
	CIFilter *visionFilter;
}

- (void)drawRect:(NSRect)dirtyRect
{
	CGImageRef capturedImage;
	if (sampleImage) {
		capturedImage = [sampleImage CGImageForProposedRect:NULL context:[NSGraphicsContext currentContext] hints:nil];
	}
	else {
		CGRect captureRect = NSRectToCGRect(sampleRect);
		
		NSScreen *originScreen = [[NSScreen screens] objectAtIndex:0];
		NSRect originScreenFrame = [originScreen frame];
		captureRect.origin.y = originScreenFrame.size.height - sampleRect.origin.y - sampleRect.size.height;
		
		CGWindowID windowID = (CGWindowID)[[self window] windowNumber];
		
		// get composite image of all the windows beneath the screen's child window
		capturedImage = CGWindowListCreateImage(captureRect, kCGWindowListOptionOnScreenBelowWindow, windowID, (kCGWindowImageBoundsIgnoreFraming | kCGWindowImageShouldBeOpaque));
	}
	
	if (visionDefectType == VisionDefectNone) {
		CGRect destinationRect = CGRectZero;
		destinationRect.size = NSSizeToCGSize(sampleRect.size);
		CGContextDrawImage([[NSGraphicsContext currentContext] graphicsPort], destinationRect, capturedImage);
	}
	else {
		CIImage *normalImage = [CIImage imageWithCGImage:capturedImage];
		CIImage *visionDefectImage = nil;

		[visionFilter setValue:normalImage forKey: @"inputImage"];
		visionDefectImage = [visionFilter valueForKey: @"outputImage"];

        NSRect bounds = [self bounds];
		NSBitmapImageRep *bitmap = [[[NSBitmapImageRep alloc] initWithCIImage:visionDefectImage] autorelease];
		[bitmap drawInRect:bounds];
	}

	if (! sampleImage) {
		CGImageRelease(capturedImage);
	}
}

- (void)setVisionDefectType:(VisionDefectType)newVisionDefectType
{
	if (newVisionDefectType != visionDefectType) {
		visionDefectType = newVisionDefectType;
		
		BOOL enabled = (visionDefectType != VisionDefectNone);
		if (enabled) {
			[visionFilter release], visionFilter = nil;
			visionFilter = [[VisionDefectSimulation filterForVisionDefect:visionDefectType withBackingScaleFactor:[[self window] backingScaleFactor]] retain];
		}
		
		[self setNeedsDisplay:YES];
	}
}

- (VisionDefectType)visionDefectType
{
	return visionDefectType;
}

- (void)setSampleRect:(NSRect)newSampleRect
{
	if (! NSEqualRects(newSampleRect, sampleRect)) {
		sampleRect = newSampleRect;
		
		[self setNeedsDisplay:YES];
	}
}

- (NSRect)sampleRect
{
	return sampleRect;
}

- (void)setSampleImage:(NSImage *)newSampleImage
{
	if (newSampleImage != sampleImage) {
		[sampleImage release];
		sampleImage = [newSampleImage retain];
		
		[self setNeedsDisplay:YES];
	}
}

- (NSImage *)sampleImage
{
	return sampleImage;
}

@end
