//
//  RegisterViewModel.h
//  SmartHomeProject
//
//  Created by 李选雁 on 2017/8/17.
//
//

#import <Foundation/Foundation.h>

@class UserRegisterModel;

typedef void(^CompletionHandler)(NSDictionary *jsonDict);

@interface UserRegisterViewModel : NSObject

/**
 注册成功之后的返回数据
 */
- (void)userRegister:(UserRegisterModel *)registerModel CompletionHandler:(CompletionHandler)completionHandler;

@end
