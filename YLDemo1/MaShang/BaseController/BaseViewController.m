//
//  BaseViewController.m
//  基类
//
//  Created by 陈剑英 on 2017/11/12.
//  Copyright © 2017年 陈剑英. All rights reserved.
//

#import "BaseViewController.h"
#import "ViewManager.h"
#import "SizeHeader.h"

#define NOCONTENTVIEWTAG   10314100


@interface BaseViewController ()<BackBtnDelegate>
{
    int MaxImagesCount;
    BOOL takePhontBtnInside;
}


@property (nonatomic, strong) UIImagePickerController *imagePickerVc;



@end

@implementation BaseViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"内存警告了哈  UIApplicationDidReceiveMemoryWarningNotification ");

//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"你的手机空间不足，请立即清理"] preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"暂不" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"立即清理" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
    [self clearCache];
        
        
//    }];
//    [alert addAction:cancle];
//    [alert addAction:ok];
//    [self presentViewController:alert animated:YES completion:nil];
    
    
}

- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}
//1. 清除缓存第一种
-(void)clearCache
{
    //彻底清除缓存第一种方法
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths lastObject];
    
    NSString *str = [NSString stringWithFormat:@"缓存已清除%.1fM", [self folderSizeAtPath:path]];
    NSLog(@"%@",str);
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:path];
    for (NSString *p in files) {
        NSError *error;
        NSString *Path = [path stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:Path]) {
            [[NSFileManager defaultManager] removeItemAtPath:Path error:&error];
        }
    }
   
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    [self clearCache];
//    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initUI];

}



-(void)initUI
{
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    
    
    topBar = [[TopBarView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, TopAndSystemHeight)];
    topBar.delegate = self;
    topBar.backgroundColor = WhiteColor;
    [self.view addSubview:topBar];
}

-(void)setTopTitle:(NSString *)title
{
    [topBar setTopTitle:title];
}

-(void)setTopTitleColor:(UIColor *)color
{
    [topBar setTopTitleColor:color];
}

-(void)setTopBgColor:(UIColor *)backgroundColor
{
    [topBar setTopBgColor:backgroundColor];
}

-(void)setBackBtnHide:(BOOL)hide
{
    [topBar setBackBtnHide:hide];
}

-(void)setBackBtnImage:(UIImage *)image;
{
    [topBar setBackBtnImage:image];
}

-(void)setBackBtnTitle:(NSString *)title
{
    [topBar setBackBtnTitle:title];
}


//实现返回delegate的方法
-(void)backActionOfDelegate
{
    //如果是模态跳转
    if (self.presentingViewController)
    {
        [[ViewManager shareInstance].NavigationController dismissViewControllerAnimated:YES
                                                                             completion:nil];
    }
    else
    {
        [[ViewManager shareInstance].NavigationController popViewControllerAnimated:YES];
    }
        
}

//创建btn
-(UIButton *)createBtn:(CGRect)frame title:(NSString *)title titleSize:(float)titleSize iconImage:(NSString *)iconImage backgroundImage:(NSString *)bgImage tag:(int)tag textColor:(UIColor *)textColor
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.tag = tag;
    btn.titleLabel.font = [UIFont systemFontOfSize:titleSize];
    if(textColor != nil)
        [btn setTitleColor:textColor forState:UIControlStateNormal];
    if(bgImage != nil)
        [btn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    if(iconImage != nil)
        [btn setImage:[UIImage imageNamed:iconImage] forState:UIControlStateNormal];
    if(title != nil)
        [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

//创建label
-(UILabel *)createLabel:(CGRect)frame title:(NSString *)title fontSize:(int)fontSize textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.text = title;
    if(textColor != nil)
        label.textColor = textColor;
//    label.font = MainFont(fontSize);
//    label.font = [UIFont fontWithName:@"Reeji-CloudYuanZhun-GB-Normal" size:fontSize];
    label.font = [UIFont systemFontOfSize:fontSize];
    return label;
}

//创建textfield
-(UITextField *)createTextfield:(CGRect)frame font:(float)font tag:(long int)tag backgroundColor:(UIColor *)backgroundColor placeholder:(NSString *)placeholder
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.font = [UIFont systemFontOfSize:font];
    textField.tag = tag;
    textField.backgroundColor = backgroundColor;
    textField.placeholder= placeholder;
    
    return textField;
}

//创建线条
-(UILabel *)createLine:(CGRect)frame
{
    UILabel *line = [self createLabel:frame title:nil fontSize:20 textColor:nil];
    line.backgroundColor = BGColor;
    return line;
}
-(void)btnAction:(id)sender
{
    
}

//照片

//懒加载
- (UIImagePickerController *)imagePickerVc
{
    if (_imagePickerVc == nil)
    {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        if (iOS7Later)
        {
            _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        }
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later)
        {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        }
        else
        {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        
    }
    return _imagePickerVc;
}

-(void)useInsideBtntakePhoto:(BOOL)BtnInside MaxImagesCount:(int)ImagesCount
{
    takePhontBtnInside = BtnInside;
    MaxImagesCount = ImagesCount;
    if (takePhontBtnInside == NO)
    {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
        [sheet showInView:self.view];
    }
    else if(takePhontBtnInside == YES)
    {
        [self pushTZImagePickerController];
    }
    
}


#pragma mark ------ ipad拍照‘
/** 调用相册 */
- (void)openPhotoAlbum
{
    [self openPhotoAlbumOrCamera:UIImagePickerControllerSourceTypePhotoLibrary];
}

/** 调用摄像头 */
- (void)openCamera
{
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamera)
    {
//        HUDNormal(@"当前设备没有摄像头");
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
        return;
    }
    [self openPhotoAlbumOrCamera:UIImagePickerControllerSourceTypeCamera];
}

- (void)openPhotoAlbumOrCamera:(UIImagePickerControllerSourceType)type
{
    self.imagePickerVc.sourceType = type;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        __weak typeof(self) ws = self;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [ws presentViewController:self.imagePickerVc animated:YES completion:nil];
        }];
    } else {
        [self presentViewController:self.imagePickerVc animated:YES completion:nil];
    }
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        // take photo / 去拍照
        if (CIsIPad)
        {
            [self openCamera];
        }
        else
            [self takePicture];
    }
    else if (buttonIndex == 1)
    {
        if (CIsIPad)
        {
            [self openPhotoAlbum];
        }
        else
            [self pushTZImagePickerController];//不允许内部拍照
    }
}

- (void)takePicture
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later)
    {
        // 无相机权限 做一个友好的提示
        if (iOS8Later)
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
            [alert show];
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }
    else if (authStatus == AVAuthorizationStatusNotDetermined)
    {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        if (iOS7Later)
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted)
            {
                if (granted)
                {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self takePicture];
                    });
                }
            }];
        }
        else
        {
            [self takePicture];
        }
        // 拍照之前还需要检查相册权限
    }
    else if ([TZImageManager authorizationStatus] == 2)
    { // 已被拒绝，没有相册权限，将无法保存拍的照片
        if (iOS8Later) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
            [alert show];
        } else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    } else if ([TZImageManager authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePicture];
        }];
    }
    else
    {
        [self pushImagePickerController];
    }
}

// 调用相机
-(void)pushImagePickerController
{
    // 提前定位
    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(CLLocation *location, CLLocation *oldLocation) {
        weakSelf.location = location;
    } failureBlock:^(NSError *error) {
        weakSelf.location = nil;
    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        if(iOS8Later) {
            _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

//选择照片
- (void)pushTZImagePickerController
{
    //    if (self.maxCountTF.text.integerValue <= 0) {
    //        return;
    //    }
    ///< 照片最大可选张数，设置为1即为单选模式   maxCountTF
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:MaxImagesCount columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.navigationBar.translucent = NO;
//    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    //是否设置原图
    imagePickerVc.isSelectOriginalPhoto = YES;
    
//        if (self.maxCountTF.text.integerValue > 1) {
    // 1.设置目前已经选中的图片数组
//            imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
//        }
    // 在内部显示拍照按钮
    imagePickerVc.allowTakePicture = takePhontBtnInside;
    
    // imagePickerVc.photoWidth = 1000;
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    // if (iOS7Later) {
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // }
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    // imagePickerVc.navigationBar.translucent = NO;
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = YES;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingGif = YES;
    imagePickerVc.allowPickingMultipleVideo = YES;// 是否可以多选视频
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
    
    /// 5. Single selection mode, valid when maxImagesCount = 1
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;//不允许选中且图片数量为1 才能使裁剪生效
    imagePickerVc.allowCrop = NO;
    imagePickerVc.needCircleCrop = NO;
    // 设置竖屏下的裁剪尺寸
    NSInteger left = 30;
    NSInteger widthHeight = self.view.tz_width - 2 * left;
    NSInteger top = (self.view.tz_height - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    // 设置横屏下的裁剪尺寸
    // imagePickerVc.cropRectLandscape = CGRectMake((self.view.tz_height - widthHeight) / 2, left, widthHeight, widthHeight);
    /*
     [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
     cropView.layer.borderColor = [UIColor redColor].CGColor;
     cropView.layer.borderWidth = 2.0;
     }];*/
    
    //imagePickerVc.allowPreview = NO;
    // 自定义导航栏上的返回按钮
    /*
     [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton){
     [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
     [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 20)];
     }];
     imagePickerVc.delegate = self;
     */
    
    imagePickerVc.isStatusBarDefault = NO;
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        NSLog(@"%@     ----%@",photos,assets);
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}


// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];

    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
    
    // 1.打印图片名字
    NSLog(@"%@",assets);
    // 2.图片位置信息
    if (iOS8Later) {
        for (PHAsset *phAsset in assets) {
            NSLog(@"location:%@",phAsset.location);
        }
    }
    
    
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"])
    {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        tzImagePickerVc.sortAscendingByModificationDate = NO;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                
                //得到的image就是想要的image了
                
            }
        }];
        
        
    }
    
}














@end
