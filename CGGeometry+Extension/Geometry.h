//
//  IQGeometry.h
//  Pic N' Frame
//
//  Created by Gaurav Goyal on 4/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

struct CGLine {
    CGPoint point1;
    CGPoint point2;
};
typedef struct CGLine CGLine;

CGRect CGRectFromPoints(CGPoint startPoint, CGPoint endPoint);

CGPoint CGRectGetCenter(CGRect rect);

CGPoint CGPointGetMidPoint(CGPoint point1, CGPoint point2);

CGFloat CGPointGetDistance(CGPoint point1, CGPoint point2);

CGPoint CGPointWithDistance(CGPoint point1, CGPoint point2, CGFloat distance);

CGPoint CGPointOfIntersect(CGLine line1, CGLine line2);

CGFloat CGPointGetDistanceOfPoint(CGPoint point, CGLine line);

CGPoint CGPointCentroidOfPoints(NSArray* arrayPoints);

CGPoint CGPointRorate(CGPoint point, CGPoint basePoint, CGFloat angle);

CGPoint CGPointGetNearPoint(CGPoint basePoint, NSArray *points);

NSArray* CGPointGetMidPointsInRect(CGRect Rect, CGFloat rotationAngle);

NSArray* CGPointHexagonePoints(CGPoint centerPoint, CGFloat distance, BOOL horizontal);

CGPoint CGPointAspectFit(CGPoint point, CGSize destSize, CGRect sourceRect);
CGPoint CGPointAspectFill(CGPoint point, CGSize destSize, CGRect sourceRect);

/*iOS CookBook*/
// Centering
CGRect	CGRectAroundCenter(CGPoint center, float dx, float dy);
CGRect	CGRectCenteredInRect(CGRect rect, CGRect mainRect);

// Offset, Scaling
CGPoint CGPointOffset(CGPoint aPoint, CGFloat dx, CGFloat dy);
CGPoint CGPointScale(CGPoint aPoint, CGFloat wScale, CGFloat hScale);
CGSize  CGSizeScale(CGSize aSize, CGFloat wScale, CGFloat hScale);
CGRect  CGRectScaleRect(CGRect rect, CGFloat wScale, CGFloat hScale);
CGRect  CGRectScaleOrigin(CGRect rect, CGFloat wScale, CGFloat hScale);
CGRect  CGRectScaleSize(CGRect rect, CGFloat wScale, CGFloat hScale);

// Mirror
CGRect  CGRectFlipHorizontal(CGRect rect, CGRect outerRect);
CGRect  CGRectFlipVertical(CGRect rect, CGRect outerRect);
CGPoint CGPointFlipHorizontal(CGPoint point, CGRect outerRect);
CGPoint CGPointFlipVertical(CGPoint point, CGRect outerRect);

// Flipping coordinates
CGRect  CGRectFlipFlop(CGRect rect);
CGRect  CGRectFlipOrigin(CGRect rect);
CGRect  CGRectFlipSize(CGRect rect);
CGSize  CGSizeFlip(CGSize size);
CGPoint CGPointFlip(CGPoint point);

// Aspect and fitting
CGSize  CGSizeFitInSize(CGSize sourceSize, CGSize destSize);
CGSize  CGRectGetScale(CGRect sourceRect, CGRect destRect);
CGRect  CGRectFitSizeInRect(CGSize sourceSize, CGRect destRect);
CGRect  CGRectAspectFitRect(CGSize sourceSize, CGRect destRect);
CGRect  CGRectAspectFillRect(CGSize sourceSize, CGRect destRect);
CGFloat CGAspectScaleFit(CGSize sourceSize, CGRect destRect);
CGFloat CGAspectScaleFill(CGSize sourceSize, CGRect destRect);
/*End iOS CookBook*/
