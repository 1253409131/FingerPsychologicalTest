//
//  LoveViewController.m
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "LoveViewController.h"
#import "LoveTableViewCell.h"
#import "PullingRefreshTableView.h"
#import "HWTool.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "PrefixHeader.pch"
#import "Header.h"
#import "StarTextViewController.h"
#import "UIViewController+Common.h"
#import "ZMYNetManager.h"
#import "Reachability.h"
@interface LoveViewController ()<UITableViewDelegate,UITableViewDataSource,PullingRefreshTableViewDelegate>
{
    NSInteger _offset;//定义请求页码

    
}
@property (nonatomic, assign) BOOL refreshing;
@property (nonatomic, strong) PullingRefreshTableView *tableView;
@property (nonatomic, strong) NSMutableArray *loveArray;
@property (nonatomic, strong) NSMutableArray *lovesArray;//爱情
@property (nonatomic, strong) NSMutableArray *characterArray;//性格
@property (nonatomic, strong) NSMutableArray *powerArray;//能力
@property (nonatomic, strong) NSMutableArray *memberArray;//会员
@property (nonatomic, strong) NSMutableArray *majorArray;//专业
@property (nonatomic, strong) NSMutableArray *likePlarArray;//好玩应用

@end

@implementation LoveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackButtonWithImage:@"back"];
    if ([self.btnId isEqualToString:@"1"]) {
        self.title = @"爱情测试";
    }else if ([self.btnId isEqualToString:@"2"]){
        self.title = @"性格测试";
    }else if ([self.btnId isEqualToString:@"3"]){
        self.title = @"能力测试";
    }else if ([self.btnId isEqualToString:@"4"]){
        self.title = @"会员测试";
    }else{
        self.title = @"专业测试";
    }
    self.view.backgroundColor = [UIColor redColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"LoveTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.tableView];
    [self.tableView launchRefreshing];
    
    //根据上一页选择按钮，确定显示哪个页面
    [self showSelectButton];
}


#pragma mark --------- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.loveArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LoveTableViewCell *loveCell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    loveCell.loveModel = self.loveArray[indexPath.row];
    return loveCell;
}

#pragma mark -------- UITableViewDelegate
//点击每一行推到下一个开始测试页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LoveModel *loveModel = self.loveArray[indexPath.row];
    StarTextViewController *starTextVC = [[StarTextViewController alloc] init];
    starTextVC.title = loveModel.title;
    starTextVC.viewnum = loveModel.viewnum;
    starTextVC.commentnum = loveModel.commentnum;
    starTextVC.image = loveModel.image;
    starTextVC.content = loveModel.content;
    starTextVC.startId = loveModel.loveId;
    [self.navigationController pushViewController:starTextVC animated:YES];

}

#pragma mark --------- PULLingRetreshTableViewDelegate
//tableView开始刷新的时候调用
//上拉
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    self.refreshing = NO;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0];
    _offset += 10;
}

//下拉
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    self.refreshing = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0];
    _offset = 0;
}
//刷新完成时间
- (NSDate *)pullingTableViewRefreshingFinishedDate{
    return [HWTool getSystemNowDate];
}

//加载数据
- (void)loadData{
    if (![ZMYNetManager shareZMYNetManager].isZMYNetWorkRunning) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的网络有问题，请检查网络" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            QJZLog(@"确定");
        }];
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            QJZLog(@"取消");
        }];
        //
        [alert addAction:action];
        [alert addAction:quxiao];
        [self presentViewController:alert animated:YES completion:nil];
    }

    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [sessionManager GET:[NSString stringWithFormat:@"%@&category_id=%@&offset=%ld",kLove,_btnId, (long)_offset] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        QJZLog(@"downloadProgress = %@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QJZLog(@"responseObject = %@",responseObject);
        
        NSDictionary *dic = responseObject;
        NSArray *dataArray = dic[@"data"];
        //下拉刷新的时候需要移除数组中的数据
        if (self.refreshing) {
            if (self.loveArray.count > 0) {
                [self.loveArray removeAllObjects];
            }
        }
        for (NSDictionary *dict in dataArray) {
            LoveModel *model = [[LoveModel alloc] initWithDictionary:dict];
            [self.loveArray addObject:model];
        }
        [self.tableView reloadData];
        
        
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QJZLog(@"error = %@",error);
    }];
    
    //完成加载
    [self.tableView tableViewDidFinishedLoading];
    self.tableView.reachedTheEnd = NO;
    
}



//选择按钮六个
- (void)showSelectButton{
    

}




//手指开始拖动的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
}
//手指结束拖动的方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}

#pragma mark --------- Lazy loadign
- (PullingRefreshTableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64) pullingDelegate:self];
        self.tableView.rowHeight = 280;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
    }
    return _tableView;
}

- (NSMutableArray *)loveArray{
    if (_loveArray == nil) {
        self.loveArray = [NSMutableArray new];
        
    }
    return _loveArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
