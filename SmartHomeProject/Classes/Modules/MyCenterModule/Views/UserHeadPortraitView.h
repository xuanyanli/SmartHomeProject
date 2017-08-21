//
//  UserHeadPortraitView.h
//  SmartHomeProject
//
//  Created by 李选雁 on 2017/8/19.
//
//  用户头像

#import <UIKit/UIKit.h>

@class UserHeadPortraitView;
@protocol UserHeadPortraitViewDelegate <NSObject>

@optional

/**
 头像点击

 @param headPortraitView self
 @param isTapped 是否点击
 */
- (void)userHeadPortraitView:(UserHeadPortraitView *)headPortraitView headerImageTapped:(BOOL)isTapped;

@end

@interface UserHeadPortraitView : UIView

@property (nonatomic,assign)id<UserHeadPortraitViewDelegate>delegate;

/**
 用头像与用户名创建头像视图

 @param imagePath 头像URL
 @param userName 用户名
 */
- (void)createUserHeadPortraitViewWithHeaderImagePath:(NSString *)imagePath userName:(NSString *)userName;

@end
