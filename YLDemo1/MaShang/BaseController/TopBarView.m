//
//  TopBarView.m
//  基类
//
//  Created by 陈剑英 on 2017/11/12.
//  Copyright © 2017年 陈剑英. All rights reserved.
//

#import "TopBarView.h"
#import "SizeHeader.h"
@implementation TopBarView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        //_backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, TopAndSystemHeight-37, 50, 34)];
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, StatusBarHeight, 50, 44)];   //居中
        [_backBtn setTitle:@"" forState:UIControlStateNormal];
        [_backBtn setImage:[UIImage imageNamed:@"btn_return_gray"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backBtn];
        
        
        //_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50,TopAndSystemHeight-30, ScreenWidth-100, 20)];
        //_titleLabel.text = @"登录";
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50,StatusBarHeight, SCREEN_WIDTH-100, 44)];
        _titleLabel.textColor = MainTextColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
//        _titleLabel.font = MainFont(18.0);
        _titleLabel.font = [UIFont systemFontOfSize:18 weight:0.2];
        [self addSubview:_titleLabel];
    }
    
    return self;
}

-(void)setTopTitle:(NSString *)title
{
    _titleLabel.text = title;
}

-(void)setTopTitleColor:(UIColor *)color
{
    _titleLabel.textColor = color;
}

-(void)setTopBgColor:(UIColor *)backgroundColor
{
    self.backgroundColor = backgroundColor;
}

-(void)setBackBtnHide:(BOOL)hide
{
    _backBtn.hidden = hide;
}

-(void)setBackBtnImage:(UIImage *)image;
{
    [_backBtn setImage:image forState:UIControlStateNormal];
}

-(void)setBackBtnTitle:(NSString *)title
{
    [_backBtn setTitle:title forState:UIControlStateNormal];
}


-(void)btnAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(backActionOfDelegate)])
    {
        [_delegate backActionOfDelegate];
    }
}












@end
