//
//  TopBarView.h
//  基类
//
//  Created by 陈剑英 on 2017/11/12.
//  Copyright © 2017年 陈剑英. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackBtnDelegate<NSObject>

@optional
-(void)backActionOfDelegate;

@end







@interface TopBarView : UIView<BackBtnDelegate>
{
    UIButton *_backBtn;
    UILabel *_titleLabel;
}
@property(nonatomic,strong)id<BackBtnDelegate>delegate;

-(void)setTopTitle:(NSString *)title;
-(void)setTopTitleColor:(UIColor *)color;
-(void)setTopBgColor:(UIColor *)backgroundColor;
-(void)setBackBtnHide:(BOOL)hide;
-(void)setBackBtnImage:(UIImage *)image;
-(void)setBackBtnTitle:(NSString *)title;








@end
