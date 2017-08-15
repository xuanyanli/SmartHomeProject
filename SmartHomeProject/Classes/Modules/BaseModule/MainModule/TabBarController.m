//
//  TabBarController.m
//  SmartHomeProject
//
//  Created by 李选雁 on 2017/8/12.
//
//

#import "TabBarController.h"

#import "BaseNavigationController.h"

#import "MyCenterViewController.h"

#import "HomePageViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建tabbar上的几个主模块
    [self createTabbarItems];
}

#pragma mark- 创建tabbar上的几个主模块
- (void)createTabbarItems
{
    NSMutableArray *navControlArray = [NSMutableArray array];
    [navControlArray addObject:[self createHomePageItem]];
    [navControlArray addObject:[self createMyCenterItem]];
    
    self.viewControllers = [navControlArray mutableCopy];
}

#pragma mark 创建首页模块
- (BaseNavigationController *)createHomePageItem
{
    HomePageViewController *homePageVC = [[HomePageViewController alloc]init];
    BaseNavigationController *homePageNav = [[BaseNavigationController alloc]initWithRootViewController:homePageVC];
    UIImage *normalImage = [UIImage imageNamed:@"home_page_normal"];
    UIImage *selectedImage = [UIImage imageNamed:@"home_page_selected"];
    homePageNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:normalImage selectedImage:selectedImage];
    
    return homePageNav;
}

#pragma mark 创建首页模块
- (BaseNavigationController *)createMyCenterItem
{
    MyCenterViewController *myCenterVC = [[MyCenterViewController alloc]init];
    BaseNavigationController *myCenterNav = [[BaseNavigationController alloc]initWithRootViewController:myCenterVC];
    UIImage *normalImage = [UIImage imageNamed:@"my_info_normal"];
    UIImage *selectedImage = [UIImage imageNamed:@"my_info_selected"];
    myCenterNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"个人中心" image:normalImage selectedImage:selectedImage];
    
    return myCenterNav;
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
