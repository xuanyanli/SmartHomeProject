//
//  UserRegisterModel.h
//  SmartHomeProject
//
//  Created by 李选雁 on 2017/8/17.
//
//

#import <Foundation/Foundation.h>

@interface UserRegisterModel : NSObject

/**
 性别
 */
@property (nonatomic,assign)int sex;

/**
 姓名
 */
@property (nonatomic,copy) NSString *name;

/**
 生日
 */
@property (nonatomic,copy) NSString *brithday;

/**
 电话
 */
@property (nonatomic,copy) NSString *tel;

/**
 邮件
 */
@property (nonatomic,copy) NSString *email;

/**
 用户名
 */
@property (nonatomic,copy) NSString *loginName;

/**
 密码
 */
@property (nonatomic,copy) NSString *password;

@end
