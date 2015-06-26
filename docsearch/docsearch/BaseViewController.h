//
//  BaseViewController.h
//  Canada
//
//  Created by zhaojianguo on 13-10-9.
//  Copyright (c) 2013年 zhaojianguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZNavigationView.h"
@interface BaseViewController : UIViewController<ZZNavigationViewDelegate>
@property (nonatomic,strong) ZZNavigationView * navigation;
@end
