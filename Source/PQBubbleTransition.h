//
//  PQBubbleTransition.h
//
//  Created by msiupeng on 2017/7/27.
//  Copyright © 2017年 msiupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PQBubbleTransitionMode) {
    PQBubbleTransitionModePresent,
    PQBubbleTransitionModeDismiss,
};

@interface PQBubbleTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) PQBubbleTransitionMode transitionMode;
@property (nonatomic, strong) UIColor *bubbleColor;

@end
