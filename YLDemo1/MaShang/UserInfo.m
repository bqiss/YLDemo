//
//  UserInfo.m
//  MaShang
//
//  Created by abc on 20/7/29.
//  Copyright © 2020年 WHK. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    if (self!=nil) {
        self.id=[dict objectForKey:@"id"];
        self.name=[dict objectForKey:@"name"];
        self.username=[dict objectForKey:@"username"];
        self.sex=[dict objectForKey:@"sex"];
        self.attGroup=[dict objectForKey:@"attGroup"];
    }
    return self;
}
@end
