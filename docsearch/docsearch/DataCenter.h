//
//  DataCenter.h
//  Canada
//
//  Created by zhaojianguo on 13-10-11.
//  Copyright (c) 2013年 zhaojianguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataCenter : NSObject
{
    NSMutableArray * schoolDetailInfor;
}
@property (nonatomic,readonly) NSMutableArray * schoolDetailInfor;
@property (nonatomic,readonly) NSMutableArray * boothInfor;
@property (nonatomic,readonly) NSMutableDictionary *boothRects;
+(DataCenter *)shareData;
-(void)loadData;
-(void)loadBoothData;
-(void)loadBoothRectData;
@end
