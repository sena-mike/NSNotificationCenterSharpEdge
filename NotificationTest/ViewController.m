//
//  ViewController.m
//  NotificationTest
//
//  Created by Sena, Michael on 4/17/17.
//  Copyright © 2017 Sena, Michael. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)dealloc
{
    NSLog(@"viewcontroller dealloc");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ViewController *aNewVC = [[ViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:aNewVC animated:YES];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    NSNotificationCenter * __weak center = [NSNotificationCenter defaultCenter];

    // Try putting __weak in front of either of these declarations
    // In the current state this is a retain cycle
    typeof(self) weakSelf = self;
    id __block weakObserver = nil;

    weakObserver = [center addObserverForName:UIApplicationDidBecomeActiveNotification
                                   object:nil
                                    queue:nil
                               usingBlock:^(NSNotification *note) {
                                   [center removeObserver:weakObserver];
                                   [weakSelf doSomething];
                               }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)doSomething
{
    NSLog(@"do something: %lu", [self.navigationController.viewControllers indexOfObject:self]);
}

@end
