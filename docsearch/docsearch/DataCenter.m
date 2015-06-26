//
//  DataCenter.m
//  Canada
//
//  Created by zhaojianguo on 13-10-11.
//  Copyright (c) 2013年 zhaojianguo. All rights reserved.
//

#import "DataCenter.h"
#import "SchoolMode.h"

@implementation DataCenter
@synthesize schoolDetailInfor;
@synthesize boothInfor;
@synthesize boothRects;
+(DataCenter *)shareData
{
    static DataCenter * dataCenter;
    if (dataCenter ==nil) {
        dataCenter  = [[DataCenter alloc] init];
    }
    return dataCenter;
}

-(id)init
{
    if (self = [super init]) {
        schoolDetailInfor = [[NSMutableArray alloc] init];
        boothInfor = [[NSMutableArray alloc] init];
        boothRects = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)loadData
{
	NSString * path = [[NSBundle mainBundle]pathForResource:@"SchoolData" ofType:@"txt"];
    NSString * string =[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
	NSArray *array = [string componentsSeparatedByString:@"\n"];
    
    for (NSString * string in array) {
		NSArray *temp = [string componentsSeparatedByString:@"###"];
        SchoolMode * mode = [[SchoolMode alloc] init];
        mode.enName = [temp objectAtIndex:0];
        mode.chName = [temp objectAtIndex:1];
        mode.province = [temp objectAtIndex:2];
        mode.category = [temp objectAtIndex:3];
        mode.email = [temp objectAtIndex:4];
        mode.phoneNumber = [temp objectAtIndex:5];
        mode.website = [temp objectAtIndex:6];
        mode.information = [temp objectAtIndex:7];
        
        for (int index =1; index<10; index++) {
            NSString * name = [NSString stringWithFormat:@"%@%d.jpg",mode.enName,index];
            UIImage * image = [UIImage imageNamed:name];
            if (image!=nil) {
                [mode.images addObject:image];
            }else{
                break;
            }
        }
        [schoolDetailInfor addObject:mode];
    }
    //    NSLog(@"%@",schoolDetailInfor);
}
-(void)loadBoothData
{
    NSString * path = [[NSBundle mainBundle]pathForResource:@"SchoolBooth" ofType:@"txt"];
    NSString * string =[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
	NSArray *array = [string componentsSeparatedByString:@"\n"];
    for (NSString * string in array) {
		NSArray *temp = [string componentsSeparatedByString:@"###"];
        NSString * name = [temp objectAtIndex:0];
        for (SchoolMode * sub in self.schoolDetailInfor) {
            if ([sub.chName isEqualToString:name]) {
//                NSLog(@"%@,%@",name,sub.chName);
                for (int index = 0; index<[temp count]; index++) {
                    if (index ==0) {
                    }else{
                        if (index+1>[temp count]-1) {
                            break;
                        }
                        SchoolBooth * booth = [[SchoolBooth alloc] init];
                        booth.boothCity = [temp objectAtIndex:index];
                        booth.boothNumber = [temp objectAtIndex:index+1];
                        [sub.booths addObject:booth];
                        index = index+1;
                    }
                }
                break;
            }
        }
    }
}

-(void)loadBoothRectData
{
    
    NSArray * temp = [NSArray arrayWithObjects:@"北京",@"上海",@"广州",@"重庆",@"南京",@"武汉",@"郑州",nil];
    int count = 1;
    for (NSString * key in temp) {
        NSMutableArray * mutableTemp = [[NSMutableArray alloc] init];
        NSString * name = [NSString stringWithFormat:@"Booth%d",count];
        NSString * path = [[NSBundle mainBundle]pathForResource:name ofType:@"txt"];
        NSString * string =[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSArray *array = [string componentsSeparatedByString:@"\n"];

        for (NSString *sub in array) {
            NSArray * boothNumbers = [sub componentsSeparatedByString:@"###"];
            NSArray * booths = [[[sub componentsSeparatedByString:@"###"] lastObject] componentsSeparatedByString:@","];
            SchoolBoothRect * booth = [[SchoolBoothRect alloc] init];
            booth.boothNumber = [boothNumbers objectAtIndex:0];
            CGFloat x = [[booths objectAtIndex:0] floatValue];
            CGFloat y = [[booths objectAtIndex:1] floatValue];
            CGFloat width = [[booths objectAtIndex:2] floatValue];
            CGFloat height = [[booths objectAtIndex:3] floatValue];
            CGRect rect = CGRectMake(x, y, width, height);
            booth.rect =rect;
            [mutableTemp addObject:booth];
        }
//        NSLog(@"%@",mutableTemp);
        [self.boothRects setObject:mutableTemp forKey:key];
        count+=1;
    }
}
@end
