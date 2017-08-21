//
//  RegisterViewModel.m
//  SmartHomeProject
//
//  Created by 李选雁 on 2017/8/17.
//
//

#import "UserRegisterViewModel.h"

#import "UserRegisterModel.h"

@interface UserRegisterViewModel ()

/**
 完成回调
 */
@property (nonatomic,copy) CompletionHandler completionHandler;

/**
 用户注册信息
 */
@property (nonatomic,strong) UserRegisterModel *registerModel;

@end

@implementation UserRegisterViewModel

/**
 注册成功之后的返回数据
 */
- (void)userRegister:(UserRegisterModel *)registerModel CompletionHandler:(CompletionHandler)completionHandler
{
    self.completionHandler = [completionHandler copy];
    self.registerModel = registerModel;
    
    //调用注册接口
    [self requestUserRegister];
}

#pragma mark- 调用注册接口
- (void)requestUserRegister
{
    NSString *registerUrl = [NSString stringWithFormat:@"%@CustomerV1/Register",BaseUrl];
    
    NSMutableDictionary *pramaDic = [NSMutableDictionary dictionary];
    [pramaDic setObject:self.registerModel.name forKey:@"name"];
    [pramaDic setObject:self.registerModel.brithday forKey:@"brithday"];
    [pramaDic setObject:[NSNumber numberWithInt:self.registerModel.sex] forKey:@"sex"];
    [pramaDic setObject:self.registerModel.tel forKey:@"tel"];
    [pramaDic setObject:self.registerModel.email forKey:@"email"];
    [pramaDic setObject:self.registerModel.loginName forKey:@"loginName"];
    [pramaDic setObject:self.registerModel.password forKey:@"passsword"];
    
  [[SH_AFNetClientTool shareNetClientTool]resquestWithUrl:registerUrl pramas:pramaDic method:@"POST" isNeedToken:NO currentController:nil success:^(NSData *stringData, id JsonDict) {
      
      NSLog(@"jsonDic:%@",JsonDict);
      
  } fail:^(NSError *error) {
      
      NSLog(@"error:%@",error.localizedDescription);
  } noNet:^(NSString *alertMessage) {
      
      NSLog(@"alertMessage:%@",alertMessage);
  } tokenFail:^(NSString *tokenFail) {
      
  }];
}

@end
