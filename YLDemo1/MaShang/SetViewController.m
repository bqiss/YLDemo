//
//  SetViewController.m
//  MaShang
//
//  Created by abc on 20/7/20.
//  Copyright © 2020年 WHK. All rights reserved.
//

#import "SetViewController.h"
#import "DSToast.h"
#import "CCFetchTool.h"
#import "SVProgressHUD.h"
@interface SetViewController ()
{
    UITextField *passwordText_1;
    UITextField *passwordText_2;
    UIButton *confirmBtn;
    UITextField *nowtext;
}

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setUI];
    UIImage *image=[UIImage imageNamed:@"top_back_icon@3x"];
    [self setBackBtnImage:image];
    NSLog(@"%@",TOKEN);

    
}
-(void)setUI
{
    UILabel *setLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 71, 100, 33.5)];
    setLabel.text=@"设置密码";
    setLabel.textColor=[UIColor blackColor];
    setLabel.font=[UIFont systemFontOfSize:24];
    [self.view addSubview:setLabel];
    UILabel *PasswordLabel_1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 152.5,315 ,16.5 )];
    //PasswordLabel_1
    PasswordLabel_1.text = @"输入旧密码";
    PasswordLabel_1.font = [UIFont systemFontOfSize:14];
    PasswordLabel_1.textColor = [UIColor blackColor];
    [self.view addSubview:PasswordLabel_1];
    //passwordText_1
    passwordText_1 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(PasswordLabel_1.frame), CGRectGetMinY(PasswordLabel_1.frame)+25, 350, 30)];
    passwordText_1.placeholder = @"请输入旧密码";
    [passwordText_1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllEditingEvents];
    [self.view addSubview:passwordText_1];
    //线条1
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(passwordText_1.frame), CGRectGetMaxY(passwordText_1.frame), CGRectGetWidth(passwordText_1.frame), 1)];
    [ line1 setBackgroundColor:GRAYColor];
    [self.view addSubview:line1];
    //passwordlabel_2
    UILabel *passwordLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(line1.frame), CGRectGetMinY(line1.frame)+15, 315, 16.5)];
    passwordLabel.text=@"输入新密码";
    passwordLabel.textColor=[UIColor blackColor];
    passwordLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:passwordLabel];
    //passwordtext_2
    passwordText_2 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(line1.frame), CGRectGetMinY(passwordLabel.frame)+25, 350, 30)];
    passwordText_2.placeholder = @"请输入新密码";
    [passwordText_2 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllEditingEvents];
    passwordText_2.secureTextEntry=YES;
    [self.view addSubview:passwordText_2];
    //线条2
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(passwordText_2.frame), CGRectGetMaxY(passwordText_2.frame), CGRectGetWidth(passwordText_2.frame), 1)];
    [line2  setBackgroundColor:GRAYColor];
    [self.view addSubview:line2 ];
    //queren按钮
    confirmBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(line1.frame), CGRectGetMaxY(line2.frame)+30, ScreenWidth-2*CGRectGetMinX(line1.frame), 50)];
    [confirmBtn setBackgroundColor:GRAYColor2];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.view addSubview:confirmBtn];
    confirmBtn.layer.cornerRadius=4;
    confirmBtn.layer.masksToBounds=YES;
    confirmBtn.enabled=NO;
    [confirmBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    //密文输入按钮
    UIButton *secureBtn=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-(CGRectGetMinX(line1.frame))-20, CGRectGetMinY(passwordText_1.frame), 20, 15)];
    [secureBtn setBackgroundImage:[UIImage imageNamed:@"logan_password_nosee@3x"]forState:UIControlStateNormal];
    [secureBtn addTarget:self action:@selector(clickDisplayTextfieldText:) forControlEvents:UIControlEventTouchUpInside];
    passwordText_2.secureTextEntry=YES;
    passwordText_1.secureTextEntry=YES;
    [self.view addSubview:secureBtn];
    
}
-(void)push
{
    [self setNewPassword:passwordText_1.text :passwordText_2.text];
    
//    [self.navigationController popToRootViewControllerAnimated:YES];
    
   
    
}
-(void)btnChangeColor
{
    if ((passwordText_1.text.length>=6)&&(passwordText_2.text.length>=6)) {
        [confirmBtn setBackgroundColor:BLUEColor];
        confirmBtn.enabled=YES;
    }
    else
    {
        [confirmBtn setBackgroundColor:GRAYColor2];
    }
}
//
-(void)clickDisplayTextfieldText:(UIButton *)sender
{
    sender.selected=!sender.selected;
    
    [nowtext becomeFirstResponder];
    if (sender.selected) {
        
        passwordText_1.secureTextEntry=NO;
        passwordText_2.secureTextEntry=NO;
        [sender setBackgroundImage:[UIImage imageNamed:@"logan_password_see@3x"]forState:UIControlStateNormal];
    }
    else
    {
        passwordText_1.secureTextEntry=YES;
        passwordText_2.secureTextEntry=YES;
        [sender setBackgroundImage:[UIImage imageNamed:@"logan_password_nosee@3x"]forState:UIControlStateNormal];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)textFieldDidChange:(UITextField *)textField
{
    [self btnChangeColor];
    nowtext=textField;
        if (textField.text.length>=6) {
            textField.text=[textField.text substringToIndex:6];
        }
    
    
}

#pragma mark  网络请求
-(void)setNewPassword:(NSString *)oldPassword :(NSString *)password
{
    
    NSDictionary *param=@{
                          @"oldPass":oldPassword,
                          @"pass":password
                          };
    
    [[CCFetchTool sharedClient]POST:@"7003/api/change/psw" parameters:param Success:^(id responseObject) {
        [SVProgressHUD dismiss];
        
        BOOL sucess=[[responseObject objectForKey:@"sucess"]boolValue];
        if (sucess==YES) {
            DSToast *toast=[[DSToast alloc]initWithText:@"密码修改成功"];
            [toast showInView:self.view showType:DSToastShowTypeCenter];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
