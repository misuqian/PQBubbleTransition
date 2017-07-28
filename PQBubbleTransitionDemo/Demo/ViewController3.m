//
//  ViewController3.m
//  PQBubbleTransitionDemo
//
//  Created by msiupeng on 2017/7/28.
//  Copyright © 2017年 msiupeng. All rights reserved.
//

#import "ViewController3.h"

@interface ViewController3 ()

@end

@implementation ViewController3

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
