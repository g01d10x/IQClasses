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

CGFloat degreeToRadian(CGFloat angle);
CGFloat radianToDegree(CGFloat radians);

CGFloat CGAffineTransformAngle(CGAffineTransform t);
CGSize CGAffineTransformGetScale(CGAffineTransform t);

CGRect CGRectSetSize(CGRect rect, CGSize size);
CGRect CGRectMakeSize(CGRect rect, CGFloat width, CGFloat height);
CGRect CGRectSetHeight(CGRect rect, CGFloat height);
CGRect CGRectSetWidth(CGRect rect, CGFloat width);

CGRect CGRectSetOrigin(CGRect rect, CGPoint origin);
CGRect CGRectMakeOrigin(CGRect rect, CGFloat x, CGFloat y);
CGRect CGRectSetX(CGRect rect, CGFloat x);
CGRect CGRectSetY(CGRect rect, CGFloat y);


CGFloat CGPointGetAngle(CGPoint centerPoint, CGPoint point1, CGPoint point2);

CGRect CGRectFromPoints(CGPoint startPoint, CGPoint endPoint);

CGRect CGRectWithCenter(CGRect rect, CGPoint center);

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
NSArray* CGPointGetTwoMidPointsInRect(CGRect Rect, CGFloat rotationAngle);

NSArray* CGPointHexagonePoints(CGPoint centerPoint, CGFloat distance, BOOL horizontal);

CGPoint CGPointAspectFit(CGPoint point, CGSize destSize, CGRect sourceRect);
NSArray* CGPointsAspectFit(NSArray* points, CGSize destSize, CGRect sourceRect);

CGPoint CGPointAspectFill(CGPoint point, CGSize destSize, CGRect sourceRect);

CGPoint CGPointAspectFitToTopLeft(CGPoint point, CGSize expectedSize, CGRect originRect);
CGRect  CGRectAspectFitToTopLeft(CGRect rect, CGSize expectedSize, CGRect originRect);

/*iOS CookBook*/
// Centering
CGRect	CGRectAroundCenter(CGPoint center, float dx, float dy);
CGRect	CGRectCenteredInRect(CGRect rect, CGRect mainRect);

// Offset, Scaling
CGPoint CGPointOffset(CGPoint aPoint, CGFloat dx, CGFloat dy);
NSArray* CGPointsOffset(NSArray *points, CGFloat dx, CGFloat dy);
CGPoint CGPointScale(CGPoint aPoint, CGFloat wScale, CGFloat hScale);
NSArray* CGPointsScale(NSArray* points, CGFloat wScale, CGFloat hScale);
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
