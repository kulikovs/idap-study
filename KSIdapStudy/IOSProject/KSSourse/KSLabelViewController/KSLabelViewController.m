//
//  KSLabelViewController.m
//  KSIdapStudy
//
//  Created by KulikovS on 20.04.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSLabelViewController.h"
#import "KSLabelView.h"

@interface KSLabelViewController ()
@property (nonatomic, readonly) IBOutlet KSLabelView *rootView;

@end

@implementation KSLabelViewController

#pragma mark -
#pragma mark Accessors

- (KSLabelView *)rootView {
    if ([self isViewLoaded] && [self.view isKindOfClass:[KSLabelView class]]) {
        return (KSLabelView *)self.view;
    }
    
    return nil;
}

#pragma mark -
#pragma mark Handling Interface

- (IBAction)onClickAnimationButton:(id)sender {
    [self.rootView moveLabelWithAnimated:YES];
}

- (IBAction)onClickStepButton:(id)sender {
    [self.rootView moveLabelWithAnimated:NO];
}

- (IBAction)onAnimationSwitch:(id)sender {
    [self.rootView changeNameForAnimationSwitch];
}

- (IBAction)onMotionLoopSwitch:(id)sender {
    [self.rootView changeNameForLoopSwitch];
}

@end
