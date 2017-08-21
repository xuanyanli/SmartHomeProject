//
//  UserHeadPortraitView.m
//  SmartHomeProject
//
//  Created by 李选雁 on 2017/8/19.
//
// 用户头像

#import "UserHeadPortraitView.h"

@interface UserHeadPortraitView ()

/**
 头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *portraitImageView;


/**
 用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;

/**
 用户头像
 */
@property (nonatomic,copy) NSString *portraitImagePath;

/**
 用户名
 */
@property (nonatomic,copy) NSString *userName;


@end

@implementation UserHeadPortraitView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //给头像添加手势
    [self addTapGestureOnProtraitImageView];
}

#pragma mark-  给头像添加手势
- (void)addTapGestureOnProtraitImageView
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(protraitImageViewTap:)];
    [self.portraitImageView addGestureRecognizer:tapGesture];
}

#pragma mark- 点击头像触发
- (void)protraitImageViewTap:(UITapGestureRecognizer *)tapGesture
{
    if ([self.delegate respondsToSelector:@selector(userHeadPortraitView:headerImageTapped:)])
    {
        [self.delegate userHeadPortraitView:self headerImageTapped:YES];
    }
}

#pragma mark-  用头像与用户名创建头像视图
- (void)createUserHeadPortraitViewWithHeaderImagePath:(NSString *)imagePath userName:(NSString *)userName
{
    self.portraitImagePath = imagePath;
    self.userName = userName;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
