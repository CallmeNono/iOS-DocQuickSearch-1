//
//  ZZNavigationView.h
//  Canada
//
//  Created by zhaojianguo on 13-10-8.
//  Copyright (c) 2013年 zhaojianguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZZNavigationViewDelegate <NSObject>
-(void)previousToViewController;
@optional
-(void)rightButtonClickEvent;
@end

@interface ZZNavigationView : UIView
@property (nonatomic,assign) id<ZZNavigationViewDelegate>delegate;
@property (nonatomic,retain) UIImage * leftImage;
@property (nonatomic,retain) UIImage * headerImage;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,retain) UIImage * rightImage;
@property (nonatomic,assign) UIColor * navigaionBackColor;
@property (nonatomic) NSInteger type;
@end
