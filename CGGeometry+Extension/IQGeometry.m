//
//  IQGeometry.m
//  Pic N' Frame
//
//  Created by Gaurav Goyal on 4/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//



/*
http://iphonedevelopment.blogspot.in/2008/10/demystifying-cgaffinetransform.html
 
 new x position = old x position * a + old y position * c + tx
 new y position = old x position*b + old y position * d + ty
 */


#import "Geometry.h"

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

CGFloat degreeToRadian(CGFloat angle)
{
    return angle*(M_PI/180.0);
}

CGFloat radianToDegree(CGFloat radians)
{
    return radians*(180.0/M_PI);
}

CGFloat CGAffineTransformAngle(CGAffineTransform t)
{
    return atan2(t.b, t.a);
}

CGSize CGAffineTransformGetScale(CGAffineTransform t)
{
    return CGSizeMake(sqrt(t.a * t.a + t.c * t.c), sqrt(t.b * t.b + t.d * t.d)) ;
}

CGRect CGRectSetSize(CGRect rect, CGSize size)
{
    rect.size = size;   return rect;
}

CGRect CGRectMakeSize(CGRect rect, CGFloat width, CGFloat height)
{
    rect.size = CGSizeMake(width, height);  return rect;
}

CGRect CGRectSetHeight(CGRect rect, CGFloat height)
{
    rect.size.height = height;  return rect;
}

CGRect CGRectSetWidth(CGRect rect, CGFloat width)
{
    rect.size.width =   width;  return rect;
}

CGRect CGRectSetOrigin(CGRect rect, CGPoint origin)
{
    rect.origin = origin;   return rect;
}

CGRect CGRectMakeOrigin(CGRect rect, CGFloat x, CGFloat y)
{
    rect.origin = CGPointMake(x, y);    return rect;
}

CGRect CGRectSetX(CGRect rect, CGFloat x)
{
    rect.origin.x = x;  return rect;
}

CGRect CGRectSetY(CGRect rect, CGFloat y)
{
    rect.origin.y = y;  return rect;
}



CGRect CGRectWithCenter(CGRect rect, CGPoint center)
{
    return CGRectMake(center.x-CGRectGetWidth(rect)/2, center.y-CGRectGetHeight(rect)/2, CGRectGetWidth(rect), CGRectGetHeight(rect));
}

CGFloat CGPointGetAngle(CGPoint centerPoint, CGPoint point1, CGPoint point2)
{
//    CGFloat A = CGPointGetDistance(centerPoint, point1);
//    CGFloat B = CGPointGetDistance(point1, point2);
//    CGFloat C = CGPointGetDistance(point2, centerPoint);
//
//    
//    Say the distances are P1-P2 = A, P2-P3 = B and P3-P1 = C:
//    
//    Angle = arccos ( (B^2-A^2-C^2) / 2AC )

    CGFloat p0c = sqrtf(powf(centerPoint.x-point1.x, 2) + powf(centerPoint.y-point1.y, 2));
    CGFloat p1c = sqrtf(powf(centerPoint.x-point2.x, 2) + powf(centerPoint.y-point2.y, 2));
    CGFloat p0p1= sqrtf(powf(point2.x-point1.x, 2)      + powf(point2.y-point1.y, 2));
    return (acosf((p1c*p1c+p0c*p0c-p0p1*p0p1)/(2*p1c*p0c))*(180/M_PI));
}

CGLine CGLineMake(CGPoint p1, CGPoint p2)
{
    CGLine line;        line.point1 = p1;       line.point2 = p2;
    return line;
}

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
/*
  -------1--------
 |                |
 |                |
 0                2
 |                |
 |                |
  -------3--------
 
*/
    //Creating array to store mouth points
    NSMutableArray *arrayPoints = [[NSMutableArray alloc] init];
    
    //RoratePoint( MidPoint of a line, Center point as a base point, angle to rotate).
    [arrayPoints addObject:[NSValue valueWithCGPoint:CGPointRorate
                                 (CGPointGetMidPoint(CGPointMake(CGRectGetMinX(Rect), CGRectGetMinY(Rect)),
                                                     CGPointMake(CGRectGetMinX(Rect), CGRectGetMaxY(Rect))),
                                  CGRectGetCenter(Rect), rotationAngle*180/M_PI)]];
    
    [arrayPoints addObject:[NSValue valueWithCGPoint:CGPointRorate
                                 (CGPointGetMidPoint(CGPointMake(CGRectGetMinX(Rect), CGRectGetMinY(Rect)),
                                                     CGPointMake(CGRectGetMaxX(Rect), CGRectGetMinY(Rect))),
                                  CGRectGetCenter(Rect), rotationAngle*180/M_PI)]];
    
    [arrayPoints addObject:[NSValue valueWithCGPoint:CGPointRorate
                                 (CGPointGetMidPoint(CGPointMake(CGRectGetMaxX(Rect), CGRectGetMinY(Rect)),
                                                     CGPointMake(CGRectGetMaxX(Rect), CGRectGetMaxY(Rect))),
                                  CGRectGetCenter(Rect), rotationAngle*180/M_PI)]];
    
    [arrayPoints addObject:[NSValue valueWithCGPoint:CGPointRorate
                                 (CGPointGetMidPoint(CGPointMake(CGRectGetMinX(Rect), CGRectGetMaxY(Rect)),
                                                     CGPointMake(CGRectGetMaxX(Rect), CGRectGetMaxY(Rect))),
                                  CGRectGetCenter(Rect), rotationAngle*180/M_PI)]];
    return arrayPoints;
}

NSArray* CGPointGetTwoMidPointsInRect(CGRect Rect, CGFloat rotationAngle)
{
/*
 ----------------
|       |        |
|-------0--------|
|       |        |
|-------1--------|
|       |        |
 ----------------
 */
    //Creating array to store mouth points
    NSMutableArray *arrayPoints = [[NSMutableArray alloc] init];
    
    CGPoint oneThirdLeftPoint = CGPointWithDistance(CGPointMake(CGRectGetMinX(Rect), CGRectGetMinY(Rect)), CGPointMake(CGRectGetMinX(Rect), CGRectGetMaxY(Rect)), CGPointGetDistance(CGPointMake(CGRectGetMinX(Rect), CGRectGetMinY(Rect)), CGPointMake(CGRectGetMinX(Rect), CGRectGetMaxY(Rect)))*1/3);
    
    CGPoint twoThirdLeftPoint = CGPointWithDistance(CGPointMake(CGRectGetMinX(Rect), CGRectGetMinY(Rect)), CGPointMake(CGRectGetMinX(Rect), CGRectGetMaxY(Rect)), CGPointGetDistance(CGPointMake(CGRectGetMinX(Rect), CGRectGetMinY(Rect)), CGPointMake(CGRectGetMinX(Rect), CGRectGetMaxY(Rect)))*2/3);
    
    CGPoint oneThirdRightPoint = CGPointWithDistance(CGPointMake(CGRectGetMaxX(Rect), CGRectGetMinY(Rect)), CGPointMake(CGRectGetMaxX(Rect), CGRectGetMaxY(Rect)), CGPointGetDistance(CGPointMake(CGRectGetMaxX(Rect), CGRectGetMinY(Rect)), CGPointMake(CGRectGetMaxX(Rect), CGRectGetMaxY(Rect)))*1/3);
    
    CGPoint twoThirdRightPoint = CGPointWithDistance(CGPointMake(CGRectGetMaxX(Rect), CGRectGetMinY(Rect)), CGPointMake(CGRectGetMaxX(Rect), CGRectGetMaxY(Rect)), CGPointGetDistance(CGPointMake(CGRectGetMaxX(Rect), CGRectGetMinY(Rect)), CGPointMake(CGRectGetMaxX(Rect), CGRectGetMaxY(Rect)))*2/3);
    
    //RoratePoint( MidPoint of a line, Center point as a base point, angle to rotate).
    [arrayPoints addObject:[NSValue valueWithCGPoint:CGPointRorate(CGPointGetMidPoint(oneThirdLeftPoint, oneThirdRightPoint), CGRectGetCenter(Rect), rotationAngle*180/M_PI)]];
    [arrayPoints addObject:[NSValue valueWithCGPoint:CGPointRorate(CGPointGetMidPoint(twoThirdLeftPoint, twoThirdRightPoint), CGRectGetCenter(Rect), rotationAngle*180/M_PI)]];
    
    return arrayPoints;
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
    
    CGFloat pointX = (innerRect.origin.x+CGRectGetWidth(innerRect)*ratioPointWidth);;
    CGFloat pointY = (innerRect.origin.y+CGRectGetHeight(innerRect)*ratioPointHeight);
    
    return CGPointMake(pointX, pointY);
}

NSArray* CGPointsAspectFit(NSArray* points, CGSize destSize, CGRect sourceRect)
{
    NSMutableArray *newPoints = [[NSMutableArray alloc] init];
    
    for (NSValue *aValue in points)
        [newPoints addObject:[NSValue valueWithCGPoint:CGPointAspectFit([aValue CGPointValue], destSize, sourceRect)]];

    return newPoints;
}


CGPoint CGPointAspectFill(CGPoint point, CGSize destSize, CGRect sourceRect)
{
    return CGPointMake(point.x*(sourceRect.size.width/destSize.width), point.y*(sourceRect.size.height/destSize.height));
}


CGPoint CGPointAspectFitToTopLeft(CGPoint point, CGSize expectedSize, CGRect originRect)
{
    CGRect aspectFitRect = CGRectAspectFitRect(expectedSize, originRect);
    
    CGPoint originPoint = CGPointOffset(point, -aspectFitRect.origin.x, -aspectFitRect.origin.y);
    
    CGFloat widthRatio = expectedSize.width/aspectFitRect.size.width;
    CGFloat heightRatio = expectedSize.height/aspectFitRect.size.height;
    
    return CGPointScale(originPoint, widthRatio, heightRatio);
}

CGRect CGRectAspectFitToTopLeft(CGRect rect, CGSize expectedSize, CGRect originRect)
{
    CGRect aspectFitRect = CGRectAspectFitRect(expectedSize, originRect);
    
    rect = CGRectOffset(rect, -aspectFitRect.origin.x, -aspectFitRect.origin.y);
    
    CGFloat widthRatio = expectedSize.width/aspectFitRect.size.width;
    CGFloat heightRatio = expectedSize.height/aspectFitRect.size.height;
    
    CGRect scaledRect = CGRectScaleRect(rect, widthRatio, heightRatio);
    return scaledRect;
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

NSArray* CGPointsOffset(NSArray *points, CGFloat dx, CGFloat dy)
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (NSValue *value in points)
        [array addObject:[NSValue valueWithCGPoint:CGPointOffset([value CGPointValue], dx, dy)]];
    
    return array;
}

CGSize CGSizeScale(CGSize aSize, CGFloat wScale, CGFloat hScale)
{
    return CGSizeMake(aSize.width * wScale, aSize.height * hScale);
}

CGPoint CGPointScale(CGPoint aPoint, CGFloat wScale, CGFloat hScale)
{
    return CGPointMake(aPoint.x * wScale, aPoint.y * hScale);
}

NSArray* CGPointsScale(NSArray* points, CGFloat wScale, CGFloat hScale)
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (NSValue *value in points)
         [array addObject:[NSValue valueWithCGPoint:CGPointScale([value CGPointValue], wScale, hScale)]];
        
    return array;
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


