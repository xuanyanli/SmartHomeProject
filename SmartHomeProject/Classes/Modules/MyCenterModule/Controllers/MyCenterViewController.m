//
//  MyCenterViewController.m
//  SmartHomeProject
//
//  Created by 李选雁 on 2017/8/12.
//
//  个人中心

#import "MyCenterViewController.h"

#import "UserHeadPortraitView.h"

@interface MyCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *myCenterTableView;

@end

@implementation MyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置属性
    [self setUpProperty];
}

#pragma mark-  设置属性
- (void)setUpProperty
{
    self.title = @"个人中心";
    //创建列表
    [self createMyCenterTableView];
}

#pragma mark-  创建列表
- (void)createMyCenterTableView
{
    self.myCenterTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.myCenterTableView.delegate = self;
    self.myCenterTableView.dataSource = self;
    self.myCenterTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.myCenterTableView];
    
    //创建tableHeaderView
    [self createTableHeaderView];
}

#pragma mark 创建tableHeaderView
- (void)createTableHeaderView
{
    UserHeadPortraitView *headerView = [[[NSBundle mainBundle]loadNibNamed:@"UserHeadPortraitView" owner:self options:nil]lastObject];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 200);
    self.myCenterTableView.tableHeaderView = headerView;
}

#pragma mark- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
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
