# PQBubbleTransition

Different version from [andreamazz/BubbleTransition](https://github.com/andreamazz/BubbleTransition).A custom modal transition that presents and dismiss a controller with an expanding bubble effect.

## Screenshot

![Screenshot](https://github.com/misuqian/PQBubbleTransition/blob/master/DemoGIF.gif)

## Setup
Have your viewcontroller conform to `UIViewControllerTransitioningDelegate`. Set the `transitionMode`, the `startingPoint`, the `bubbleColor` and the `duration`.
```Object-C
PQBubbleTransition *transition = [[PQBubbleTransition alloc] init];

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
```
## MIT License

