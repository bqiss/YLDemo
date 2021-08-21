//
//  BaseViewController.h
//  基类
//
//  Created by 陈剑英 on 2017/11/12.
//  Copyright © 2017年 陈剑英. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBarView.h"

//照相机
#import "TZPhotoPickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"
#import "TZPhotoPreviewController.h"
#import "TZGifPhotoPreviewController.h"
#import "TZLocationManager.h"
#import "TZImagePickerController.h"
#import "UIView+Layout.h"


@interface BaseViewController : UIViewController<TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UIActionSheetDelegate >
{
@protected
    TopBarView *topBar;
}

@property(nonatomic,strong)NSMutableArray *selectedPhotos;
@property(nonatomic,strong)NSMutableArray *selectedAssets;

@property (strong, nonatomic) CLLocation *location;

-(void)initUI;

-(void)setTopTitle:(NSString *)title;
-(void)setTopTitleColor:(UIColor *)color;
-(void)setTopBgColor:(UIColor *)backgroundColor;
-(void)setBackBtnHide:(BOOL)hide;
-(void)setBackBtnImage:(UIImage *)image;
-(void)setBackBtnTitle:(NSString *)title;
-(UIButton *)createBtn:(CGRect)frame title:(NSString *)title titleSize:(float)titleSize iconImage:(NSString *)iconImage backgroundImage:(NSString *)bgImage tag:(int)tag textColor:(UIColor *)textColor;
-(UILabel *)createLabel:(CGRect)frame title:(NSString *)title fontSize:(int)fontSize textColor:(UIColor *)textColor;
-(UITextField *)createTextfield:(CGRect)frame font:(float)font tag:(long int)tag backgroundColor:(UIColor *)backgroundColor placeholder:(NSString *)placeholder;
-(UILabel *)createLine:(CGRect)frame;


-(void)useInsideBtntakePhoto:(BOOL)BtnInside MaxImagesCount:(int)ImagesCount;//拍照
@end
