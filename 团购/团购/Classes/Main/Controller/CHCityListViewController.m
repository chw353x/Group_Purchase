//
//  CHCityListViewController.m
//  团购
//
//  Created by chenwei on 16/9/18.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHCityListViewController.h"
#import "CHMetaDataTool.h"
#import "CHCitySection.h"
#import "CHCity.h"
#import "CHSearchResultViewController.h"

#define KSEARCHBARHEIGHT        44          // 搜索栏的高度

@interface CHCityListViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    UITableView     *_tableView;
    UISearchBar     *_searchBar;
    UIView          *_cover;        // 蒙版
    
    NSMutableArray  *_citiesSections;       // 所有的城市组
    CHSearchResultViewController *_searchResultView;
}
@end

@implementation CHCityListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加搜索栏
    [self addSearchBar];
    // 添加表格
    [self addTableView];
    
    // 获取城市数据
    [self getCitiesData];
}

// 添加搜索栏
- (void)addSearchBar
{
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.frame = CGRectMake(0, 0, self.view.frame.size.width, KSEARCHBARHEIGHT);
    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    searchBar.delegate = self;
    searchBar.placeholder = @"请输入城市名或拼音";
    [self.view addSubview:searchBar];
    _searchBar= searchBar;
}
// 添加表格
- (void)addTableView
{
    UITableView *tableView = [[UITableView alloc] init];
    CGFloat h = self.view.frame.size.height - KSEARCHBARHEIGHT;
    tableView.frame = CGRectMake(0, KSEARCHBARHEIGHT, self.view.frame.size.width, h);
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
}

#pragma mark - 获取所有城市数据
- (void)getCitiesData
{
    _citiesSections = [NSMutableArray array];
    NSArray *array = [CHMetaDataTool sharedCHMetaDataTool].cityAllSections;
    [_citiesSections addObjectsFromArray:array];
}

#pragma mark - uitableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _citiesSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CHCitySection *s = _citiesSections[section];
    return s.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    CHCitySection *s = _citiesSections[indexPath.section];
    CHCity *city = s.cities[indexPath.row];
    cell.textLabel.text = city.name;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CHCitySection *s = _citiesSections[section];
    return [NSString stringWithFormat:@"    %@", s.name];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    // 取出_CitiesData中所有key为name的值
    return [_citiesSections valueForKeyPath:@"name"];
}

#pragma mark - uitableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHCitySection *s = _citiesSections[indexPath.section];
    CHCity *city = s.cities[indexPath.row];
    
    [CHMetaDataTool sharedCHMetaDataTool].currentCity = city;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 0, tableView.frame.size.width, 0);
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.backgroundColor = [UIColor colorWithRed:246.0/255 green:246.0/255 blue:246.0/255 alpha:1.0f];
    titleLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    return titleLabel;
}

#pragma mark - search bar delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if (searchText.length == 0) {
        [_searchResultView.view removeFromSuperview];
    } else {
        if (_searchResultView == nil) {
            _searchResultView = [[CHSearchResultViewController alloc] init];
            [self addChildViewController:_searchResultView];
            _searchResultView.view.frame = _cover.frame;
            _searchResultView.view.autoresizingMask = _cover.autoresizingMask;
        }
        _searchResultView.searchText = searchText;
        [self.view addSubview:_searchResultView.view];
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES];
    
    if (_cover == nil) {
        _cover = [[UIView alloc] init];
        _cover.backgroundColor = [UIColor blackColor];
        _cover.frame = _tableView.frame;
        _cover.autoresizingMask = _tableView.autoresizingMask;
        UITapGestureRecognizer *singleTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)];
        [_cover addGestureRecognizer:singleTouch];
    }
    _cover.alpha = 0.0f;
    [UIView animateWithDuration:0.3 animations:^{
        _cover.alpha = 0.6f;
    }];
    
    [self.view addSubview:_cover];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self coverClick];
}

#pragma mark - 遮罩点击事件
- (void)coverClick
{
    [UIView animateWithDuration:0.3 animations:^{
        _cover.alpha = 0.0f;
    }completion:^(BOOL finished) {
        // 移除遮盖
        [_cover removeFromSuperview];
        _cover = nil;
    }];
    // 隐藏取消按钮
    [_searchBar setShowsCancelButton:NO animated:YES];
    // 隐藏键盘
    [_searchBar resignFirstResponder];
}

@end
