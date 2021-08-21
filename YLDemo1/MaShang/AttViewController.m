//
//  AttViewController.m
//  MaShang
//
//  Created by abc on 20/7/31.
//  Copyright © 2020年 WHK. All rights reserved.
//

#import "AttViewController.h"
#import "CCFetchTool.h"
#import <BMKLocationKit/BMKLocationComponent.h>
#import <BMKLocationKit/BMKLocationAuth.h>
#import "DSToast.h"
#import "AttStateModel.h"
#import "AppData.h"
#define AK @"wEk8ADbkwcTgrZFHxNcuWn9FhUfCDxXA"
@interface AttViewController ()<BMKLocationAuthDelegate,BMKLocationManagerDelegate,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
@property(nonatomic,strong)BMKLocatingCompletionBlock completionBlock;
@property(nonatomic,strong)BMKLocationManager *locationManager;
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) CLLocationManager *lcManager;
@end

@implementation AttViewController
{
    UIView *circleView;
    AttStateModel *attModel;
    UILabel *daka;
    CLLocationManager *currentLocationManager;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(circleView.frame)+83,ScreenWidth-32,ScreenHeight-CGRectGetMaxY(circleView.frame)-83  ) style:UITableViewStylePlain ];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        
    }
    return _tableView;
}
-(BMKLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[BMKLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
        _locationManager.pausesLocationUpdatesAutomatically = NO;
        _locationManager.allowsBackgroundLocationUpdates = YES;
        _locationManager.locationTimeout = 10;
        _locationManager.reGeocodeTimeout = 10;
    }
    return _locationManager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     [self getAttState];
    [self.view setBackgroundColor:WhiteColor];
    [topBar setBackBtnImage:[UIImage imageNamed:@"top_back_icon@3x"]];
    [topBar setTopTitle:@"考勤打卡" ];
    [self setUI];
    //百度定位  第一步
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:AK authDelegate:self];
    [self YHGetLocationPermissionVerifcationWithController:self];
    [self initBlock];
    [self.locationManager requestLocationWithReGeocode:YES withNetworkState:YES completionBlock:self.completionBlock];
    [self.view addSubview:self.tableView];
    
   
 }
-(void)setUI
{
    //圆圈
    circleView = [[UIView alloc] init];
    circleView.frame = CGRectMake(126,82,123,123);
    circleView.layer.cornerRadius=123/2;
    circleView.layer.borderWidth=15;
    circleView.layer.masksToBounds=YES;
    circleView.layer.borderColor=[CJColor(171, 220, 252)CGColor];
    circleView.layer.backgroundColor = [UIColor colorWithRed:50/255.0 green:163/255.0 blue:255/255.0 alpha:1.0].CGColor;
    [self.view addSubview:circleView];
    //上班打卡label
    daka=[[UILabel alloc]initWithFrame:CGRectMake(28.5,38.5 , 66,22.5 )];
    daka.font=[UIFont systemFontOfSize:16];
    daka.textColor=[UIColor whiteColor];
    daka.text=@"上班打卡";
    [circleView addSubview:daka];
    
}
#pragma mark 表函数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [AppData shareInstance].userInfo.attGroup.count*2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellid1=@"1";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid1];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(CJX(32),CJY(16),CJX(36),CJX(36))];
        view1.layer.borderWidth = 1;
        view1.layer.borderColor =CJColor(145, 154, 161).CGColor;
        view1.layer.cornerRadius = CJX(18);
        view1.layer.masksToBounds = YES;
        [cell addSubview:view1];
        
        UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(CJX(6),CJX(6),CJX(24), CJX(24))];
        view2.backgroundColor = CJColor(145, 154, 161);
        view2.layer.cornerRadius = CJX(12);
        view2.layer.masksToBounds = YES;
        [view1 addSubview:view2];
        
        UILabel *line = [self createLine:CGRectMake(CJX(50), CGRectGetMaxY(view1.frame)+CJY(16),0.5,CJY(108))];
        line.backgroundColor = CJColor(215, 220, 224);
        [cell addSubview:line];
        
        UILabel *title = [self createLabel:CGRectMake(CGRectGetMaxX(view1.frame)+CJX(32),CGRectGetMinY(view1.frame),CJX(140), CJY(36)) title:@"上班打卡1" fontSize:13 textColor:CJColor(114, 117, 119)];
        title.tag = 10000;
        [cell addSubview:title];
        
        UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(line.frame)+CJX(48), CGRectGetMaxY(title.frame)+CJY(16),CJX(618),CJY(160))];
        view3.backgroundColor = CJColor(240, 247, 255);
        view3.layer.cornerRadius = CJX(8);
        view3.layer.masksToBounds = YES;
        [cell addSubview:view3];
        
        UILabel *time = [self createLabel:CGRectMake(CJX(32),(CJY(160)-CJY(32))/2,CJX(300),CJY(32)) title:@"打卡时间: 08:00" fontSize:16 textColor:CJColor(51, 52, 54)];
        time.tag = 10001;
        [view3 addSubview:time];
        
        UILabel *lab3 = [self createLabel:CGRectMake(CGRectGetMaxX(time.frame)+CJX(120),(CJY(160)-CJY(96))/2,CGRectGetHeight(time.frame),CJY(96)) title:@"正常" fontSize:12 textColor:CJColor(20, 143, 255)];
        lab3.tag = 10002;
        lab3.textAlignment = NSTextAlignmentCenter;
        lab3.layer.cornerRadius = 4;
        lab3.layer.masksToBounds = YES;
        lab3.layer.borderColor =CJColor(20, 143, 255).CGColor;
        lab3.layer.borderWidth = 0.5;
        CGSize size = [lab3.text boundingRectWithSize:CGSizeMake(0,1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
        lab3.frame = CGRectMake(CGRectGetMinX(lab3.frame), CGRectGetMinY(lab3.frame), size.width+37,CGRectGetHeight(lab3.frame));
        [view3 addSubview:lab3];
        
    }
    UILabel *title = [cell viewWithTag:10000];
    UILabel *time = [cell viewWithTag:10001];
    UILabel *type = [cell viewWithTag:10002];
    
    //标题
    title.text = (indexPath.row < 2)?((indexPath.row % 2 == 0)?@"上班打卡1":@"下班打卡1"):((indexPath.row % 2 == 0)?@"上班打卡2":@"下班打卡2");
    //时间
    NSArray *cardList = [AppData shareInstance].userInfo.attGroup;
    NSMutableArray *timeList = [NSMutableArray array];
    for (NSDictionary *dic in cardList)
    {
        NSString *startTime = [dic objectForKey:@"start"];
        NSString *endTime = [dic objectForKey:@"end"];
        [timeList addObject:startTime];
        [timeList addObject:endTime];
        
    }
    time.text = [NSString stringWithFormat:@"打卡时间：%@",timeList[indexPath.row]];
    //状态
   
    NSArray *stateList = attModel.stateList;
    if (indexPath.row < stateList.count)
    {
        
        
        NSDictionary *stateArr = stateList[indexPath.row];
        NSString *state = [stateArr objectForKey:@"state"];
        type.text = state;
        
        type.textColor = MainColor;
       
        if ([state isEqualToString:@"正常"])
        {
            type.backgroundColor = WhiteColor;
            type.layer.borderColor = CJColor(20, 143, 255).CGColor;
            type.textColor =CJColor(20, 143, 255);
            
        }
        else if ([state isEqualToString:@"迟到"])
        {
            type.backgroundColor = WhiteColor;
            type.layer.borderColor = CJColor(255, 199, 97).CGColor;
            type.textColor =CJColor(255, 199, 97);
        }
        else if ([state isEqualToString:@"早退"])
        {
            type.backgroundColor = WhiteColor;
            type.textColor =CJColor(255, 97, 97);
            type.layer.borderColor = CJColor(255, 97, 97).CGColor;
        }
        else if ([state isEqualToString:@"外勤"])
        {
            type.backgroundColor = WhiteColor;
            type.textColor =CJColor(100, 213, 195);
            type.layer.borderColor = CJColor(175, 237, 229).CGColor;
        }
        else if ([state isEqualToString:@"缺卡"])
        {
            type.textColor =WhiteColor;
            type.backgroundColor =CJColor(255, 97, 97);
            type.layer.borderColor = CJColor(255, 97, 97).CGColor;
        }
        else if ([state isEqualToString:@"旷工"])
        {
            type.textColor =CJColor(255, 97, 97);
            type.backgroundColor = WhiteColor;
            type.layer.borderColor = CJColor(255, 97, 97).CGColor;
        }
        else if ([state isEqualToString:@"请假"])
        {
            type.layer.borderColor = CJColor(20, 143, 255).CGColor;
            type.textColor =CJColor(20, 143, 255);
            type.backgroundColor = WhiteColor;
        }
        
        //判断是否是外勤 如果是：外勤（正常、迟到、早退）
        if ([[stateArr objectForKey:@"outer"] isEqualToString:@"1"])
        {
            type.backgroundColor = WhiteColor;
            type.textColor =CJColor(100, 213, 195);
            type.layer.borderColor = CJColor(175, 237, 229).CGColor;
            type.text = [NSString stringWithFormat:@"外勤(%@)",state];
        }
        
    }
    else
    {
        type.text = @"未打卡";
        type.textColor = [UIColor grayColor];
        type.layer.borderColor = [UIColor grayColor].CGColor;
        type.backgroundColor = WhiteColor;
    }

    return cell;
}
-(void)initBlock
{
    __weak AttViewController *weakSelf = self;

    [weakSelf.locationManager requestLocationWithReGeocode:YES withNetworkState:YES completionBlock:^(BMKLocation * _Nullable location, BMKLocationNetworkState state, NSError * _Nullable error) {
        self.completionBlock = ^(BMKLocation *location, BMKLocationNetworkState state, NSError *error)
        {
            if (error)
            {
                NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            }
            if (location) {//得到定位信息，添加annotation
                
                if (location.location) {
                    NSLog(@"LOC = %@",location.location);
                }
                if (location.rgcData) {
                    NSLog(@"rgc = %@",[location.rgcData description]);
                }
                
                if (location.rgcData.poiList) {
                    for (BMKLocationPoi * poi in location.rgcData.poiList) {
                        NSLog(@"poi = %@, %@, %f, %@, %@", poi.name, poi.addr, poi.relaiability, poi.tags, poi.uid);
                    }
                }
                
                if (location.rgcData.poiRegion) {
                    NSLog(@"poiregion = %@, %@, %@", location.rgcData.poiRegion.name, location.rgcData.poiRegion.tags, location.rgcData.poiRegion.directionDesc);
                }
                
            }
        };
    }];

}
#pragma mark 获取考勤状态
-(void)getAttState

{
    [[CCFetchTool sharedClient] GET:@"user/att/state" parameters:nil Success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        BOOL success = [[responseObject objectForKey:@"success"]boolValue];
        if (success == YES)
        {
            NSDictionary *dic = [responseObject objectForKey:@"data"];
            attModel =[[AttStateModel alloc]initWithDictionary:dic error:nil];
            [self dakaChangeColor];
            [self.tableView reloadData];
            
        
        }
        else
        {
            NSString *msg = [responseObject objectForKey:@"msg"];
            DSToast *toast = [[DSToast alloc]initWithText:msg];
            [toast showInView:self.view];
        }
        
        
        
    } Failure:^(id error) {
        
        NSLog(@"%@",error);
        
    }];
}
-(void)dakaChangeColor
{
    if (attModel.isActivate) {
        
    }
    else
    {
        circleView.layer.borderColor=CJColor(208, 213, 234).CGColor;
        [circleView setBackgroundColor:CJColor(117, 152, 193)];
        daka.text=@"无法打卡";
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ****************************** 获取位置验证权限
/**
 获取位置验证权限(作用域: 地图 & 定位相关)
 @param vc 当前视图控件
 */
- (void)YHGetLocationPermissionVerifcationWithController:(UIViewController *)vc
{
    BOOL enable = [CLLocationManager locationServicesEnabled];
    NSInteger state = [CLLocationManager authorizationStatus];
    
    if (!enable || 2 > state) {// 尚未授权位置权限
        if (8 <= [[UIDevice currentDevice].systemVersion floatValue]) {
            NSLog(@"系统位置权限授权弹窗");
            // 系统位置权限授权弹窗
            currentLocationManager = [[CLLocationManager alloc] init];
            currentLocationManager.delegate = self;
            [currentLocationManager requestAlwaysAuthorization];
            [currentLocationManager requestWhenInUseAuthorization];
        }
    }
    else {
        if (state == kCLAuthorizationStatusDenied) {// 授权位置权限被拒绝
            NSLog(@"授权位置权限被拒绝");
            UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示"
                                                                              message:@"访问位置权限暂未授权"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
            [alertCon addAction:[UIAlertAction actionWithTitle:@"暂不设置" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            [alertCon addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                dispatch_after(0.2, dispatch_get_main_queue(), ^{
                    NSURL *url = [[NSURL alloc] initWithString:UIApplicationOpenSettingsURLString];// 跳转至系统定位授权
                    if( [[UIApplication sharedApplication] canOpenURL:url]) {
                        [[UIApplication sharedApplication] openURL:url];
                    }
                });
            }]];
            
            [vc presentViewController:alertCon animated:YES completion:^{
                
            }];
        }
    }
}



@end
