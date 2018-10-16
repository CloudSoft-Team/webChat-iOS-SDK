//
//  ViewController.h
//  testWebChatSDK
//
//  Created by Luck on 17/6/7.
//  Copyright © 2017年 hongmw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController
//默认参数
/**
 * 渠道号
 **/
@property (weak, nonatomic) IBOutlet UITextField *default_systemid;

/**
 * 客户唯一标识符
 **/
@property (weak, nonatomic) IBOutlet UITextField *default_customerID;

/**
 * 昵称
 */
@property (weak, nonatomic) IBOutlet UITextField *default_nickname;


/**
 * 性别
 **/
@property (weak, nonatomic) IBOutlet UISegmentedControl *default_sex;

/**
 * 城市
 **/
@property (weak, nonatomic) IBOutlet UITextField *default_city;


/**
 * userIP 192.161.1.1
 **/
@property (weak, nonatomic) IBOutlet UITextField *default_userIP;

/**
 * 头像
 **/
@property (weak, nonatomic) IBOutlet UITextField *default_logoUrl;


////////自定义参数
/**
 * 客服模式 off 1 半人工，on 2 人工
 **/
@property (weak, nonatomic) IBOutlet UISwitch *cus_kfMode;


/**
 * 电话号码
 **/
@property (weak, nonatomic) IBOutlet UITextField *cus_phoneNum;

/**
 * 邮箱
 **/
@property (weak, nonatomic) IBOutlet UITextField *cus_email;

/**
 * 生日
 **/
@property (weak, nonatomic) IBOutlet UITextField *cus_birthDate;


/**
 * 签名
 **/
@property (weak, nonatomic) IBOutlet UITextField *cus_signature;

/**
 * 证件类型，身份证，护照，其它
 **/
@property (weak, nonatomic) IBOutlet UISegmentedControl *cus_certificationType;

/**
 * 证件号码
 **/
@property (weak, nonatomic) IBOutlet UITextField *cus_cetificationNumber;

/**
 * 企业号
 **/
@property (weak, nonatomic) IBOutlet UITextField *cus_currentCompanyId;

/**
 * 公司名称
 **/
@property (weak, nonatomic) IBOutlet UITextField *cus_currentCompanyName;

/**
 * 公司职位
 **/
@property (weak, nonatomic) IBOutlet UITextField *cus_currentCompanyRole;



@end

