//
//  Egg_TellerAppDelegate.m
//  Egg Teller
//
//  Created by Ishaan Gandhi on 7/23/11.
//  Copyright 2011 Ishaan Gandhi Studios. All rights reserved.
//

#import "Egg_TellerAppDelegate.h"

#import "Egg_TellerViewController.h"

@implementation Egg_TellerAppDelegate


@synthesize window=_window;

@synthesize viewController=_viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
     
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    [_viewController showSplash];
    return YES;
}

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

@end
