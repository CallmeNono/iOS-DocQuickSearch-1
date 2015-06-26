//
//  SearchViewController.h
//  Canada
//
//  Created by zhaojianguo on 13-10-8.
//  Copyright (c) 2013年 zhaojianguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface SearchViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate,UISearchBarDelegate>
@property (nonatomic,strong) UITableView * mapTableView;
@property (strong,nonatomic) UISearchBar *searchBar;
@property (strong,nonatomic) UISearchDisplayController *searchDisplay;

@property (nonatomic,strong) NSMutableDictionary * filterDictionary;
@property (nonatomic,strong) NSMutableDictionary * nameDictionary;
@end
