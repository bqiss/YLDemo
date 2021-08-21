//
//  ViewController.m
//  demo6.7
//
//  Created by abc on 20/6/7.
//  Copyright © 2020年 1132482428@qq.com. All rights reserved.
//


#ifndef projectBase_SizeHeader_h
#define projectBase_SizeHeader_h

#define ScreenWidth             [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight            [[UIScreen mainScreen] bounds].size.height

#define iOS7AndAbove    ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)

#define TopBarHeight            (iOS7AndAbove ? 64:44)

#define TopAndSystemHeight      (ScreenHeight == 812.0 ? 88 : ScreenHeight == 896.0 ?88:64)

#define StateBarHeight          [[UIApplication sharedApplication] statusBarFrame].size.height//电源条

#define SafeAreaBottomHeight (SCREEN_HEIGHT == 812.0 ? 34 : SCREEN_HEIGHT == 896.0 ? 34: 0)//底部高度





#define CJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define UIColorRGB(value) [UIColor colorWithRed:value/255.0 green:value/255.0 blue:value/255.0 alpha:1.0]

#define CJY(height)(float)  (height)/1334*ScreenHeight
#define CJX(width)(float)  (width)/750*ScreenWidth

#define CJColorWithHex(hexColor) [UIColor colorWithRed:((float)((hexColor & 0xFF0000) >> 16))/255.0 green:((float)((hexColor & 0xFF00) >> 8))/255.0 blue:((float)(hexColor & 0xFF))/255.0 alpha:1.0]

#define CJX(width)(float) (width)/750*ScreenWidth
#define CJY(heigth)(float) (heigth)/1334*ScreenWidth
#define  GRAYColor     CJColor(242, 244, 245)
#define  GRAYColor2     CJColor(215, 221, 224)
#define  BLUEColor  CJColor(0, 146, 248)


#endif

