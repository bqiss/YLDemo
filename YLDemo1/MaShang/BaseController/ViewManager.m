//
//  ViewManager.m
//  单例
//
//  Created by 陈剑英 on 2017/10/28.
//  Copyright © 2017年 陈剑英. All rights reserved.
//

#import "ViewManager.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "SideMenuViewController.h"
#import "MMDrawerController.h"
#import "UserInfo.h"
#import "AppData.h"


static ViewManager *_myInstance;


@implementation ViewManager

@synthesize NavigationController = _navigationController;


+(ViewManager *)shareInstance
{
    if (_myInstance == nil)
    {
        _myInstance = [[ViewManager alloc]init];
    }
    
    return _myInstance;
}

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        //        DutyViewController *vc = [DutyViewController new];
        //        LoginViewController *lvc = [LoginViewController new];
        
        NSData *dataDic=[[NSUserDefaults standardUserDefaults]objectForKey:@"USERINFO"];
        UserInfo *user=[NSKeyedUnarchiver unarchiveObjectWithData:dataDic];
        if (user.name.length!=0) {
            [AppData shareInstance].userInfo=user;
            //跳转到首页
            HomeViewController *vc=[HomeViewController new];
            SideMenuViewController *svc=[SideMenuViewController new];
            MMDrawerController *mmvc=[[ MMDrawerController alloc]initWithCenterViewController:vc leftDrawerViewController:svc];
            [mmvc setShowsShadow:YES];
            [mmvc setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
            [mmvc setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
            _navigationController = [[UINavigationController alloc]initWithRootViewController:mmvc];
        }
        else
        {
            LoginViewController *vc=[LoginViewController new];
            _navigationController =[[UINavigationController alloc]initWithRootViewController:vc];
        }
    }
    _navigationController.navigationBar.hidden = YES;
    _navigationController.interactivePopGestureRecognizer.enabled = NO;
    return self;
}
@end

