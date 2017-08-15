//
//  SH_AFNetClient.h
//  SmartHomeProject
//
//  Created by 李选雁 on 2017/8/12.
//
//  网络请求工具类

#import <Foundation/Foundation.h>

/**
 连接服务器成功回调block
 */
typedef void(^SuccessBlock)(NSData *stringData,id JsonDict);

/**
 连接服务器失败回调block
 */
typedef void(^FailBlock)(NSError *error);

/**
 没有网络连接回调block
 */
typedef void(^NoNetBlock)(NSString *alertMessage);

/**
 token失效回调block
 */
typedef void(^TokenFailBlock)(NSString *tokenFail);

@interface SH_AFNetClientTool : NSObject

+ (SH_AFNetClientTool *)shareNetClientTool;


/**
 get请求

 @param urlPath 请求路径
 @param pramaDic 请求参数
 @method method  POST 或者 GET请求
 @param isNeedToken 是否是带token的请求
 @param currentController 当前的控制器，如果当前不是控制器的则传nil
 @param successBlock 成功回调
 @param failBlock 失败回调
 @param noNetBlock 没有网络回调
 @param tokenFailBlock token失效回调
 */
- (void)resquestWithUrl:(NSString *)urlPath pramas:(NSDictionary *)pramaDic method:(NSString *)method isNeedToken:(BOOL)isNeedToken currentController:(UIViewController *)currentController success:(SuccessBlock)successBlock fail:(FailBlock)failBlock noNet:(NoNetBlock)noNetBlock tokenFail:(TokenFailBlock)tokenFailBlock;

@end
