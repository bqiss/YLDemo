//
//  SideMenuViewController.m
//  MaShang
//
//  Created by abc on 20/7/29.
//  Copyright © 2020年 WHK. All rights reserved.
//

#import "SideMenuViewController.h"
#import "AppData.h"
#import "ViewManager.h"
#import "LoginViewController.h"
@interface SideMenuViewController ()

@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setUI];
}
-(void)setUI
{
    //头像
    UIImageView *headIamge=[[UIImageView alloc]initWithFrame:CGRectMake(16, 27, 32, 32)];
    headIamge.image=[UIImage imageNamed:@"icon_mine @2x"];
    [self.view addSubview:headIamge];
    
    //userName
    UILabel *userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headIamge.frame)+12, CGRectGetMinY(headIamge.frame)+3, 200,20 )];
    userNameLabel.font=[UIFont systemFontOfSize:18];
    userNameLabel.textColor=[UIColor blackColor];
    userNameLabel.text=[AppData shareInstance].userInfo.username;
    [self.view addSubview:userNameLabel];
    //审批
    UIImageView *waitImage=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(headIamge.frame), CGRectGetMaxY(headIamge.frame)+56, CGRectGetWidth(headIamge.frame), CGRectGetHeight(headIamge.frame))];
    waitImage.image=[UIImage imageNamed:@"icon_wait@2x"];
    [self.view addSubview:waitImage];
    UIButton *waitBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(userNameLabel.frame),CGRectGetMinY(waitImage.frame)+6 , 60, 20)];
    [waitBtn setTitle:@"待审批" forState:UIControlStateNormal];
    waitBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    [waitBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [self.view addSubview:waitBtn];
    //密码
    UIImageView *passWordImage=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(headIamge.frame), CGRectGetMaxY(waitImage.frame)+25, CGRectGetWidth(headIamge.frame), CGRectGetHeight(headIamge.frame))];
    passWordImage.image=[UIImage imageNamed:@"icon_password@2x"];
    [self.view addSubview:passWordImage];
    UIButton *passwordBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(userNameLabel.frame),CGRectGetMinY(passWordImage.frame)+6 , 80, 20)];
    [passwordBtn setTitle:@"修改密码" forState:UIControlStateNormal];
    passwordBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    [passwordBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [self.view addSubview:passwordBtn];
    //exit
    UIImageView *exitImage=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(headIamge.frame), ScreenHeight-45, 32, 32)];
    exitImage.image=[UIImage imageNamed:@"icon_quit@2x"];
    [self.view addSubview:exitImage];
    UIButton *exitBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(waitBtn.frame),CGRectGetMinY(exitImage.frame)+6 , CGRectGetWidth(passwordBtn.frame), CGRectGetHeight(waitBtn.frame))];
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [exitBtn addTarget:self action:@selector(exitLogin:) forControlEvents:UIControlEventTouchUpInside];
    exitBtn.tag=11111;
    [self.view addSubview:exitBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)exitLogin:(UIButton *)sender
{
    long int tag=sender.tag;
    if (tag==11111) {
        //栈里的即时性数据
        [AppData shareInstance].userInfo=nil;
        //堆里的即时性数据
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:@"authorization"];
        [defaults removeObjectForKey:@"USERINFO"];
        //获取当前控制器数组
        NSMutableArray *vcArray=[NSMutableArray arrayWithArray:[ViewManager shareInstance].NavigationController.viewControllers];
        //移除当前控制器
        [vcArray removeAllObjects];
        
        //添加新控制器
        LoginViewController *vc=[LoginViewController new];
        [vcArray addObject:vc];
        //重新设置
        [self.navigationController setViewControllers:vcArray animated:YES];
        
        
    }
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
