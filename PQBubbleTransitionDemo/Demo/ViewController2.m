//
//  ViewController2.m
//  PQBubbleTransitionDemo
//
//  Created by msiupeng on 2017/7/28.
//  Copyright © 2017年 msiupeng. All rights reserved.
//

#import "ViewController2.h"
#import "PQBubbleTransition.h"

@interface ViewController2 ()<UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic, strong) PQBubbleTransition *transition;

@end

@implementation ViewController2

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *controller = segue.destinationViewController;
    controller.transitioningDelegate = self;
    controller.modalPresentationStyle = UIModalPresentationCustom;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.transition.transitionMode = PQBubbleTransitionModePresent;
    self.transition.startPoint = self.button.center;
    self.transition.bubbleColor = self.button.backgroundColor;
    return self.transition;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.transition.transitionMode = PQBubbleTransitionModeDismiss;
    self.transition.startPoint = self.button.center;
    self.transition.bubbleColor = self.button.backgroundColor;
    return self.transition;
}

-(PQBubbleTransition *)transition
{
    if (!_transition) {
        _transition = [[PQBubbleTransition alloc] init];
    }
    return _transition;
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
