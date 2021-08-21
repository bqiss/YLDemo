//
//  AttStateModel.h
//  MaShang
//
//  Created by abc on 20/8/3.
//  Copyright © 2020年 WHK. All rights reserved.
//

#import "JSONModel.h"

@interface AttStateModel : JSONModel
@property(nonatomic,strong)NSString *btnText;
@property(nonatomic,assign)BOOL isActivate;
@property(nonatomic,strong)NSString *state;
@property(nonatomic,strong)NSArray *stateList;


@end
