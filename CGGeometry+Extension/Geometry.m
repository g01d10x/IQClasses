//
//  IQGeometry.m
//  Pic N' Frame
//
//  Created by Gaurav Goyal on 4/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Geometry.h"

CGRect CGRectFromPoints(CGPoint startPoint, CGPoint endPoint)
{
    return CGRectMake(startPoint.x, startPoint.y, endPoint.x-startPoint.x, endPoint.y-startPoint.y);
}

CGPoint CGRectGetCenter(CGRect rect)
{
    return CGPointMake(rect.origin.x+rect.size.width/2, rect.origin.y+rect.size.height/2);
}

CGPoint CGPointGetMidPoint(CGPoint point1, CGPoint point2)
{
    return CGPointMake((point1.x+point2.x)/2, (point1.y+point2.y)/2);
}

/*
 A (x1, y1) and B (x2, y2) = sqrt( (x2−x1)2+(y2−y1)2)
 */
CGFloat CGPointGetDistance(CGPoint point1, CGPoint point2)
{
    //Saving Variables.
    CGFloat fx = (point2.x - point1.x);
    CGFloat fy = (point2.y - point1.y);
    
    return sqrt((fx*fx + fy*fy));
}

/*  (x1,y1)         (x,y)                           (x2,y2) */
/*  *-----------------*----------------------------------*  */
/*  <----distance----->                                     */
//Returns a point(x,y) lies between point1(x1,y1) and point2(x2,y2) by distance from point1(x1,y1).
CGPoint CGPointWithDistance(CGPoint point1, CGPoint point2, CGFloat distance)
{
    //Finding relative percent from point1 till distance ( 0.0 - 1.0).
    CGFloat relativePercent = distance/CGPointGetDistance(point1, point2); 
    //Calculating distance from point1.
    CGFloat px = point1.x + relativePercent * (point2.x - point1.x);
    CGFloat py = point1.y + relativePercent * (point2.y - point1.y);
    
    //Returning Points
    return CGPointMake(px, py);
}

/*
 (x1,y1)   (x3,y3)
 \        /
   \    /
     \/
     /\
   /    \
 /        \
 (x4,y4)   (x2,y2)
 
 Equation of line.
 y-y1 = m1(x-x1)
 
 (y2-y2)
 where slope  m1 =   --------
 (x2-x1)
 */

CGPoint CGPointOfIntersect(CGLine line1, CGLine line2)
{
    CGFloat d = (line1.point1.x-line1.point2.x)*(line2.point1.y-line2.point2.y) - (line1.point1.y-line1.point2.y)*(line2.point1.x-line2.point2.x);
    
    CGFloat xi = ((line2.point1.x-line2.point2.x)*(line1.point1.x*line1.point2.y-line1.point1.y*line1.point2.x)-(line1.point1.x-line1.point2.x)*(line2.point1.x*line2.point2.y-line2.point1.y*line2.point2.x))/d;
    CGFloat yi = ((line2.point1.y-line2.point2.y)*(line1.point1.x*line1.point2.y-line1.point1.y*line1.point2.x)-(line1.point1.y-line1.point2.y)*(line2.point1.x*line2.point2.y-line2.point1.y*line2.point2.x))/d;
    
    return CGPointMake(xi, yi);
}

CGFloat CGPointGetDistanceOfPoint(CGPoint point, CGLine line)
{
    CGFloat normalLength = sqrt((line.point2.x-line.point1.x)*(line.point2.x-line.point1.x)+(line.point2.y-line.point1.y)*(line.point2.y-line.point1.y));
    return abs((point.x-line.point1.x)*(line.point2.y-line.point1.y)-(point.y-line.point1.y)*(line.point2.x-line.point1.x))/normalLength;
}

/*
 Centroid of points, A, B and C is (x1+x2+x3)/3, (y1+y2+y3)/3
 */

CGPoint CGPointCentroidOfPoints(NSArray* arrayPoints)
{
    CGFloat x = 0;
    CGFloat y = 0;
    
    for (NSValue *value in arrayPoints)
    {
        x += [value CGPointValue].x;
        y += [value CGPointValue].y;
    }
    
    x = x/[arrayPoints count];
    y = y/[arrayPoints count];
    
    return CGPointMake(x, y);
}

CGPoint CGPointRorate(CGPoint point, CGPoint basePoint, CGFloat angle)
{
    angle = angle*M_PI/180;
    
    CGFloat x = cos(angle) * (point.x-basePoint.x) - sin(angle) * (point.y-basePoint.y) + basePoint.x;
    CGFloat y = sin(angle) * (point.x-basePoint.x) + cos(angle) * (point.y-basePoint.y) + basePoint.y;
    
    return CGPointMake(x,y);
}

CGPoint CGPointGetNearPoint(CGPoint basePoint, NSArray *points)
{
    CGFloat minimumDistance = 10000;
    CGPoint nearbyPoint;
    
    for (NSValue *aValue in points)
    {
        CGPoint aPoint = [aValue CGPointValue];
        
        CGFloat currentDistance = CGPointGetDistance(basePoint, aPoint);
        if (minimumDistance>currentDistance)
        {
            nearbyPoint = aPoint;
            minimumDistance = currentDistance;
        }
    }
    return nearbyPoint;
}

NSArray* CGPointGetMidPointsInRect(CGRect Rect, CGFloat rotationAngle)
{
    //Creating array to store mouth points
    NSMutableArray *arrayMouthPoints = [[NSMutableArray alloc] init];
    
    //RoratePoint( MidPoint of a line, Center point as a base point, angle to rotate).
    [arrayMouthPoints addObject:[NSValue valueWithCGPoint:CGPointRorate
                                 (CGPointGetMidPoint(CGPointMake(CGRectGetMinX(Rect), CGRectGetMinY(Rect)),
                                                     CGPointMake(CGRectGetMinX(Rect), CGRectGetMaxY(Rect))),
                                  CGRectGetCenter(Rect), rotationAngle*180/M_PI)]];
    
    [arrayMouthPoints addObject:[NSValue valueWithCGPoint:CGPointRorate
                                 (CGPointGetMidPoint(CGPointMake(CGRectGetMinX(Rect), CGRectGetMinY(Rect)),
                                                     CGPointMake(CGRectGetMaxX(Rect), CGRectGetMinY(Rect))),
                                  CGRectGetCenter(Rect), rotationAngle*180/M_PI)]];
    
    [arrayMouthPoints addObject:[NSValue valueWithCGPoint:CGPointRorate
                                 (CGPointGetMidPoint(CGPointMake(CGRectGetMaxX(Rect), CGRectGetMinY(Rect)),
                                                     CGPointMake(CGRectGetMaxX(Rect), CGRectGetMaxY(Rect))),
                                  CGRectGetCenter(Rect), rotationAngle*180/M_PI)]];
    
    [arrayMouthPoints addObject:[NSValue valueWithCGPoint:CGPointRorate
                                 (CGPointGetMidPoint(CGPointMake(CGRectGetMinX(Rect), CGRectGetMaxY(Rect)),
                                                     CGPointMake(CGRectGetMaxX(Rect), CGRectGetMaxY(Rect))),
                                  CGRectGetCenter(Rect), rotationAngle*180/M_PI)]];
    return arrayMouthPoints;
}


NSArray* CGPointHexagonePoints(CGPoint centerPoint, CGFloat distance, BOOL horizontal)
{
    CGFloat angle = 60.0;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i<6; i++)
    {
        CGFloat x = centerPoint.x - distance * cosf((angle*i+(horizontal?0:30))*M_PI/180);
        CGFloat y = centerPoint.y + distance * sinf((angle*i+(horizontal?0:30))*M_PI/180);
        
        [array addObject:[NSValue valueWithCGPoint:CGPointMake(x,y)]];
    }
    return array;
}

CGPoint CGPointAspectFit(CGPoint point, CGSize destSize, CGRect sourceRect)
{
    CGRect innerRect = CGRectAspectFitRect(destSize, sourceRect);
    
    point = CGPointAspectFill(point, destSize, sourceRect);
    
    CGFloat ratioPointWidth = point.x/CGRectGetWidth(sourceRect);
    CGFloat ratioPointHeight = point.y/CGRectGetHeight(sourceRect);
    
    CGFloat pointX = (innerRect.origin.x+CGRectGetWidth(innerRect)*ratioPointWidth);//*(innerRect.size.width/destSize.width);
    CGFloat pointY = (innerRect.origin.y+CGRectGetHeight(innerRect)*ratioPointHeight);//*(innerRect.size.height/destSize.height);
    
    return CGPointMake(pointX, pointY);
}

CGPoint CGPointAspectFill(CGPoint point, CGSize destSize, CGRect sourceRect)
{
    return CGPointMake(point.x*(sourceRect.size.width/destSize.width), point.y*(sourceRect.size.height/destSize.height));
}


/*iOS CookBook*/

CGRect CGRectAroundCenter(CGPoint center, float dx, float dy)
{
	return CGRectMake(center.x - dx, center.y - dy, dx * 2, dy * 2);
}

CGRect CGRectCenteredInRect(CGRect rect, CGRect mainRect)
{
    CGFloat dx = CGRectGetMidX(mainRect)-CGRectGetMidX(rect);
    CGFloat dy = CGRectGetMidY(mainRect)-CGRectGetMidY(rect);
	return CGRectOffset(rect, dx, dy);
}

CGPoint CGPointOffset(CGPoint aPoint, CGFloat dx, CGFloat dy)
{
    return CGPointMake(aPoint.x + dx, aPoint.y + dy);
}

CGSize CGSizeScale(CGSize aSize, CGFloat wScale, CGFloat hScale)
{
    return CGSizeMake(aSize.width * wScale, aSize.height * hScale);
}

CGPoint CGPointScale(CGPoint aPoint, CGFloat wScale, CGFloat hScale)
{
    return CGPointMake(aPoint.x * wScale, aPoint.y * hScale);
}

CGRect CGRectScaleRect(CGRect rect, CGFloat wScale, CGFloat hScale)
{
    return CGRectMake(rect.origin.x * wScale, rect.origin.y * hScale, rect.size.width * wScale, rect.size.height * hScale);
}

CGRect CGRectScaleSize(CGRect rect, CGFloat wScale, CGFloat hScale)
{
    return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width * wScale, rect.size.height * hScale);
}

CGRect  CGRectScaleOrigin(CGRect rect, CGFloat wScale, CGFloat hScale)
{
    return CGRectMake(rect.origin.x * wScale, rect.origin.y * hScale, rect.size.width, rect.size.height);
}

CGRect CGRectFlipHorizontal(CGRect innerRect, CGRect outerRect)
{
    CGRect rect = innerRect;
    rect.origin.x = outerRect.origin.x + outerRect.size.width - (rect.origin.x + rect.size.width);
    return rect;
}

CGPoint CGPointFlipHorizontal(CGPoint point, CGRect outerRect)
{
    CGPoint newPoint = point;
    newPoint.x = outerRect.origin.x + outerRect.size.width - point.x;
    return newPoint;
    
}

CGPoint CGPointFlipVertical(CGPoint point, CGRect outerRect)
{
    CGPoint newPoint = point;
    newPoint.y = outerRect.origin.y + outerRect.size.height - point.y;
    return newPoint;
}


CGRect CGRectFlipVertical(CGRect innerRect, CGRect outerRect)
{
    CGRect rect = innerRect;
    rect.origin.y = outerRect.origin.y + outerRect.size.height - (rect.origin.y + rect.size.height);
    return rect;
}

CGSize CGSizeFlip(CGSize size)
{
    return CGSizeMake(size.height, size.width);
}

CGPoint CGPointFlip(CGPoint point)
{
    return CGPointMake(point.y, point.x);
}

CGRect CGRectFlipFlop(CGRect rect)
{
    return CGRectMake(rect.origin.y, rect.origin.x, rect.size.height, rect.size.width);
}

// Does not affect point of origin
CGRect CGRectFlipSize(CGRect rect)
{
    return CGRectMake(rect.origin.x, rect.origin.y, rect.size.height, rect.size.width);
}

// Does not affect size
CGRect  CGRectFlipOrigin(CGRect rect)
{
    return CGRectMake(rect.origin.y, rect.origin.x, rect.size.width, rect.size.height);
}

CGSize CGSizeFitInSize(CGSize sourceSize, CGSize destSize)
{
	CGFloat destScale;
	CGSize newSize = sourceSize;
    
	if (newSize.height && (newSize.height > destSize.height))
	{
		destScale = destSize.height / newSize.height;
		newSize.width *= destScale;
		newSize.height *= destScale;
	}
    
	if (newSize.width && (newSize.width >= destSize.width))
	{
		destScale = destSize.width / newSize.width;
		newSize.width *= destScale;
		newSize.height *= destScale;
	}
    
	return newSize;
}

// Only scales down, not up, and centers result
CGRect CGRectFitSizeInRect(CGSize sourceSize, CGRect destRect)
{
    CGSize destSize = destRect.size;
	CGSize targetSize = CGSizeFitInSize(sourceSize, destSize);
	float dWidth = destSize.width - targetSize.width;
	float dHeight = destSize.height - targetSize.height;
    
	return CGRectMake(dWidth / 2.0f, dHeight / 2.0f, targetSize.width, targetSize.height);
}


CGFloat CGAspectScaleFit(CGSize sourceSize, CGRect destRect)
{
    CGSize destSize = destRect.size;
    CGFloat scaleW = destSize.width / sourceSize.width;
	CGFloat scaleH = destSize.height / sourceSize.height;
    return MIN(scaleW, scaleH);
}

CGRect CGRectAspectFitRect(CGSize sourceSize, CGRect destRect)
{
    CGSize destSize = destRect.size;
	CGFloat destScale = CGAspectScaleFit(sourceSize, destRect);
    
	CGFloat newWidth = sourceSize.width * destScale;
	CGFloat newHeight = sourceSize.height * destScale;
    
	float dWidth = ((destSize.width - newWidth) / 2.0f);
	float dHeight = ((destSize.height - newHeight) / 2.0f);
    
	CGRect rect = CGRectMake(dWidth, dHeight, newWidth, newHeight);
	return rect;
}

CGFloat CGAspectScaleFill(CGSize sourceSize, CGRect destRect)
{
    CGSize destSize = destRect.size;
    CGFloat scaleW = destSize.width / sourceSize.width;
	CGFloat scaleH = destSize.height / sourceSize.height;
    return MAX(scaleW, scaleH);
}

CGRect CGRectAspectFillRect(CGSize sourceSize, CGRect destRect)
{
    CGSize destSize = destRect.size;
	CGFloat destScale = CGAspectScaleFill(sourceSize, destRect);
    
	CGFloat newWidth = sourceSize.width * destScale;
	CGFloat newHeight = sourceSize.height * destScale;
    
	float dWidth = ((destSize.width - newWidth) / 2.0f);
	float dHeight = ((destSize.height - newHeight) / 2.0f);
    
	CGRect rect = CGRectMake(dWidth, dHeight, newWidth, newHeight);
	return rect;
}

CGSize CGRectGetScale(CGRect sourceRect, CGRect destRect)
{
    CGSize sourceSize = sourceRect.size;
    CGSize destSize = destRect.size;
    
    CGFloat scaleW = destSize.width / sourceSize.width;
	CGFloat scaleH = destSize.height / sourceSize.height;
    
    return CGSizeMake(scaleW, scaleH);
}
/*End iOS CookBook*/


