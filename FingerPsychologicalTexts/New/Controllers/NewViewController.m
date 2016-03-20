//
//  NewViewController.m
//  
//
//  Created by scjy on 16/3/3.
//
//

#import "NewViewController.h"
#import "NewTableViewCell.h"
#import "PullingRefreshTableView.h"
#import "HWTool.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "PrefixHeader.pch"
#import "Header.h"
#import "StarTextViewController.h"
#import "ZMYNetManager.h"
#import "Reachability.h"
#import "UIViewController+Common.h"
@interface NewViewController ()<UITableViewDelegate, UITableViewDataSource, PullingRefreshTableViewDelegate>
{
    NSInteger _offset;//定义请求的页码
}
@property (nonatomic, assign) BOOL refreshing;
@property(nonatomic, strong) PullingRefreshTableView *tableView;
@property (nonatomic, strong) NSMutableArray *newsArray;

@end
@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NewTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    [self.view addSubview:self.tableView];
    [self.tableView launchRefreshing];

}

//当页面将要出现的时候隐藏tabBar
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationItem setHidesBackButton:YES];
}
#pragma mark ---------- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewTableViewCell *newCell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    newCell.newsModel = self.newsArray[indexPath.row];
    return newCell;
}

#pragma mark ---------- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewModel *newModel = self.newsArray[indexPath.row];
    StarTextViewController *starTextVC = [[StarTextViewController alloc] init];
    
    starTextVC.title = newModel.title;
    QJZLog(@"--------- = %@",starTextVC.title);
    starTextVC.viewnum = newModel.viewnum;
    starTextVC.commentnum = newModel.commentnum;
    starTextVC.image = newModel.image;
    starTextVC.content = newModel.content;
    starTextVC.startId = newModel.aId;

    [self.navigationController pushViewController:starTextVC animated:YES];
}



#pragma mark ---------- PullingRefreshTableViewDelegate
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
    
    [sessionManager GET:[NSString stringWithFormat:@"%@&offset=%ld",kNew,(long)_offset] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        QJZLog(@"downloadProgress = %@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QJZLog(@"responseObject = %@",responseObject);
        NSDictionary *dic = responseObject;
        NSArray *dataArray = dic[@"data"];
        
        //下拉刷新的时候需要移除数组中的数据
        if (self.refreshing) {
            if (self.newsArray.count > 0) {
                [self.newsArray removeAllObjects];
            }
        }
        for (NSDictionary *dict in dataArray) {
            NewModel *model = [[NewModel alloc] initWithDictionary:dict];
            [self.newsArray addObject:model];
            
        }
        [self.tableView reloadData];
    
        
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QJZLog(@"error = %@",error);
    }];
    
    
    //完成加载
    [self.tableView tableViewDidFinishedLoading];
    self.tableView.reachedTheEnd = NO;
    
}
//手指开始拖动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
}
//手指结束拖动方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}

#pragma mark ----------- Lazy loading
- (PullingRefreshTableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 108, kWidth, kHeight - 108) pullingDelegate:self];
        self.tableView.rowHeight = 280;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return _tableView;
}


- (NSMutableArray *)newsArray{
    if (_newsArray == nil) {
        self.newsArray = [NSMutableArray new];
    }
    return _newsArray;
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
