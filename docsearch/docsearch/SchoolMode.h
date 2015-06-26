//
//  SchoolMode.h
//  Canada
//
//  Created by zhaojianguo on 13-10-11.
//  Copyright (c) 2013年 zhaojianguo. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SchoolBooth : NSObject
@property (nonatomic,copy) NSString * boothNumber;
@property (nonatomic,copy) NSString * boothCity;
@end


@interface SchoolMode : NSObject
@property (nonatomic,copy) NSString * enName; //英文名称
@property (nonatomic,copy) NSString * chName;//中文名称
@property (nonatomic,copy) NSString * province;//省份
@property (nonatomic,copy) NSString * category;//学校类型
@property (nonatomic,copy) NSString * email;//邮箱
@property (nonatomic,copy) NSString * phoneNumber;//电话
@property (nonatomic,copy) NSString * website;//网址
@property (nonatomic,copy) NSString * information; //介绍
@property (nonatomic,retain) NSMutableArray * images; //
@property (nonatomic,retain) NSMutableArray * booths;//

@end

@interface SchoolBoothRect : NSObject
@property (nonatomic,copy) NSString * boothNumber;
@property (nonatomic,assign) CGRect  rect;
@end

