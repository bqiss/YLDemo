//
//  Common.h
//  ElectronicTradingApp
//
//  Created by m on 15/7/27.
//  Copyright (c) 2015年 leimingtech. All rights reserved.
//

/**
 内网测试接口地址
 */


//#define HOST_URL @"http://172.31.1.146:8107/"//裕炜
//#define HOST_URL @"http://172.31.1.117:8107/"//新燔
//#define HOST_URL @"http://172.31.0.99:8217/"//王翔

//#define DaBanHOST_URL @"http://www.lssc-cloud.com/bc/"//大板信息页面
//#define WebHOST_URL @"http://webapp.mcloud.test.lsboot.cn/"//h5页面
//#define WebHOST_URL @"http://172.31.0.99:8217/"//王翔H5页面

//#define ShopHOST_URL @"http://172.31.100.100/"//商城接口地址
//
//#define HOST_URL @"http://api.mcloud.test.lsboot.cn/"//测试

/**
 上架用的服务器地址
 */
#define WebHOST_URL @"https://webapp.fab-cloud.com/"   //h5页面
#define HOST_URL @"http://120.78.172.212:7003/api/" //接口api地址
#define DaBanHOST_URL @"https://lsscapi.lssc-cloud.com/bc/"//大板信息页面
#define ShopHOST_URL @"https://lsscapi.lssc-cloud.com/"//商城接口地址

/**
 图片地址
 */
#define HOST_PIC @"http://api.mcloud.test.lsboot.cn"

//IM-key
#define JMESSAGE_APPKEY @"6bf85ce9fc89d3387386ce32"//教师端
#define JMESSAGE_APPKEY1 @"def8f14e68c7d81aaf000446"//家长端

/**
 USERID
 */
#define TOKEN [[NSUserDefaults standardUserDefaults] objectForKey:@"authorization"]

/**
 宽高
 
 设备            逻辑分辨率(point)    物理分辨率(pixel)     屏幕尺寸    缩放因子    PPI
 iPhone 7       375 × 667            750  × 1334         4.7寸      @2x      326
 iPhone 7P      414 × 736            1080 × 1920         5.5寸      @3x      401
 iPhone 8       375 × 667            750  × 1334         4.7寸      @2x      326
 iPhone 8P      414 × 736            1080 × 1920         5.5寸      @3x      401
 iPhone X       375 × 812            1125 × 2436         5.8寸      @3x      458
 iPhone XR      414 × 896            828  * 1792         6.1寸
 iPhone Xs      375 × 812            1125 * 2436         5.8寸
 iPhone XsMax   414 × 896            1242 * 2688         6.5寸
 
 */

#define CIsIPad \
([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)]\
&& [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_SCALE ([UIScreen mainScreen].bounds.size.width/375.0)
#define AUTO_WH(width)(float) (width)/375*SCREEN_WIDTH
#define StatusBarHeight (SCREEN_HEIGHT == 812.0 ? 44 : SCREEN_HEIGHT == 896.0 ? 44:20)
#define NaviBarHeight (SCREEN_HEIGHT == 812.0 ? 88 : SCREEN_HEIGHT == 896.0 ? 88:64)
#define TabBarHeight (SCREEN_HEIGHT == 812.0 ? 83 : SCREEN_HEIGHT == 896.0 ? 83: 49)
#define TabBarSafeAreaHeight (SCREEN_HEIGHT == 812.0 ? 34 : SCREEN_HEIGHT == 896.0 ? 34: 15)
#define SafeAreaBottomHeightNoDistance (SCREEN_HEIGHT == 812.0 ? 34 : SCREEN_HEIGHT == 896.0 ? 34: 0)//底部高度

//
#define TopBarHeight            (iOS7AndAbove ? 64:44)

#define TopAndSystemHeight      (ScreenHeight == 812.0 ? 88 : ScreenHeight == 896.0 ?88:64)

#define StateBarHeight          [[UIApplication sharedApplication] statusBarFrame].size.height//电源条

// 判断是否为iPhone 6/6s
#define iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f
// 判断是否为iPhone 6Plus/6sPlus
#define iPhone6Plus_6sPlus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f
//判断是否为iphoneX
#define iPhoneX [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 812.0f


/**
 颜色设置
 */
#define RGB_COLOR(r,g,b,ph) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(ph)]
#define HEXCOLOR(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HEXACOLOR(rgbValue,a)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
//主色调
#define MainColor                   HEXCOLOR(0x1B4AE8)
#define SecondColor                 HEXCOLOR(0x0C8AFF)
#define ThirdColor                  HEXCOLOR(0x52ACFF)
#define BGColor                     HEXCOLOR(0xF8F8F8)
//字体色
#define MainTextColor               HEXCOLOR(0x333333)
#define SecoTextColor               HEXCOLOR(0x666666)
#define ThirTextColor               HEXCOLOR(0x999999)
//其他色
#define ClearColor                  [UIColor clearColor]
#define WhiteColor                  HEXCOLOR(0xFFFFFF)
#define LineColor                   HEXCOLOR(0xeeeeee)

/**
 字号
 */
#define FONT10SIZE       [UIFont systemFontOfSize:10]
#define FONT11SIZE       [UIFont systemFontOfSize:11]
#define FONT12SIZE       [UIFont systemFontOfSize:12]
#define FONT13SIZE       [UIFont systemFontOfSize:13]
#define FONT14SIZE       [UIFont systemFontOfSize:14]
#define FONT15SIZE       [UIFont systemFontOfSize:15]
#define FONT16SIZE       [UIFont systemFontOfSize:16]
#define FONT17SIZE       [UIFont systemFontOfSize:17]
#define FONT18SIZE       [UIFont systemFontOfSize:18]
#define FONT20SIZE       [UIFont systemFontOfSize:20]
#define FONT16SIZEBOLD   [UIFont boldSystemFontOfSize:16]
#define FONT17SIZEBOLD   [UIFont boldSystemFontOfSize:17]
#define FONT18SIZEBOLD   [UIFont boldSystemFontOfSize:18]

/**
 其他
 */
#define ImageNamed(name) [UIImage imageNamed:name]
#define NsstringWithFormat(a,b) [NSString stringWithFormat:@"%@%@",a,b]

#define PayBackNotification @"PayBackNotification"
#define HomeProjectPush @"HomeProjectPush"
#define ProjectH5Push @"ProjectH5Push"

#define WHKY(height)(float)  (height)/1334*ScreenHeight
#define WHKX(width)(float)  (width)/750*ScreenWidth

