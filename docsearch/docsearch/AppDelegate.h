//
//  AppDelegate.h
//  SuperSearch
//
//  Created by zhaojianguo on 14-3-6.
//  Copyright (c) 2014年 zhaojianguo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) SearchViewController * viewController;
@end
