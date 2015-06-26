//
//  SchoolMode.m
//  Canada
//
//  Created by zhaojianguo on 13-10-11.
//  Copyright (c) 2013年 zhaojianguo. All rights reserved.
//

#import "SchoolMode.h"

@implementation SchoolMode
@synthesize enName;
@synthesize chName;
@synthesize province;
@synthesize category;
@synthesize email;
@synthesize phoneNumber;
@synthesize website;
@synthesize information;
@synthesize images;
@synthesize booths;

-(id) init
{
    if (self = [super init]) {
        self.images = [[NSMutableArray alloc] init];
         self.booths = [[NSMutableArray alloc] init];
    }
    return self;
}
@end

@implementation SchoolBooth
@synthesize boothNumber;
@synthesize boothCity;
@end
@implementation SchoolBoothRect
@synthesize boothNumber;
@synthesize rect;
@end