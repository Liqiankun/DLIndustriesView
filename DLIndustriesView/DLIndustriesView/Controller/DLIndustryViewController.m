//
//  DLIndustryViewController.h
//
//  Created by dl_David on 16/7/11.
//  Copyright © 2016年 Benjamin Gordon. All rights reserved.
//

#import "DLIndustryViewController.h"
#import "DLIndustryHeaderView.h"
#import "DLIndustryFooterView.h"
#import "DLIndustryCell.h"
#import "DLIndustryModel.h"
#import "UIColor+Hex.h"
@interface DLIndustryViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray<NSMutableArray *> *dataArray;
@property(nonatomic,strong)DLIndustryModel *model;
@property(nonatomic,assign)BOOL selected;
@property(nonatomic,assign)NSInteger section;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,copy)NSString *areas;
@property(nonatomic,copy)NSString *roles;

-(void)dl_prepareData;
-(void)dl_uiConfig;
-(void)dl_tableViewReloadAction;
-(void)dl_setNavigationTitleWithSelected:(BOOL)selected section:(NSInteger)section andButtonIndex:(NSInteger)buttonIndex;

@end

@implementation DLIndustryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self dl_prepareData];
    [self dl_uiConfig];
    self.areas = @"";
    self.roles = @"";
}

#pragma mark - PrivateMethod
-(void)dl_prepareData
{
    self.dataArray = [DLIndustryModel getIndustryData];
}

-(void)dl_uiConfig
{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];
    self.tableView.tableHeaderView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    self.navigationItem.title = @"行业选择";
}

-(void)dl_tableViewReloadAction{
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0],[NSIndexPath indexPathForRow:0 inSection:1],[NSIndexPath indexPathForRow:0 inSection:2],[NSIndexPath indexPathForRow:0 inSection:3],[NSIndexPath indexPathForRow:0 inSection:4],[NSIndexPath indexPathForRow:0 inSection:5],[NSIndexPath indexPathForRow:0 inSection:6]] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)dl_setNavigationTitleWithSelected:(BOOL)selected section:(NSInteger)section andButtonIndex:(NSInteger)buttonIndex
{
    if (!selected) {
        self.navigationItem.title = @"行业选择";
    }else if(self.section == section && self.index != buttonIndex){
        self.navigationItem.title = @"行业选择";
    }else if(self.section != section){
        self.navigationItem.title = @"行业选择";
    }else{
        self.navigationItem.title = self.navigationItem.title;
    }
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLIndustryCell *industryCell = [DLIndustryCell cellWithTableView:tableView];
    DLIndustryModel *model = (DLIndustryModel *)self.dataArray[indexPath.section][self.index];
    industryCell.hideAllButton = YES;
    if (self.selected && indexPath.section == self.section) {
        industryCell.industryArray = (NSMutableArray *)model.jobs;
        industryCell.hideAllButton = NO;
    }else{
        industryCell.industryArray = (NSMutableArray *)model.jobs;
        industryCell.hideAllButton = YES;
    }
    __weak typeof(self) weakSelf = self;
    [industryCell setButtonClick:^(NSString *buttonTitle){
        weakSelf.title = buttonTitle;
        weakSelf.roles = buttonTitle;
        weakSelf.navigationItem.rightBarButtonItem.enabled = YES;
    }];
    return industryCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DLIndustryHeaderView *headerView = [DLIndustryHeaderView headerFooterViewWithTableView:tableView];
    headerView.industryArray = self.dataArray[section];
    headerView.section = section;
    
    __weak typeof(self) weakSelf = self;
    [headerView setButtonClick:^(NSInteger section,NSInteger buttonIndex,BOOL selected,NSString *buttonTitle){
        if (weakSelf.model) {
            weakSelf.model.selected = NO;
        }
        DLIndustryModel *model = (DLIndustryModel *)weakSelf.dataArray[section][buttonIndex];
        weakSelf.model = model;
        model.selected = selected;
        weakSelf.selected = selected;
        [weakSelf dl_setNavigationTitleWithSelected:selected section:section andButtonIndex:buttonIndex];
        if (weakSelf.section != section) {
            NSRange range = NSMakeRange(self.section, 1);
            NSIndexSet *sectionSet = [NSIndexSet indexSetWithIndexesInRange:range];
            [weakSelf.tableView reloadSections:sectionSet withRowAnimation:UITableViewRowAnimationFade];
        }
        weakSelf.section = section;
        weakSelf.index = buttonIndex;
        [weakSelf dl_tableViewReloadAction];
        
        if (buttonTitle == nil) {
            weakSelf.areas = nil;
            weakSelf.roles = nil;
        }else{
            weakSelf.areas = buttonTitle;
        }
    
        [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
        weakSelf.navigationItem.rightBarButtonItem.enabled = NO;
    }];
    
    return headerView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    DLIndustryFooterView *footerView = [DLIndustryFooterView headerFooterViewWithTableView:tableView];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selected && indexPath.section == self.section) {
        DLIndustryModel *model = (DLIndustryModel *)self.dataArray[self.section][self.index];
        return model.cellHeight;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
