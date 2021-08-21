//
//  UnitCell.h
//  AF-networking集成
//
//  Created by 陈剑英 on 2017/12/8.
//  Copyright © 2017年 陈冬芹. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface UnitCell : NSObject



@end

//MVC
@interface ClassNameModel : JSONModel

@property(nonatomic,strong)NSString <Optional>*classId;
@property(nonatomic,strong)NSString <Optional>*className;

@end

















@interface DIANZHUANGTYPEMODEL:JSONModel

@property(nonatomic,strong)NSString <Optional>*id;
@property(nonatomic,strong)NSString <Optional>*name;
@property(nonatomic,strong)NSString <Optional>*note;

@end

//建立user模型
@interface USERMODEL:JSONModel
@property(nonatomic,strong)NSString <Optional>*account;
@property(nonatomic,strong)NSString <Optional>*address;
@property(nonatomic,strong)NSString <Optional>*birthday;
@property(nonatomic,strong)NSString <Optional>*classs_id;
@property(nonatomic,strong)NSString <Optional>*create_date;
@property(nonatomic,strong)NSString <Optional>*email;
@property(nonatomic,strong)NSString <Optional>*head;
@property(nonatomic,strong)NSString <Optional>*id;
@property(nonatomic,strong)NSString <Optional>*modify_date;
@property(nonatomic,strong)NSString <Optional>*name;
@property(nonatomic,strong)NSString <Optional>*nexus;
@property(nonatomic,strong)NSString <Optional>*password;
@property(nonatomic,strong)NSString <Optional>*phone;
@property(nonatomic,strong)NSString <Optional>*qq;
@property(nonatomic,strong)NSString <Optional>*remarks;
@property(nonatomic,strong)NSString <Optional>*sex;
@property(nonatomic,strong)NSString <Optional>*status;
@property(nonatomic,strong)NSString <Optional>*student_id;
@property(nonatomic,strong)NSString <Optional>*wechat;


@end

@interface CLASSSMODEL:JSONModel
@property(nonatomic,strong)NSString <Optional>*alias;
@property(nonatomic,strong)NSString <Optional>*attestation;
@property(nonatomic,strong)NSString <Optional>*blurb;
@property(nonatomic,strong)NSString <Optional>*class_type;
@property(nonatomic,strong)NSString <Optional>*code;
@property(nonatomic,strong)NSString <Optional>*create_date;
@property(nonatomic,strong)NSString <Optional>*grade;
@property(nonatomic,strong)NSString <Optional>*grade_name;
@property(nonatomic,strong)NSString <Optional>*head;
@property(nonatomic,strong)NSString <Optional>*id;
@property(nonatomic,strong)NSString <Optional>*invite_code;
@property(nonatomic,strong)NSString <Optional>*modify_date;
@property(nonatomic,strong)NSString <Optional>*name;
@property(nonatomic,strong)NSString <Optional>*school_id;
@property(nonatomic,strong)NSString <Optional>*status;
@property(nonatomic,strong)NSString <Optional>*year;
@end


@interface HANGYEMODEL:JSONModel

@property(nonatomic,strong)NSString <Optional>*hid;
@property(nonatomic,strong)NSString <Optional>*name;
@property(nonatomic,strong)NSString <Optional>*type;

@end

@interface WEIDUMODEL:JSONModel

@property(nonatomic,strong)NSString <Optional>*has_child;
@property(nonatomic,strong)NSString <Optional>*head_url;
@property(nonatomic,strong)NSString <Optional>*remark;
@property(nonatomic,strong)NSString <Optional>*wdCreate;
@property(nonatomic,strong)NSString <Optional>*wdID;
@property(nonatomic,strong)NSString <Optional>*wdName;

@end

@interface COMPANYMODEL:JSONModel

@property(nonatomic,strong)NSString <Optional>*cName;

@end




@interface HYModel:JSONModel

@property(nonatomic,strong)NSString <Optional> *hid;
@property(nonatomic,strong)NSString <Optional> *name;
@property(nonatomic,strong)NSString <Optional> *type;

@end


@interface WDModel:JSONModel

@property(nonatomic,strong)NSString <Optional> *has_child;
@property(nonatomic,strong)NSString <Optional> *head_url;
@property(nonatomic,strong)NSString <Optional> *remark;
@property(nonatomic,strong)NSString <Optional> *wdCreate;
@property(nonatomic,strong)NSString <Optional> *wdID;
@property(nonatomic,strong)NSString <Optional> *wdName;

@end

@interface QiYeModele:JSONModel

@property(nonatomic,strong)NSString <Optional> *cName;

@end










@interface SuccessModel:JSONModel


@property(nonatomic,strong)NSString <Optional>*code;
@property(nonatomic,strong)NSDictionary <Optional>*data;

@end

@interface ProvinceModel:JSONModel

@property(nonatomic,strong)NSString <Optional>*code;
@property(nonatomic,strong)NSString <Optional>*name;
@property(nonatomic,strong)NSString <Optional>*parent_code;

@end


//维度标签
@interface WeiDuModel:JSONModel

@property(nonatomic,strong)NSString <Optional>*has_child;
@property(nonatomic,strong)NSString <Optional>*head_url;
@property(nonatomic,strong)NSString <Optional>*remark;
@property(nonatomic,strong)NSString <Optional>*wdCreate;
@property(nonatomic,strong)NSString <Optional>*wdID;
@property(nonatomic,strong)NSString <Optional>*wdName;

@end

//行业标签
@interface HangYeModel:JSONModel

@property(nonatomic,strong)NSString <Optional>*hid;
@property(nonatomic,strong)NSString <Optional>*name;
@property(nonatomic,strong)NSString <Optional>*type;

@end

//公司标签
@interface CompanyModel:JSONModel

@property(nonatomic,strong)NSString <Optional>*cName;


@end


//广告栏信息获取
@interface BANNERMODEL:JSONModel

@property(nonatomic,strong)NSString <Optional>*type;
@property(nonatomic,strong)NSString <Optional>*link_id;
@property(nonatomic,strong)NSString <Optional>*ad_name;
@property(nonatomic,strong)NSString <Optional>*ad_link;


@end







//提供广告栏信息获取接口
@interface GUANGGAOLANMODEL:JSONModel

@property(nonatomic,strong)NSString <Optional>*ad_link;
@property(nonatomic,strong)NSString <Optional>*ad_name;
@property(nonatomic,strong)NSString <Optional>*link_id;
@property(nonatomic,strong)NSString <Optional>*type;

@end


//提供广告栏信息获取接口
@interface GUANGGAOMODEL:JSONModel

@property(nonatomic,strong)NSString <Optional>*ad_link;

@property(nonatomic,strong)NSString <Optional>*ad_code;

@end






