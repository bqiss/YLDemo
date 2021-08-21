//
//  AppData.m
//  projectBase
//
//  Created by chenjianying on 15-11-16.
//  Copyright (c) 2015年 chenjianying. All rights reserved.
//

#import "AppData.h"



@implementation AppData

static AppData* mInstance;

+ (AppData*)shareInstance
{
    if (nil == mInstance)
    {
        mInstance = [[AppData alloc] init];
    }
    
    return mInstance;
}

-(id)init
{
    self = [super init];
    if(self != nil)
    {
        self.userInfo=[[UserInfo alloc]init];
        
    }
    
    return self;
}
@end
