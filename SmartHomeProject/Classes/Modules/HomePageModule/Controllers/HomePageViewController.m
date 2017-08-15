//
//  HomePageViewController.m
//  SmartHomeProject
//
//  Created by 李选雁 on 2017/8/12.
//
// 首页

#import "HomePageViewController.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"首页";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //测试获取城市公园接口
    [[SH_AFNetClientTool shareNetClientTool]resquestWithUrl:@"http://www.baidu.com" pramas:nil method:@"get" isNeedToken:NO currentController:self success:^(NSData *stringData, id JsonDict) {
        
        NSLog(@"success:%@",JsonDict);
    } fail:^(NSError *error) {
        NSLog(@"error:%@",error.localizedDescription);
    } noNet:^(NSString *alertMessage) {
        
    } tokenFail:^(NSString *tokenFail) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
