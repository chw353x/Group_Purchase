//
//  CHSearchResultViewController.m
//  团购
//
//  Created by chenwei on 16/9/19.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHSearchResultViewController.h"
#import "CHMetaDataTool.h"
#import "CHCity.h"
#import "PinYin4Objc.h"

@interface CHSearchResultViewController ()
{
    NSMutableArray      *_resultArray;           // 搜索结果
}
@end

@implementation CHSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _resultArray = [NSMutableArray array];
}

- (void)setSearchText:(NSString *)searchText
{
    _searchText = searchText;
    
    // 清空搜索结果数组
    [_resultArray removeAllObjects];
    NSDictionary *cities = [CHMetaDataTool sharedCHMetaDataTool].totalCities;
    
    HanyuPinyinOutputFormat *fmt = [[HanyuPinyinOutputFormat alloc] init];
    fmt.caseType = CaseTypeUppercase;
    fmt.vCharType = VCharTypeWithUUnicode;
    fmt.toneType = ToneTypeWithoutTone;
    
    // 按照搜索字段筛选城市
    [cities enumerateKeysAndObjectsUsingBlock:^(NSString *key, CHCity *obj, BOOL *stop) {
        
        // 得到城市名的拼音
        NSString *pinying = [PinyinHelper toHanyuPinyinStringWithNSString:obj.name withHanyuPinyinOutputFormat:fmt withNSString:@""];
        
        // 将城市的拼音分割
        NSArray *words = [pinying componentsSeparatedByString:@"#"];
        // 获取城市名的拼音首字母
        NSMutableString *headerStr = [NSMutableString string];
        for (NSString *str in words) {
            [headerStr appendString:[str substringToIndex:1]];
        }
        
        // 去掉拼音中的#号
        [pinying stringByReplacingOccurrencesOfString:@"#" withString:@""];
        // 可按照汉字、拼音和拼音首字母搜索
        if ([obj.name rangeOfString:searchText].length != 0 || [pinying rangeOfString:searchText.uppercaseString].length != 0 || [headerStr rangeOfString:searchText.uppercaseString].length != 0) {
            [_resultArray addObject:obj];
        }
    }];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _resultArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    CHCity *city = _resultArray[indexPath.row];
    cell.textLabel.text = city.name;
    return cell;
}

#pragma mark 分组表头的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"    共%lu个搜索结果", (unsigned long)[_resultArray count]];
}

#pragma mark 分组头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25.0;
}

#pragma mark - Table view delegate
#pragma mark 自定义分组表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 0, tableView.frame.size.width, 0);
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.backgroundColor = [UIColor colorWithRed:246.0/255 green:246.0/255 blue:246.0/255 alpha:1.0f];
    titleLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    return titleLabel;
}

#pragma mark cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHCity *city = _resultArray[indexPath.row];
    
    [CHMetaDataTool sharedCHMetaDataTool].currentCity = city;
}




@end
