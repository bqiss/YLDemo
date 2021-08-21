//
//  AppData.h
//  projectBase
//
//  Created by chenjianying on 15-11-16.
//  Copyright (c) 2015年 chenjianying. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "UnitCell.h"
#import "UserInfo.h"
#define KeyPlistName  @"keyPlist"

@interface AppData : NSObject
@property(nonatomic,strong)UserInfo *userInfo;


+ (AppData*)shareInstance;



@end

