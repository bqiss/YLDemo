//
//  demo6.7
//
//  Created by abc on 20/6/7.
//  Copyright © 2020年 1132482428@qq.com. All rights reserved.
//


#import "LoginViewController.h"
#import "ForgetViewController.h"
#import "SetViewController.h"
#import "DSToast.h"
#import "CCFetchTool.h"
#import "SVProgressHUD.h"
#import "AppData.h"
#import "UserInfo.h"
#import "SideMenuViewController.h"
#import "MMDrawerController.h"
#import "HomeViewController.h"
@interface LoginViewController ()
{
    UITextField *phoneText;
    UITextField *passwordText;
    UIButton *registerBtn;
    NSInteger textLengh;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    topBar.hidden = YES;
    textLengh=0;
    [self setUI];
    NSLog(@"%@",TOKEN);
    //    setvc.block1 = ^(NSString * text) {
////        DSToast *dst=[[DSToast alloc]initWithText:text];
////        [dst showInView:self.view];
//        NSLog(@"%@",text);
//    };
//    [self post];
}

-(void) setUI
{
    
    
    UILabel *phoneNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 152.5,315 ,16.5 )];
    //phoneLabel
    phoneNumLabel.text = @"手机号码";
    phoneNumLabel.font = [UIFont systemFontOfSize:14];
    phoneNumLabel.textColor = [UIColor blackColor];
    [self.view addSubview:phoneNumLabel];
    //phonetext
    phoneText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(phoneNumLabel.frame), CGRectGetMinY(phoneNumLabel.frame)+25, 350, 30)];
    phoneText.placeholder = @"请输入手机号码";
    [phoneText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllEditingEvents];
    
    [self.view addSubview:phoneText];
    //线条1
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(phoneText.frame), CGRectGetMaxY(phoneText.frame), CGRectGetWidth(phoneText.frame), 1)];
    [ line1 setBackgroundColor:GRAYColor];
    [self.view addSubview:line1];
    //passwordlabel
    UILabel *passwordLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(phoneNumLabel.frame), CGRectGetMinY(line1.frame)+15, 315, 16.5)];
    passwordLabel.text=@"密码";
    passwordLabel.textColor=[UIColor blackColor];
    passwordLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:passwordLabel];
    //passwordtext
    passwordText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(phoneNumLabel.frame), CGRectGetMinY(passwordLabel.frame)+25, 350, 30)];
    passwordText.placeholder = @"请输入密码";
    [passwordText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllEditingEvents];
    passwordText.secureTextEntry=YES;
    [self.view addSubview:passwordText];
    //线条2
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(passwordText.frame), CGRectGetMaxY(passwordText.frame), CGRectGetWidth(passwordText.frame), 1)];
    [line2  setBackgroundColor:GRAYColor];
    [self.view addSubview:line2 ];
    //登录按钮
    registerBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(line2.frame), CGRectGetMaxY(line2.frame)+20, ScreenWidth-2*CGRectGetMinX(line2.frame), 50)];
    [registerBtn setBackgroundColor:GRAYColor2];
    [registerBtn setTitle:@"登录" forState:UIControlStateNormal];
    registerBtn.titleLabel.textColor=[UIColor whiteColor];
    [self.view addSubview:registerBtn];
    registerBtn.layer.cornerRadius=4;
    registerBtn.layer.masksToBounds=YES;
    [registerBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    //忘记密码btn
    UIButton *forgetBtn=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-CGRectGetMinX(line2.frame)-70,CGRectGetMaxY(registerBtn.frame)+20 , 80, 14)];
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    forgetBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [forgetBtn setTitleColor:GRAYColor2 forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(pushForget) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    
    
}
//
-(void)textFieldDidChange:(UITextField *)textField
{
    [self btnChangeColor];
    
    if (textField==phoneText) {
        if (phoneText.text.length>=13) {
            textField.text=[phoneText.text substringToIndex:13];
        }
        else if ((phoneText.text.length==4||phoneText.text.length==9)&&phoneText.text.length>textLengh)
        {
            NSMutableString *string=[[NSMutableString alloc]initWithString:phoneText.text];
            [string insertString:@" " atIndex:phoneText.text.length-1];
            phoneText.text=string;
            
        }
        else if ((phoneText.text.length==4||phoneText.text.length==9)&&phoneText.text.length<textLengh)
        {
            phoneText.text=[NSString stringWithFormat:@"%@",phoneText.text];
            
        }
        textLengh=phoneText.text.length;
        
    }
    else if (textField==passwordText)
    {
        if (passwordText.text.length>=6) {
            textField.text=[passwordText.text substringToIndex:6];
        }
    }
    
}
-(void)btnChangeColor
{
    if ((phoneText.text.length>=13)&&(passwordText.text.length>=6)) {
        [registerBtn setBackgroundColor:BLUEColor];
    }
    else
    {
        [registerBtn setBackgroundColor:GRAYColor2];
    }
}
-(void)pushForget
{
    ForgetViewController *fvc=[[ForgetViewController alloc]init];
    [self.navigationController pushViewController:fvc animated:YES];
}
-(void)send

{
    [SVProgressHUD show];
    [self login:phoneText.text :passwordText.text];
}
-(void)push
{
    HomeViewController *hvc=[[HomeViewController alloc]init];
    SideMenuViewController *svc=[SideMenuViewController new];
    MMDrawerController *mmvc=[[MMDrawerController alloc]initWithCenterViewController:hvc leftDrawerViewController:svc];
    [mmvc setShowsShadow:YES];
    [mmvc setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [mmvc setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [self.navigationController pushViewController:mmvc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 网络请求
-(void)login:(NSString *)username :(NSString *)password
{
    
    NSDictionary *param=@{
                          @"username":username,
                          @"password":password
                          };
    [[CCFetchTool sharedClient]POST:@"login" parameters:param Success:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"请求成功\ndata=%@",responseObject);
        NSDictionary *data=[responseObject objectForKey:@"data"];
        
        BOOL success=[[responseObject objectForKey:@"success"]boolValue];
        if (success==YES) {
            //保存TOKEN
            NSString *token=[NSString stringWithFormat:@"Bearer %@",[data objectForKey:@"token"]];
            [[NSUserDefaults standardUserDefaults]setObject:token  forKey:@"authorization"];
            //请求个人信息
            [self getuserInfo];
            DSToast *toast=[[DSToast alloc]initWithText:@"登录成功"];
            [toast showInView:self.view showType:DSToastShowTypeCenter];
            //跳转
            [self push];
        }
        else
        {
            [SVProgressHUD dismiss];
            NSString *msg=[responseObject objectForKey:@"msg"];
            DSToast *toast=[[DSToast alloc]initWithText:msg];
            [toast showInView:self.view showType:DSToastShowTypeCenter];
        }
        
        
    } Failure:^(id error) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",error);
        
    }];
}
//获取个人信息
-(void)getuserInfo
{
    [[CCFetchTool sharedClient]POST:@"user/info" parameters:nil Success:^(id responseObject) {
        NSLog(@"请求成功\ndata =%@",responseObject);
        BOOL success=[[responseObject objectForKey:@"success"]boolValue];
        if (success==YES) {
            [AppData shareInstance].userInfo=[[UserInfo alloc]initWithDictionary:[responseObject objectForKey:@"data"] error:nil];
            NSData *userInfo=[NSKeyedArchiver archivedDataWithRootObject:[AppData shareInstance].userInfo];
            [[NSUserDefaults standardUserDefaults]setObject:userInfo forKey:@"USERINFO"];
            NSLog(@"%@",[AppData shareInstance].userInfo);
            
        }
        else
        {
            NSString *msg=[responseObject objectForKey:@"msg"];
            DSToast *toast=[[DSToast alloc]initWithText:msg];
            [toast showInView:self.view showType:DSToastShowTypeCenter];
            
        }
    } Failure:^(id error) {
        NSLog(@"%@",error);
    }];
}
-(void)post
{

    [[CCFetchTool sharedClient]POST:@"login" parameters:nil Success:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"请求成功\ndata=%@",responseObject);
        NSDictionary *data=[responseObject objectForKey:@"data"];
        
        BOOL sucess=[[responseObject objectForKey:@"sucess"]boolValue];
        if (sucess==YES) {
            //请求个人信息
            [self getuserInfo];
            [SVProgressHUD dismiss];
            
            DSToast *toast=[[DSToast alloc]initWithText:@"登录成功"];
            [toast showInView:self.view showType:DSToastShowTypeCenter];
            
        }
        else
        {
            [SVProgressHUD dismiss];
            
            DSToast *toast=[[DSToast alloc]initWithText:@"用户认证信息失效"];
            [toast showInView:self.view showType:DSToastShowTypeCenter];
        }
        
        
    } Failure:^(id error) {
        
        NSLog(@"%@",error);
    }];
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
