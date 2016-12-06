//
//  LKTableViewController.m
//  MVVM
//
//  Created by Mike on 16/8/9.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKTableViewController.h"
#import "LKCell.h"
#import "LKCellModel.h"
#import "LKModel.h"
#import "LKLeftMenuViewController.h"

@interface LKTableViewController ()

@property(nonatomic,strong)LKCellModel *cellModel;

@property(nonatomic,strong)LKModel *model;

@end

@implementation LKTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    LK(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf.cellModel.requestCommand execute:nil];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf.cellModel.nextPageCommand execute:nil];
    }];
    
    [self lk_bindViewModel];
    
}
#pragma mark -private
- (void)lk_bindViewModel
{
    [self.cellModel.requestCommand execute:nil];
    
    @weakify(self);
    [self.cellModel.refreshUISubjext subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    
    [self.cellModel.refreshEndSubjext subscribeNext:^(id x) {
        @strongify(self);
        
        switch ([x integerValue]) {
            case LKHeaderRefresh_HasMoreData:{
               
                [self.tableView.mj_header endRefreshing];
            }
                break;
       
            case LKFooterRefresh_HasMoreData:{
                
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer resetNoMoreData];
                [self.tableView.mj_footer endRefreshing];
                
            }
                break;
            case LKFooterRefresh_HasNoMoreData:{
                
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
                break;
            case LKRefreshError:{
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
            }
                break;
            default:
                break;
        }
    }];
}
#pragma mark -LayzLoad
- (LKCellModel *)cellModel
{
    if (!_cellModel) {
        _cellModel = [[LKCellModel alloc] initWithModel:self.model];
    }
    return _cellModel;
}
- (LKModel *)model
{
    if (!_model) {
        _model = [[LKModel alloc] init];
    }
    return _model;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return self.cellModel.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LKCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    if (!cell) {
        cell = [[LKCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    [cell confinCellWithModel:self.cellModel.dataArr[indexPath.row] indexPath:indexPath];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [LKCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        LKCell *cell = (LKCell *)sourceCell;
        [cell confinCellWithModel:self.cellModel.dataArr[indexPath.row] indexPath:indexPath];
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
  

}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
