//
//  HomeViewController.m
//  MaShang
//
//  Created by abc on 20/7/28.
//  Copyright © 2020年 WHK. All rights reserved.
//

#import "HomeViewController.h"
#import "MMDrawerController.h"
#import "SideMenuViewController.h"
#import "AppData.h"
#import "AttViewController.h"

#define TAG 10000
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    topBar.hidden=YES;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setUI];
    
    
    
}
-(void)setUI
{
    //hello
    UILabel *helloLabel=[[UILabel alloc]initWithFrame:CGRectMake(16, 27, 200, 32)];
    helloLabel.font=[UIFont systemFontOfSize:22];
    helloLabel.textColor=[UIColor blackColor];
    NSString *str1=[AppData shareInstance].userInfo.name;
    NSString *str=[NSString stringWithFormat:@"你好，%@",str1];
        helloLabel.text=str;
    [self.view addSubview:helloLabel];
    //image
    UIImageView *banner=[[UIImageView alloc]initWithFrame:CGRectMake(16, 74, ScreenWidth-32, 150)];
    banner.image=[UIImage imageNamed:@"banner@2x"];
    [self.view addSubview:banner];
    //功能label
    UILabel *toolLabel=[[UILabel alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(banner.frame)+18, 75, 25)];
    toolLabel.font=[UIFont systemFontOfSize:18];
    toolLabel.textColor=[UIColor blackColor];
    toolLabel.text=@"我的功能";
    [self.view addSubview:toolLabel];
    //btn
    NSArray *imageNameArr=@[@"bg_record@2x",@"bg_attence@2x",@"bg_ask@2x"];
    NSArray *tipArr=@[@"记录轨迹",@"考勤打卡",@"请假申请"];
    NSArray *textArr=@[@"工作轨迹随时开启",@"工作状况及时了解",@"早审批早安心"];
    for (int i=0; i<3; i++) {
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(toolLabel.frame)+94*i+14, ScreenWidth-32,80 )];
        [btn setBackgroundImage:[UIImage imageNamed:imageNameArr[i]] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        UILabel *tipLabel=[[UILabel alloc]initWithFrame:CGRectMake(14, 19.5, 200, 16)];
        tipLabel.text=tipArr[i];
        tipLabel.font=[UIFont systemFontOfSize:16];
        tipLabel.textColor=[UIColor whiteColor];
        [btn addSubview:tipLabel];
        UILabel *textLabel=[[UILabel alloc]initWithFrame:CGRectMake(14, 48, 300, 13)];
        textLabel.text=textArr[i];
        textLabel.font=[UIFont systemFontOfSize:13];
        textLabel.textColor=[UIColor whiteColor];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=TAG+i;
        [btn addSubview:textLabel];
        
    }
}
-(void)btnClick:(UIButton *)sender
{
    if (sender.tag==TAG+1) {
        AttViewController *att=[AttViewController new];
        [self.navigationController pushViewController:att animated:YES];
    }
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
