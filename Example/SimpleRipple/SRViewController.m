//
//  SRViewController.m
//  SimpleRipple
//
//  Created by Mauro de Carvalho on 01/29/17.
//  Copyright (c) 2017 Mauro de Carvalho. All rights reserved.
//

#import "SRViewController.h"

#import "UIView+SimpleRipple.h"


@interface SRViewController ()

@property (weak, nonatomic) IBOutlet UISlider *radiusSlider;
@property (weak, nonatomic) IBOutlet UISlider *durationSlider;

@end


@implementation SRViewController

- (IBAction)touchDown:(id)sender forEvent:(UIEvent *)event {
    UITouch *touch = [[event touchesForView:sender] anyObject];
    CGPoint origin = [touch locationInView:sender];

    float radius = self.radiusSlider.value;
    float duration = self.durationSlider.value;
    float fadeAfter = duration * 0.75f;

    [sender rippleStartingAt:origin withColor:[UIColor colorWithWhite:0.0f alpha:0.20f] duration:duration radius:radius fadeAfter:fadeAfter];
}


@end
