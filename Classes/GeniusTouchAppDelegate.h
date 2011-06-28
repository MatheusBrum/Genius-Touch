//
//  GeniusTouchAppDelegate.h
//  GeniusTouch
//
//  Created by Matheus Brum on 11/06/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GeniusTouchViewController;

@interface GeniusTouchAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    GeniusTouchViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GeniusTouchViewController *viewController;

@end

