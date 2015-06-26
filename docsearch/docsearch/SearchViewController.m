//
//  SearchViewController.m
//  Canada
//
//  Created by zhaojianguo on 13-10-8.
//  Copyright (c) 2013年 zhaojianguo. All rights reserved.
//

#import "SearchViewController.h"
#import "SchoolListesTableViewCell.h"
#import "ZZNavigationView.h"
#import "DataCenter.h"
#import "SchoolMode.h"
#import "PinYin4Objc.h"
#import "pinyin.h"
#define DEFAULTKEYS [self.nameDictionary.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]
#define FILTEREDKEYS [self.filterDictionary.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]
#define ALPHA_ARRAY [NSArray arrayWithObjects: @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil]

#define ALPHA	@"ABCDEFGHIJKLMNOPQRSTUVWXYZ"

@interface SearchViewController ()<ZZNavigationViewDelegate>
{
    DataCenter * center;
}
@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    self.nameDictionary = [[NSMutableDictionary alloc]init];
    self.filterDictionary = [[NSMutableDictionary alloc]init];
    center = [DataCenter shareData];
    [self addDataWithSouces:center.schoolDetailInfor :self.nameDictionary];
    
    self.navigation.leftImage  = [UIImage imageNamed:@"nav_backbtn.png"];
    self.navigation.headerImage = [UIImage imageNamed:@"nav_canadaicon.png"];
    self.navigation.title = @"搜索";
    self.navigation.navigaionBackColor = [UIColor colorWithRed:0.0f green:131.0f/255.0f blue:169.0f/255.0f alpha:1.0];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f,self.navigation.frame.size.height, self.view.frame.size.width, 44.0f)];
    _searchBar.delegate =self;
    _searchBar.placeholder = @"搜";
	_searchBar.tintColor = [UIColor lightGrayColor];
	_searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	_searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
	_searchBar.keyboardType = UIKeyboardTypeDefault;
	// Create the search display controller
    
	self.searchDisplay = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
	_searchDisplay.searchResultsDataSource = self;
    _searchDisplay.searchResultsDelegate =self;
    
    
    //	_searchDisplay.searchResultsDelegate = self;
	
	self.mapTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _searchBar.frame.size.height+_searchBar.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-self.navigation.frame.size.height-self.searchBar.frame.size.height)];
    _mapTableView.delegate =self;
    _mapTableView.dataSource = self;
    //    _mapTableView.tableHeaderView = _searchBar;
	[self.view addSubview:_mapTableView];
	// Do any additional setup after loading the view.
    [self.view addSubview:_searchBar];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	[_searchBar setText:@""];
}

-(void)addDataWithSouces:(NSArray *)array :(NSMutableDictionary *)dictionary
{
    if ([dictionary.allKeys count]!=0) {
        [dictionary removeAllObjects];
    }
    for (NSString * string in ALPHA_ARRAY) {
        NSMutableArray * temp = [[NSMutableArray alloc]  init];
        BOOL realExist = NO;
        for (SchoolMode * mode in array) {
            if ([mode.enName hasPrefix:string]) {
                [temp addObject:mode];
                realExist = YES;
            }
        }
        if (realExist) {
            [dictionary setObject:temp forKey:string];
        }
    }
    NSLog(@"%@",self.filterDictionary);
    [_mapTableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self searchTextWith:searchText];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self addDataWithSouces:center.schoolDetailInfor :self.nameDictionary];
}

-(BOOL)searchResult:(NSString *)contactName searchText:(NSString *)searchT{
	if (contactName==nil || searchT == nil || [contactName isEqualToString:@"(null)"]==YES) {
		return NO;
	}
    NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
    NSRange productNameRange = NSMakeRange(0, contactName.length);
    NSRange foundRange = [contactName rangeOfString:searchT options:searchOptions range:productNameRange];
    if (foundRange.length > 0)
        return YES;
    else
        return NO;
}

-(NSString *)nameToPinYinWith:(NSString *)name
{
    HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    NSString *outputPinyin=[PinyinHelper toHanyuPinyinStringWithNSString:name withHanyuPinyinOutputFormat:outputFormat withNSString:@""];
    return outputPinyin;
}
-(NSString *)namToPinYinFisrtNameWith:(NSString *)name
{
    NSString * outputString = @"";
    for (int i =0; i<[name length]; i++) {
        outputString = [NSString stringWithFormat:@"%@%c",outputString,pinyinFirstLetter([name characterAtIndex:i])];

    }
    return outputString;
}

-(void)searchTextWith :(NSString *)searchText
{

    NSMutableArray * array = [[NSMutableArray alloc] init];
    for (int index = 0; index<[self.nameDictionary.allKeys count]; index++) {
        NSArray * temp = [self.nameDictionary objectForKey:[self.nameDictionary.allKeys objectAtIndex:index]];
        for (SchoolMode * mode in temp) {
            NSString * pinyin1 = [self nameToPinYinWith:mode.chName];
            if([self searchResult:pinyin1 searchText:searchText])
            {
                [array addObject:mode];
            }else{
                NSString * pinyin2 = [self namToPinYinFisrtNameWith:mode.chName];
                if([self searchResult:pinyin2 searchText:searchText]){
                    [array addObject:mode];
                }else{
                    if ([self searchResult:mode.chName searchText:searchText]) {
                        [array addObject:mode];
                    }
                }
            }
        }
    }
    [self addDataWithSouces:array :self.filterDictionary];
}

#pragma mark -
#pragma mark Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    NSArray * keys = (tableView==_mapTableView)?DEFAULTKEYS:FILTEREDKEYS;
    return keys.count;

}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSArray * keys = (tableView==_mapTableView)?DEFAULTKEYS:FILTEREDKEYS;
	return keys;
}
// This recipe adds a title for each section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray * keys = (tableView==_mapTableView)?DEFAULTKEYS:FILTEREDKEYS;
	return [keys objectAtIndex:section];
}

// Adding a section index here
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
	return [ALPHA rangeOfString:title].location;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSArray * keys = (tableView==_mapTableView)?DEFAULTKEYS:FILTEREDKEYS;
    NSMutableDictionary * dictionary = (tableView==_mapTableView)?self.nameDictionary:self.filterDictionary;
    NSArray * array = [dictionary objectForKey:[keys objectAtIndex:section]];
	return [array count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	// Retrieve the crayon and its color
    NSArray * keys = (tableView==_mapTableView)?DEFAULTKEYS:FILTEREDKEYS;
    NSMutableDictionary * dictionary = (tableView==_mapTableView)?self.nameDictionary:self.filterDictionary;
    NSArray * array = [dictionary objectForKey:[keys objectAtIndex:indexPath.section]];
    SchoolMode *   mode = [array objectAtIndex:indexPath.row];
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"searchCell%ld%ld",(long)indexPath.section,(long)indexPath.row];
    SchoolListesTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SchoolListesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.englishNameLabel.text = mode.enName;
    cell.chianeseNameLabel.text = mode.chName;
    SchoolBooth * booth;
    if ([mode.booths count]!=0) {
        booth = [mode.booths objectAtIndex:0];
    }
    NSInteger index = [booth.boothCity length];
    cell.cityLabel.text =[NSString stringWithFormat:@"获取方式:%@",index!=0?booth.boothCity:@"模糊"];
    NSString * temp1 = @"题目类型:";
    cell.schoolTypeLabel.text = [NSString stringWithFormat:@"%@%@",temp1,mode.category];
    if (indexPath.row%2==0) {
        cell.contentView.backgroundColor = [UIColor colorWithRed:220.0/255.0f green:246.0/255.0f blue:248.0/255.0f alpha:1.0f];
    }else{
        cell.contentView.backgroundColor = [UIColor colorWithRed:247.0/255.0f green:254.0/255.0f blue:255.0/255.0f alpha:1.0f];
    }
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _mapTableView) {
        return 100.0f;
    }
    return 100.0f;
}
#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray * keys = (tableView==_mapTableView)?DEFAULTKEYS:FILTEREDKEYS;
    NSMutableDictionary * dictionary = (tableView==_mapTableView)?self.nameDictionary:self.filterDictionary;
    NSArray * array = [dictionary objectForKey:[keys objectAtIndex:indexPath.section]];
    SchoolMode *   mode = [array objectAtIndex:indexPath.row];
    NSLog(@"%@",mode.chName);
//    SchoolDetailViewController * viewController =[[SchoolDetailViewController alloc] init];
//    viewController.schoolMode = mode;
//    [self.navigationController pushViewController:viewController animated:YES];
	
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
