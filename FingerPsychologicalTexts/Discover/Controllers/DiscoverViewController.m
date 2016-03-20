//
//  DiscoverViewController.m
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "DiscoverViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "ProgressHUD.h"
#import "PrefixHeader.pch"
#import <CoreLocation/CoreLocation.h>
#import "Header.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "StarTextViewController.h"
#import "ZMYNetManager.h"
#import "Reachability.h"
static NSString *itemIntentfier = @"itemIdentifier";
static NSString *headIndentfier = @"headIndentfier";

@interface DiscoverViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSInteger _offset;//定义请求页码
}

@property (nonatomic, assign) BOOL refreshing;
@property (nonatomic,retain) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *viewnumArray;
@property (nonatomic, strong) NSMutableArray *commentnumArray;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, strong) NSMutableArray *discoverIdArray;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end
@implementation DiscoverViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //请求网络数据
    [self loadData];
    [self.view addSubview:self.collectionView];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewDidAppear:animated];
    [ProgressHUD dismiss];
}

#pragma mark ---------- 点击六个Button推出测试视图
//点击六个Button推出测试视图
- (void)pressBtnTypes:(PressButtonType)pressBtnType{
    NSString *category_id = @"1";
    if (pressBtnType == PressButtonTypeLove) {
        category_id = @"1";
    }else if (pressBtnType == PressButtonTypeCharacter){
        category_id = @"2";
    }else if (pressBtnType == PressButtonTypePower){
        category_id = @"3";
    }else if (pressBtnType == PressButtonTypeMember){
        category_id = @"4";
    }else if (pressBtnType == PressButtonTypeMajor){
        category_id = @"5";
    }
    LoveViewController *loverVC = [[LoveViewController alloc] init];
    loverVC.btnId = category_id;
    [self.navigationController pushViewController:loverVC animated:YES];
}
//解析数据
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
    [sessionManager GET:[NSString stringWithFormat:@"%@&offset=%ld",kDiscover,(long)_offset] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        QJZLog(@"downloadProgress = %@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QJZLog(@"responseObject = %@",responseObject);
    
        NSDictionary *dic = responseObject;
        NSArray *dataArray = dic[@"data"];
        for (NSDictionary *dict in dataArray) {
            [self.imageArray addObject:dict[@"cover"]];
            [self.titleArray addObject:dict[@"title"]];
            [self.viewnumArray addObject:dict[@"viewnum"]];
            [self.commentnumArray addObject:dict[@"commentnum"]];
            [self.contentArray addObject:dict[@"content"]];
            [self.discoverIdArray addObject:dict[@"id"]];
        }
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QJZLog(@"error = %@",error);
    }];
}
#pragma mark -------- UICollectionViewDataSource
//返回的是item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    QJZLog(@"self.imageArray.count = %ld",(unsigned long)self.imageArray.count);
    return self.imageArray.count;
}
//返回1个分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemIdentifier" forIndexPath:indexPath];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 160, 100)];
    [image sd_setImageWithURL:[NSURL URLWithString:self.imageArray[indexPath.row]]placeholderImage:nil];
    image.backgroundColor = [UIColor whiteColor];
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 160, 50)];
    titleLable.text = self.titleArray[indexPath.row];
    titleLable.backgroundColor = [UIColor whiteColor];
    //设置字体大小
    titleLable.font = [UIFont systemFontOfSize:15.0];
    titleLable.numberOfLines = 0;
    [cell addSubview:image];
    [cell addSubview:titleLable];
    return cell;
}
#pragma mark -------- 点击选择哪个图片
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    StarTextViewController *startTextVC = [[StarTextViewController alloc] init];
    startTextVC.title = self.titleArray[indexPath.row];
    startTextVC.image = self.imageArray[indexPath.row];
    startTextVC.viewnum = self.viewnumArray[indexPath.row];
    startTextVC.commentnum = self.commentnumArray[indexPath.row];
    startTextVC.content = self.contentArray[indexPath.row];
    startTextVC.startId = self.discoverIdArray[indexPath.row];
    [self.navigationController pushViewController:startTextVC animated:YES];
}
- (void)selectItemAtIndexPath:(nullable NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UICollectionViewScrollPosition)scrollPosition{
    scrollPosition = UICollectionViewScrollPositionTop;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    HeadCollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headIndentfier forIndexPath:indexPath];
    //添加的代理 （在初始化的地方添加）执行点击按钮然后去推出相应的页面
    headView.delegate = self;
    return headView;
}
#pragma mark ----------- lazy loading
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        //创建一个layout布局类
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置布局方向（默认垂直方向）
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置每一行间距
        layout.minimumLineSpacing = 1;
        //设置item间距
        layout.minimumInteritemSpacing = 1;
        //section的间距 上，左，下，右
        layout.sectionInset = UIEdgeInsetsMake(2, 5, 2, 0);
        //设置区头区尾大小
        layout.headerReferenceSize = CGSizeMake(kWidth, 464);
        //设置每个item的大小
        layout.itemSize = CGSizeMake(kWidth/2-10,kWidth/2+10);
        //通过一个layout布局来创建一个collectionView
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
        //设置代理
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        //上拉刷新  停不下来
//        self.refreshControl = [[UIRefreshControl alloc] init];
//        [self.collectionView addSubview:self.refreshControl];
        //注册item类型
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"itemIdentifier"];
        //注册头部
        [self.collectionView registerNib:[UINib nibWithNibName:@"Discover" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIndentfier];
    }
    return _collectionView;
}
- (NSMutableArray *)imageArray{
    if (_imageArray == nil) {
        self.imageArray = [NSMutableArray new];
    }
    return _imageArray;
}
- (NSMutableArray *)titleArray{
    if (_titleArray == nil) {
        self.titleArray = [NSMutableArray new];
    }
    return _titleArray;
}
- (NSMutableArray *)viewnumArray{
    if (_viewnumArray == nil) {
        self.viewnumArray = [NSMutableArray new];
    }
    return _viewnumArray;
}
- (NSMutableArray *)commentnumArray{
    if (_commentnumArray == nil) {
        self.commentnumArray = [NSMutableArray new];
    }
    return _commentnumArray;
}
- (NSMutableArray *)contentArray{
    if (_contentArray == nil) {
        self.contentArray = [NSMutableArray new];
    }
    return _contentArray;
}
- (NSMutableArray *)discoverIdArray{
    if (_discoverIdArray == nil) {
        self.discoverIdArray = [NSMutableArray new];
    }
    return _discoverIdArray;
}
//页面将要出现的时候出现tabBar
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
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
