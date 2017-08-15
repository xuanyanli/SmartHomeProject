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
 成功回调
 */
@property (nonatomic,copy) SuccessBlock successBlock;

/**
 失败回调
 */
@property (nonatomic,copy) FailBlock failBlock;

/**
 token失效回调
 */
@property (nonatomic,copy) TokenFailBlock tokenFailBlock;

/**
 没有网络回调
 */
@property (nonatomic,copy) NoNetBlock noNetBlock;

/**
 请求管理类
 */
@property (nonatomic,strong)AFHTTPSessionManager *httpManager;

@end

//url key
#define Req_Url_Key @"reqUrlKey"

//param key
#define Req_ParamDic_Key @"reqParamKey"

#define Req_Manager_Key @"reqManagerKey"

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
    
}

#pragma mark 配置https证书
- (AFSecurityPolicy *)customSecurityPolicy
{
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    NSString *cerPath = [[NSBundle mainBundle]pathForResource:@"test_leyou" ofType:@"cer"];
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

#pragma mark- 数据请求成功之后的解析部分
- (id)requestSuccessTask:(NSURLSessionDataTask * _Nonnull)task andResponse:(id  _Nullable)responseObject
{
    
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    if ([jsonDic isEqual:[NSNull null]])
    {
        return nil;
    }

    return jsonDic;
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
    //配置网络请求管理类
    [self configHttpManager];
    
    self.successBlock = [successBlock copy];
    self.failBlock = [failBlock copy];
    self.noNetBlock = [noNetBlock copy];
    self.tokenFailBlock = [tokenFailBlock copy];
    
    //网络请求
    if ([[method uppercaseString] isEqualToString:@"GET"])
    {
        //GET 请求
        [self getWithUrl:urlPath pramas:pramaDic success:successBlock fail:failBlock];
    }else if ([[method uppercaseString] isEqualToString:@"POST"])
    {
        //POST 请求
        [self postWithUrl:urlPath pramas:pramaDic success:successBlock fail:failBlock];
    }else
    {
        NSLog(@"不支持的请求类型");
    }
}

#pragma mark-  Get网络请求请求
- (void)getWithUrl:(NSString *)urlPath pramas:(NSDictionary *)pramaDic   success:(SuccessBlock)successBlock fail:(FailBlock)failBlock
{
    [self.httpManager GET:urlPath parameters:pramaDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id jsonDic = [self requestSuccessTask:task andResponse:responseObject];
        
        self.successBlock (responseObject,jsonDic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        self.failBlock (error);
    }];
}

#pragma mark- Post网络请求请求
- (void)postWithUrl:(NSString *)urlPath pramas:(NSDictionary *)pramaDic  success:(SuccessBlock)successBlock fail:(FailBlock)failBlock
{
    [self.httpManager POST:urlPath parameters:pramaDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id jsonDic = [self requestSuccessTask:task andResponse:responseObject];
        
        self.successBlock (responseObject,jsonDic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
         self.failBlock (error);
    }];
}


@end
