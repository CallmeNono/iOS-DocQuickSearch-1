//
//  SchoolListesTableViewCell.h
//  Canada
//
//  Created by zhaojianguo on 13-10-8.
//  Copyright (c) 2013年 zhaojianguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchoolListesTableViewCell : UITableViewCell
@property (retain,nonatomic) UILabel * englishNameLabel;
@property (retain,nonatomic) UILabel * chianeseNameLabel;
@property (retain,nonatomic) UILabel * cityLabel;
@property (retain,nonatomic) UILabel * schoolTypeLabel;

@property (nonatomic,retain) UIImageView * tapImageView;
@end
