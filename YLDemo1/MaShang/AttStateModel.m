//
//  AttStateModel.m
//  MaShang
//
//  Created by abc on 20/8/3.
//  Copyright © 2020年 WHK. All rights reserved.
//

#import "AttStateModel.h"

@implementation AttStateModel
-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    if (self!=nil) {
        self.btnText=[dict objectForKey:@"btnText"];
        self.isActivate=[[dict objectForKey:@"isActivate"]boolValue];
        self.state=[dict objectForKey:@"state"];
        self.stateList=[dict objectForKey:@"stateList"];
    }
    return self;
}
@end
