//
//  UIView+SimpleRipple.h
//  SimpleRipple
//
//  Created by Mauro de Carvalho on 01/29/17.
//  Copyright © 2017 Mauro de Carvalho. All rights reserved.
//

@import UIKit;


@interface UIView (SimpleRipple)

- (void)rippleStartingAt:(CGPoint)origin
               withColor:(UIColor *)color
                duration:(NSTimeInterval)duration
                  radius:(CGFloat)radius
               fadeAfter:(NSTimeInterval)fadeAfter;

@end
