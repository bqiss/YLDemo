//
//  ForgetViewController.m
//  MaShang
//
//  Created by abc on 20/7/20.
//  Copyright © 2020年 WHK. All rights reserved.
//

#import "ForgetViewController.h"
#import "JKCountDownButton.h"
#import "DSToast.h"
#import "SetViewController.h"
#import "CCFetchTool.h"
@interface ForgetViewController ()
{
    UITextField *phoneText;
    UITextField *verifyText;
    NSInteger textLengh;
    UITextField *verify;
    UIButton *nextBtn;

}
@property(nonatomic,strong)    NSMutableArray *verifyLabelArr;
@end

@implementation ForgetViewController
-(NSMutableArray *)verifyLabelArr
{
    if (!_verifyLabelArr) {
        _verifyLabelArr=[NSMutableArray array];
    }
    return _verifyLabelArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setUI];
    UIImage *image=[UIImage imageNamed:@"top_back_icon@3x"];
    [self setBackBtnImage:image];
    
}
-(void)setUI
{
    UILabel *forgetLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 71, 100, 33.5)];
    forgetLabel.text=@"找回密码";
    forgetLabel.textColor=[UIColor blackColor];
    forgetLabel.font=[UIFont systemFontOfSize:24];
    [self.view addSubview:forgetLabel];
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
    phoneText.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:phoneText];
    //线条1
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(phoneText.frame), CGRectGetMaxY(phoneText.frame), CGRectGetWidth(phoneText.frame), 1)];
    [ line1 setBackgroundColor:GRAYColor];
    [self.view addSubview:line1];
    //verifyLabel
    UILabel *verifyLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(phoneNumLabel.frame), CGRectGetMinY(line1.frame)+15, 315, 16.5)];
    verifyLabel.text=@"请输入验证码";
    verifyLabel.textColor=[UIColor blackColor];
    verifyLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:verifyLabel];
    //hideTextfield
    verify=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(line1.frame), CGRectGetMaxY(line1.frame)+50, 300, 50)];
    verify.tintColor=[UIColor clearColor];
    verify.textColor=[UIColor clearColor];
        [self.view addSubview:verify];
    UILabel *verifyLine=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(verify.frame), CGRectGetMaxY(verify.frame), ScreenWidth-CGRectGetMinX(verify.frame), 1)];
    [verifyLine setBackgroundColor:GRAYColor2];
    [verify addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllEditingEvents];
    verify.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:verify];
    //verifyTextLabel
    for (int i=0; i<4; i++) {
        CGFloat width=(CGRectGetWidth(line1.frame)-3*20)/4;
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(line1.frame)+i*(width+20), CGRectGetMaxY(verifyLabel.frame)+30, width, 50)];
        label.font=[UIFont systemFontOfSize:50];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor blackColor];
        [self.view addSubview:label];
        [self.verifyLabelArr addObject:label];
        UILabel *verifyLine=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(label.frame), CGRectGetMaxY(label.frame), CGRectGetWidth(label.frame), 1)];
        [verifyLine setBackgroundColor:GRAYColor2];
        [self.view addSubview:verifyLine];
    }
    //jkBtn
    JKCountDownButton *jkBtn=[[JKCountDownButton alloc]initWithFrame:CGRectMake(ScreenWidth-CGRectGetMinX(line1.frame)-80, CGRectGetMaxY(phoneNumLabel.frame), 80, 33)];
    [self.view addSubview:jkBtn];
    [jkBtn setTitle:@"验证码" forState:UIControlStateNormal];
    jkBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [jkBtn setTitleColor:BLUEColor forState:UIControlStateNormal];
    jkBtn.layer.cornerRadius=5;
    jkBtn.layer.masksToBounds=YES;
    jkBtn.layer.borderWidth=1;
    jkBtn.layer.borderColor=[CJColor(144, 200, 250)CGColor];
    [jkBtn addToucheHandler:^(JKCountDownButton *countDownButton, NSInteger tag) {
        NSString *tel=[[NSMutableString alloc]initWithString:phoneText.text];
        tel=[tel stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSLog(@"%@",tel);
        if ([self checkTel:tel]) {
            jkBtn.enabled=NO;
            [jkBtn startWithSecond:60];
            NSString *str=[phoneText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSDictionary *phone=@{
                                  @"phone":str
                                  };
            [[CCFetchTool sharedClient]POST:@"7005/api/v1/valid/code" parameters:phone Success:^(id responseObject) {
                BOOL success=[[responseObject objectForKey:@"success"]boolValue];
                if (success==YES) {
                    DSToast *toast=[[DSToast alloc]initWithText:@"验证码已发送"];
                    [toast showInView:self.view showType:DSToastShowTypeCenter];
                }
                else
                {
                    NSString *msg=[responseObject objectForKey:@"msg"];
                    DSToast *toast=[[DSToast alloc]initWithText:msg];
                    [toast showInView:self.view showType:DSToastShowTypeCenter];
                }
            } Failure:^(id error) {
                DSToast *toast=[[DSToast alloc]initWithText:@"网络错误"];
                [toast showInView:self.view showType:DSToastShowTypeCenter];
               
                NSLog(@"%@",phone);
            }];
            [jkBtn didChange:^NSString *(JKCountDownButton *countDownButton, int second) {
                jkBtn.layer.borderColor=[[UIColor grayColor]CGColor];
                [jkBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
                return [NSString stringWithFormat:@"%ds后重发",second];
                
                
            }];
            [jkBtn didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                jkBtn.enabled=YES;
                jkBtn.layer.borderWidth=1;
                jkBtn.layer.borderColor=[CJColor(144, 200, 250)CGColor];
                [jkBtn setTitleColor:CJColor(144, 200, 250) forState:UIControlStateNormal];
                return @"发送验证码";
            }];
        }
        else
        {
            DSToast *ts=[[DSToast alloc]initWithText:@"请输入正确的手机号"];
            [ts showInView:self.view];
            
        }
        
        
    }];

    //下一步按钮
     nextBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(line1.frame), CGRectGetMaxY(verifyLine.frame)+30, ScreenWidth-2*CGRectGetMinX(line1.frame), 50)];
    [nextBtn setBackgroundColor:GRAYColor2];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.view addSubview:nextBtn];
    nextBtn.layer.cornerRadius=4;
    nextBtn.layer.masksToBounds=YES;
//    nextBtn.enabled=NO;
    [nextBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    
}
//
-(void)textFieldDidChange:(UITextField *)textField
{
//    [self btnChangeColor];
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
    else if(textField==verify)
    {
        NSInteger verifyLength=verify.text.length;
        if (verifyLength>=4) {
            verify.text=[verify.text substringToIndex:4];
            for (int i=0; i<4; i++) {
                UILabel *numLabel=self.verifyLabelArr[i];
                numLabel.text=[verify.text substringWithRange:NSMakeRange(i, 1)];
            }
        }
        else if (verifyLength<4) {
            UILabel *numlabel=self.verifyLabelArr[verifyLength];
            numlabel.text=@"";
            for (int i=0; i<verifyLength; i++) {
                UILabel *numLabel=self.verifyLabelArr[i];
                numLabel.text=[verify.text substringWithRange:NSMakeRange(i, 1)];
            }
            
        }
    }

}
//正则表达式
- (BOOL)checkTel:(NSString *)tel
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,183,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:tel] == YES)
        || ([regextestcm evaluateWithObject:tel] == YES)
        || ([regextestct evaluateWithObject:tel] == YES)
        || ([regextestcu evaluateWithObject:tel] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
//-(void)btnChangeColor
//{
//    if ((phoneText.text.length>=13)&&(verify.text.length>=4)) {
//        [nextBtn setBackgroundColor:BLUEColor];
//        nextBtn.enabled=YES;
//    }
//    else
//    {
//        [nextBtn setBackgroundColor:GRAYColor2];
//    }
//}
//push
-(void)push
{
    SetViewController *svc=[[SetViewController alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
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
