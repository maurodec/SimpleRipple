//
//  UIView+SimpleRipple.m
//  SimpleRipple
//
//  Created by Mauro de Carvalho on 01/29/17.
//  Copyright © 2017 Mauro de Carvalho. All rights reserved.
//

#import "UIView+SimpleRipple.h"


#define FULL (2 * M_PI)
#define RIPPLE_LAYER_NAME @"RippleLayer"

extern inline CGFloat distanceBetween(CGPoint a, CGPoint b) {
    return sqrt(pow(fabs(a.x - b.x), 2) + pow(fabs(a.y - b.y), 2));
}


@implementation UIView (SimpleRipple)

- (void)rippleStartingAt:(CGPoint)origin
               withColor:(UIColor *)color
                duration:(NSTimeInterval)duration
                  radius:(CGFloat)radius
               fadeAfter:(NSTimeInterval)fadeAfter {

    CGRect bounds = self.bounds;
    CGFloat x = CGRectGetWidth(bounds);
    CGFloat y = CGRectGetHeight(bounds);

    // Build an array with the four corners of the view.
    NSArray <NSValue *> *corners = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],
                                     [NSValue valueWithCGPoint:CGPointMake(0, y)],
                                     [NSValue valueWithCGPoint:CGPointMake(x, 0)],
                                     [NSValue valueWithCGPoint:CGPointMake(x, y)]];

    // Calculate the corner closest to the origin and the one farther from it.
    // We might not need these values, but calculate them anyway so that the code
    // is clearer.
    CGFloat minDistance = CGFLOAT_MAX;
    CGFloat maxDistance = -1;

    for (NSValue *cornerValue in corners) {
        CGPoint corner = [cornerValue CGPointValue];
        CGFloat d = distanceBetween(origin, corner);
        if (d < minDistance) {
            minDistance = d;
        }

        if (d > maxDistance) {
            maxDistance = d;
        }
    }

    // Calculate the start and end radius of our ripple effect.
    // If the ripple starts inside the view then the start radis is 0, if it
    // starts outside the view then make the radius the distance to the nearest corner.
    BOOL originInside = origin.x > 0 && origin.x < x && origin.y > 0 && origin.y < y;
    // Note that if 0 is used as a default value then the circle may look misshapen.
    CGFloat startRadius = originInside ? 0.1 : minDistance;

    // If we set a radius use it, if not then use the distance to the farthest corner.
    CGFloat endRadius = radius > 0 ? radius : minDistance;

    // Create paths for out start and end circles.
    UIBezierPath *startPath = [UIBezierPath bezierPathWithArcCenter:origin
                                                             radius:startRadius
                                                         startAngle:0 endAngle:FULL
                                                          clockwise:YES];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:origin
                                                           radius:endRadius
                                                       startAngle:0 endAngle:FULL
                                                        clockwise:YES];

    // Create a new layer to draw the ripple on.
    CAShapeLayer *rippleLayer = [CAShapeLayer layer];
    rippleLayer.name = RIPPLE_LAYER_NAME;
    // Make sure the ripple effect doesn't "leave" the view.
    self.layer.masksToBounds = YES;

    rippleLayer.fillColor = color.CGColor;

    // Create the animation
    CABasicAnimation *rippleAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    rippleAnimation.fillMode = kCAFillModeBoth;
    rippleAnimation.duration = duration;
    rippleAnimation.fromValue = (id)(startPath.CGPath);
    rippleAnimation.toValue = (id)(endPath.CGPath);
    rippleAnimation.removedOnCompletion = NO;
    rippleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

    // Set the ripple layer to be just above the bg.
    [self.layer insertSublayer:rippleLayer atIndex:0];
    // Give the ripple layer the animation.
    [rippleLayer addAnimation:rippleAnimation forKey:nil];

    // Enqueue blocks to handle animation ends.
    // We can use a delegate for this, but it complicates the code as handling
    // animation states is needed as well as @propertys to pass data around.
    // This may not be perfectly times but it is good enough.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, fadeAfter * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        // Add a fade out animation.
        CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeAnimation.fillMode = kCAFillModeBoth;
        fadeAnimation.duration = duration - fadeAfter;
        fadeAnimation.fromValue = @1.0f;
        fadeAnimation.toValue = @0.0f;
        fadeAnimation.removedOnCompletion = NO;

        [rippleLayer addAnimation:fadeAnimation forKey:nil];
    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        // All animations are done, so remove the layer.
        [rippleLayer removeAllAnimations];
        [rippleLayer removeFromSuperlayer];
    });
}

@end
