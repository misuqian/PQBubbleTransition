//
//  PQBubbleTransition.m
//
//  Created by msiupeng on 2017/7/27.
//  Copyright © 2017年 msiupeng. All rights reserved.
//  Edit from andreamazz/BubbleTransition

#import "PQBubbleTransition.h"

@interface PQBubbleTransition ()

@end

@implementation PQBubbleTransition{
    CGSize size;
}

-(instancetype)init
{
    if (self = [super init]) {
        self.startPoint = CGPointZero;
        self.duration = 0.5f;
        self.transitionMode = PQBubbleTransitionModePresent;
        self.bubbleColor = [UIColor redColor];
    }
    return self;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    
    if (self.transitionMode == PQBubbleTransitionModePresent) {
        UIView *presentedControllerView = nil;
        if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
            presentedControllerView = [transitionContext viewForKey:UITransitionContextToViewKey];
        }
        else {
            presentedControllerView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
        }
        
        CGPoint originalCenter = presentedControllerView.center;
        CGSize originalSize = presentedControllerView.frame.size;
        CGFloat lengthX = fmax(self.startPoint.x, originalSize.width - self.startPoint.x);
        CGFloat lengthY = fmax(self.startPoint.y, originalSize.height - self.startPoint.y);
        CGFloat offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2;
        size = CGSizeMake(offset, offset);
        
        presentedControllerView.center = self.startPoint;
        presentedControllerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        presentedControllerView.alpha = 1;
        [containerView addSubview:presentedControllerView];
        
        UIView* bubble = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        bubble.layer.cornerRadius = size.height/2.0f;
        bubble.center = self.startPoint;
        bubble.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        bubble.backgroundColor = self.bubbleColor;
        [containerView addSubview: bubble];
        
        [UIView animateWithDuration:self.duration animations:^{
            bubble.transform = CGAffineTransformIdentity;
            presentedControllerView.transform = CGAffineTransformIdentity;
            presentedControllerView.center = originalCenter;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                bubble.alpha = 0.0;
            } completion:^(BOOL finished) {
                [bubble removeFromSuperview];
                [transitionContext completeTransition:finished];
            }];
        }];

    }
    else if (self.transitionMode == PQBubbleTransitionModeDismiss) {
        UIView *returningControllerView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView* bubble = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        bubble.backgroundColor = self.bubbleColor;
        bubble.layer.cornerRadius = size.height / 2.0f;
        bubble.center = self.startPoint;
        bubble.alpha = 0.0;
        [containerView addSubview: bubble];
        //Fix viewWillAppear not call
        [[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] viewWillAppear:YES];
        [UIView animateWithDuration:0.5 animations:^{
            bubble.alpha = 1.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:self.duration animations:^{
                returningControllerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                returningControllerView.center = self.startPoint;
                returningControllerView.alpha = 0;
                bubble.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
            } completion:^(BOOL finished) {
                [returningControllerView removeFromSuperview];
                [bubble removeFromSuperview];
                //Fix viewDidAppear not call
                [[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] viewDidAppear:YES];
                [transitionContext completeTransition:finished];
            }];
        }];
    }
}



@end
