//
//  SH_AFNetClient.m
//  SmartHomeProject
//
//  Created by 李选雁 on 2017/8/12.
//
//   网络请求工具类

#import "SH_AFNetClientTool.h"

#import "AFHTTPSessionManager.h"

@interface SH_AFNetClientTool ()

/**
 请求管理类
 */
@property (nonatomic,strong)AFHTTPSessionManager *httpManager;

@end

@implementation SH_AFNetClientTool

+ (SH_AFNetClientTool *)shareNetClientTool
{
    static SH_AFNetClientTool *netTool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netTool = [[SH_AFNetClientTool alloc]init];
    });
    
    return netTool;
}

-(AFHTTPSessionManager *)httpManager
{
    if (_httpManager == nil)
    {
        _httpManager = [AFHTTPSessionManager manager];
    }
    
    return _httpManager;
}

#pragma mark- 配置请求管理类
-(void)configHttpManager
{
    self.httpManager.responseSerializer  = [AFHTTPResponseSerializer serializer];
    self.httpManager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/plain",@"text/html",@"text/json",@"application/json",@"text/css",@"text/javascript",@"text/xml",nil];
    
    self.httpManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.httpManager.requestSerializer.timeoutInterval = 10.0f;
    
    //缓存模式设置为忽略本地
    self.httpManager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    
    //设置https请求
    [self.httpManager setSecurityPolicy:[self customSecurityPolicy]];
    
    //本地相关信息
    NSDictionary *infoDic = [[NSBundle mainBundle]infoDictionary];
    //发布版本号
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    NSString *
    
}

#pragma mark 配置https证书
- (AFSecurityPolicy *)customSecurityPolicy
{
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    NSString *cerPath = [[NSBundle mainBundle]pathForResource:@"" ofType:@"cer"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:cerPath])
    {
        NSData *cerData = [[NSData alloc]initWithContentsOfFile:cerPath];
        // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
        // 如果是需要验证自建证书，需要设置为YES
        securityPolicy.allowInvalidCertificates = YES;
        
        //validatesDomainName 是否需要验证域名，默认为YES；
        //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
        //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
        //如置为NO，建议自己添加对应域名的校验逻辑。
        securityPolicy.validatesDomainName = NO;
        [securityPolicy setPinnedCertificates:[NSSet setWithObject:cerData]];

    }
    
    return securityPolicy;
}

/**
 网络请求请求
 
 @param urlPath 请求路径
 @param pramaDic 请求参数
 @method method  post 或者 get请求
 @param isNeedToken 是否是带token的请求
 @param currentController 当前的控制器，如果当前不是控制器的则传nil
 @param successBlock 成功回调
 @param failBlock 失败回调
 @param noNetBlock 没有网络回调
 @param tokenFailBlock token失效回调
 */

#pragma mark-  网络请求请求

- (void)resquestWithUrl:(NSString *)urlPath pramas:(NSDictionary *)pramaDic method:(NSString *)method isNeedToken:(BOOL)isNeedToken currentController:(UIViewController *)currentController success:(SuccessBlock)successBlock fail:(FailBlock)failBlock noNet:(NoNetBlock)noNetBlock tokenFail:(TokenFailBlock)tokenFailBlock
{
    if ([[method uppercaseString] isEqualToString:@"GET"])
    {
        //GET 请求
    }else if ([[method uppercaseString] isEqualToString:@"POST"])
    {
        //POST 请求
    }else
    {
        NSLog(@"不支持的请求类型");
    }
}

#pragma mark-  Get网络请求请求
- (void)getWithUrl:(NSString *)urlPath pramas:(NSDictionary *)pramaDic method:(NSString *)method isNeedToken:(BOOL)isNeedToken currentController:(UIViewController *)currentController success:(SuccessBlock)successBlock fail:(FailBlock)failBlock noNet:(NoNetBlock)noNetBlock tokenFail:(TokenFailBlock)tokenFailBlock
{

}

#pragma mark- Post网络请求请求
- (void)postWithUrl:(NSString *)urlPath pramas:(NSDictionary *)pramaDic method:(NSString *)method isNeedToken:(BOOL)isNeedToken currentController:(UIViewController *)currentController success:(SuccessBlock)successBlock fail:(FailBlock)failBlock noNet:(NoNetBlock)noNetBlock tokenFail:(TokenFailBlock)tokenFailBlock
{
    
}



- (NSDictionary *)configRequestWithUrl:(NSString *)urlPath pramas:(NSDictionary *)pramaDic method:(NSString *)method isNeedToken:(BOOL)isNeedToken currentController:(UIViewController *)currentController success:(SuccessBlock)successBlock fail:(FailBlock)failBlock noNet:(NoNetBlock)noNetBlock tokenFail:(TokenFailBlock)tokenFailBlock
{
    
}

@end
