//
//  ViewManager.h
//  单例
//
//  Created by 陈剑英 on 2017/10/28.
//  Copyright © 2017年 陈剑英. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>


/*
 单例：使得创建的对象不被销毁且唯一
 1.声明一个静态变量
 2.声明一个工厂方法 shareInstance
 3.重写init方法
 
 
 
 单例使用：1.传值
 
 
         2.设置根视图
     [self.window setRootViewController:[ViewManager shareInstance].NavigationController];
 
     出入栈：
 */

@interface ViewManager : NSObject
{
@private
    UINavigationController *_navigationController;
}
@property (nonatomic, readonly) UINavigationController *NavigationController;


+(ViewManager *)shareInstance;
//@property(nonatomic,strong)NSString *userID;//传值


@end
