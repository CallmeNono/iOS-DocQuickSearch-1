//
//  SchoolListesTableViewCell.m
//  Canada
//
//  Created by zhaojianguo on 13-10-8.
//  Copyright (c) 2013年 zhaojianguo. All rights reserved.
//

#import "SchoolListesTableViewCell.h"

@implementation SchoolListesTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIFont * font =[UIFont systemFontOfSize:14.0f];
        UIImage * image = [UIImage imageNamed:@"cell_title.png"];

        
        self.englishNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width-(self.contentView.frame.size.width-10), 10, self.contentView.frame.size.width-image.size.width-5, 25)];
        _englishNameLabel.backgroundColor =[UIColor clearColor];
        _englishNameLabel.font = font;
        [self.contentView addSubview:_englishNameLabel];
        
        self.chianeseNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_englishNameLabel.frame.origin.x, _englishNameLabel.frame.size.height+_englishNameLabel.frame.origin.y+5, _englishNameLabel.frame.size.width, 25)];
        _chianeseNameLabel.backgroundColor =[UIColor clearColor];
        _chianeseNameLabel.font = font;
        [self.contentView addSubview:_chianeseNameLabel];
        
        self.tapImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width-image.size.width-10, (_chianeseNameLabel.frame.size.height/2+_chianeseNameLabel.frame.origin.y)-25/2, image.size.width, image.size.height)];
        _tapImageView.backgroundColor =[UIColor clearColor];
        if ([reuseIdentifier hasPrefix:@"searchCell"]) {
            _tapImageView.frame =CGRectMake(self.contentView.frame.size.width-image.size.width-30, (_chianeseNameLabel.frame.size.height/2+_chianeseNameLabel.frame.origin.y)-25/2, image.size.width, image.size.height);
        }else{
            
        }
        [_tapImageView setImage:image];
        [self.contentView addSubview:_tapImageView];
        
        self.cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(_chianeseNameLabel.frame.origin.x, _chianeseNameLabel.frame.size.height+_chianeseNameLabel.frame.origin.y+5, _chianeseNameLabel.frame.size.width/2, 25)];
        _cityLabel.backgroundColor =[UIColor clearColor];
        _cityLabel.font = font;
        [self.contentView addSubview:_cityLabel];
        
        self.schoolTypeLabel =  [[UILabel alloc] initWithFrame:CGRectMake(_cityLabel.frame.origin.x+_cityLabel.frame.size.width, _cityLabel.frame.origin.y, _cityLabel.frame.size.width, 25)];
        _schoolTypeLabel.backgroundColor =[UIColor clearColor];
        _schoolTypeLabel.font = font;
        [self.contentView addSubview:_schoolTypeLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
