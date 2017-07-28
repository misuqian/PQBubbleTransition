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
    //获取当前VC的containerView
    UIView *containerView = [transitionContext containerView];
    if (self.transitionMode == PQBubbleTransitionModePresent) {
        //获取跳转VC的containerView
        UIView *presentedControllerView = nil;
        if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
            presentedControllerView = [transitionContext viewForKey:UITransitionContextToViewKey];
        }
        else {
            presentedControllerView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
        }
        //计算圆形覆盖跳转VC的大小
        CGPoint originalCenter = presentedControllerView.center;
        CGSize originalSize = presentedControllerView.frame.size;
        CGFloat lengthX = fmax(self.startPoint.x, originalSize.width - self.startPoint.x);
        CGFloat lengthY = fmax(self.startPoint.y, originalSize.height - self.startPoint.y);
        CGFloat offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2;
        size = CGSizeMake(offset, offset);
        //将跳转VC的containerView添加到当前VC的containerView
        presentedControllerView.center = self.startPoint;
        presentedControllerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        presentedControllerView.alpha = 1;
        [containerView addSubview:presentedControllerView];
        //将纯色圆形View添加到当前VC的containerView(注意顺序，要覆盖了presentedControllerView)
        UIView* bubble = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        bubble.layer.cornerRadius = size.height/2.0f;
        bubble.center = self.startPoint;
        //先缩小到0.001倍再放大
        bubble.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        bubble.backgroundColor = self.bubbleColor;
        [containerView addSubview: bubble];
        //放大动画，完成后移除bubble并且completeTransition
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
        //获取返回的VC的containerView
        UIView *returningControllerView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        //创建纯色圆形View
        UIView* bubble = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        bubble.backgroundColor = self.bubbleColor;
        bubble.layer.cornerRadius = size.height / 2.0f;
        bubble.center = self.startPoint;
        bubble.alpha = 0.0;
        [containerView addSubview: bubble];
        //调用返回VC的viewWillAppear。Fix viewWillAppear not call
        [[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] viewWillAppear:YES];
        //bubble先增加透明度渐显
        [UIView animateWithDuration:0.5 animations:^{
            bubble.alpha = 1.0;
        } completion:^(BOOL finished) {
            //returningControllerView和bubble一起慢慢变小。完成后移除并completeTransition
            [UIView animateWithDuration:self.duration animations:^{
                returningControllerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                returningControllerView.center = self.startPoint;
                returningControllerView.alpha = 0;
                bubble.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
            } completion:^(BOOL finished) {
                [returningControllerView removeFromSuperview];
                [bubble removeFromSuperview];
                //完成了调用返回VC的viewDidAppear。Fix viewDidAppear not call
                [[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] viewDidAppear:YES];
                [transitionContext completeTransition:finished];
            }];
        }];
    }
}



@end
