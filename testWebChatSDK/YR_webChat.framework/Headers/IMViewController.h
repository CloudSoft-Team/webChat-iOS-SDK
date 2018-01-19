//
//  IMViewController.h
//  ImccSdk
//
//  Created by wq on 15/11/20.
//  Copyright (c) 2015年 IMCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMViewController : UIViewController

/**
 * 企业标识（* 必须，可登录客服平台，在左下角点击设置-接入渠道-webchat查看）
 */
@property (nonatomic , copy) NSString *systemId;
/**
 * 用户标识 例如手机号等(*必须 ，自定义，每个用户ID必须唯一，只能使用英文、数字、下划线）
 */
@property(nonatomic,copy)NSString*cust_im_number;
/**
 * 用户昵称(* 建议填写，在接入客服的时候，昵称会展示给客服查看，可传任何字符)
 */
@property (nonatomic, copy) NSString * imUserNick;

/**
 * 用户Logo(可选)
 */
@property (nonatomic,copy)NSString * logoUrl;

/**
 *  用户性别： 1:男  2：女(可选)
 */
@property (nonatomic,copy)NSString * sex;

/**
 *  用户所在城市(可选)
 */
@property (nonatomic,copy)NSString * City;

/**
 *  用户IP(可选)
 */
@property (nonatomic,copy)NSString * userIP;

/**
 * 用户生日(可选)
 */
@property (nonatomic,copy)NSString * Birthday;

/**
 * 用户自定义字段（可选，字典格式，多个自定义参数就以多个键值对形式）
 */
@property (nonatomic,strong)NSDictionary * params;

/**
 *  自定义标题（默认为在线客服）
 */
@property (nonatomic, copy) NSString *headTitle;

/**
 *  退出聊天界面时，是否继续接收消息（默认为NO不接收 、YES接收）push入栈时才生效，模态视图弹出无效
 */
@property (nonatomic, assign) BOOL getMessage;

/**
 *  TabelView背景颜色（可选,默认 RGB(235, 235, 235, 1)）
 */
@property (nonatomic,strong)UIColor * tabBackColo;

/**
 * 文字大小(可选，默认 17.0f)
 */
@property (nonatomic,strong)UIFont * textFont;

/**
 * 客服聊天文字颜色(可选，默认黑色)
 */
@property (nonatomic,strong)UIColor * serviceTextColor;

/**
 * 顾客聊天文字颜色（可选,默认 黑色）
 */
@property (nonatomic,strong)UIColor * customerTextColor;

/**
 * 客服气泡上TextView的背景颜色(可选,默认 RGB(79, 209, 140, 1))
 */
@property (nonatomic,strong)UIColor * serviceTextViewBgColor;

/**
 * 顾客气泡上TextView的背景颜色（可选,默认 RGB(241, 245, 248, 1)）
 */
@property (nonatomic,strong)UIColor * customerTextViewBgColor;

/**
 * 是否隐藏头部视图(默认不隐藏,顶部视图高 64)
 */
@property (nonatomic,assign)BOOL IshiddenHeaderView;

/**
 *  size(138,40);为@1x
 *  自定义Logo图片（默认为云软Logo,IshiddenHeaderView 为YES 时不存在）
 */
@property (nonatomic, strong) UIImage *headLogo;

/**
 *  关键字（可选,对应不同的导航流程）
 */
@property (nonatomic,copy)NSString * keywords;

/**
 * 刷新IM的TabView聊天记录列表
 */
- (void)reloadIMList;

/**
 *  清除聊天记录
 *
 *  @param userID 用户标识 这里传 上边的 cust_im_number
 *
 *  @param completeBlock 清除缓存结果回调（isComplete == YES 清除成功   NO : 失败或者参数userID为nil,请填写）
 */
+ (void)clearCacheWithUserID:(NSString * )userID completeBlock:(void(^)(BOOL isComplete))block;

/**
 *  获取聊天记录的大小
 *
 *  @param userID 用户标识  这里传 上边的 cust_im_number
 *
 *  @return 单位：字节
 */
+ (unsigned long long)getCacheSizeWithUserID:(NSString * )userID;

//注销用户时，一定要调用此方法！
- (void) ExitLogin;

@end












