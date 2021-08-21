//
//  UserInfo.h
//  MaShang
//
//  Created by abc on 20/7/29.
//  Copyright © 2020年 WHK. All rights reserved.
//

#import "JSONModel.h"

@interface UserInfo : JSONModel
@property(nonatomic,assign)NSString* id;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSArray *attGroup;
@end
