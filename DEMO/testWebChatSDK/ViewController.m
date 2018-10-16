//
//  ViewController.m
//  testWebChatSDK
//
//  Created by Luck on 17/6/7.
//  Copyright © 2017年 hongmw. All rights reserved.
//

//10005 UCC   (一点公益      1244      8000@10187) 不要语音，image方式
//            (移联盛钱包    1841      1018@10611)
//            (E代驾        EDJSJD    10086@10898 Aa_888888)
//            (汇联         2085      10086@10799) 打开bitcode，带删除，bundle包方式
//            (洋葱小姐 )


//川财证券
//http://118.123.205.27/weixinif/weixinFile/upload/
//http://118.123.205.27/weixinif/weixinFile/download/
//http://118.123.205.27/httpif/
//http://118.123.205.27/cczq/         (serviceInfoUrl)
// 1002@11198 888888      custm_id:7100002


//http://ubak.im-cc.com:8181/upload
//http://ubak.im-cc.com:18400/weixinFile/
//http://ubak.im-cc.com:18400/httpif

//@"Fy5eS2" 国海
//http://tglmcs.ghzq.com.cn/weixinif/upload
//http://tglmcs.ghzq.com.cn/weixinif/weixinFile/
//http://tglmcs.ghzq.com.cn/httpif/

//WGn46A 测试环境   /interface/webchat/listAll.do
//http://192.168.10.37:18400/upload
//http://192.168.10.37:18400/download/
//http://192.168.10.37:18400/httpif/

//RoGTSm
//http://u.im-cc.com:18400/upload/
//http://u.im-cc.com:18400/download/
//http://u.im-cc.com:18400/httpif/
// 1074@10057 Aa_111111

//uat环境
//http://uccuat.im-cc.com/upload/
//http://uccuat.im-cc.com/download/
//http://uccuat.im-cc.com/httpif/
// 1010@11198 Aa_111111

#import "ViewController.h"
#import "YR_webChat.framework/Headers/YR_webChat.h"
@interface ViewController ()

/**
 * 会话
 */
@property (nonatomic, strong) IMViewController *im;

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) UIButton *button;

/**
 * 当前登陆的cusyttemID
 */
@property (nonatomic, copy) NSString *currentSystemID;

/**
 * 当前登陆的用户id
 */
@property (nonatomic, copy) NSString *currentCustomerID;

@end

@implementation ViewController
- (instancetype)init{
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ViewController"];
    return vc;
}
- (void)endEidting{
    [self.view endEditing:YES];
}
- (void)popVC{
    [self.im ExitLogin];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置
    self.navigationController.navigationBar.translucent = NO;
    
    UIBarButtonItem *clearMessage = [[UIBarButtonItem alloc]initWithTitle:@"清空记录" style:UIBarButtonItemStylePlain target:self action:@selector(testClearCache)];
    self.navigationItem.leftBarButtonItems = @[clearMessage];
    
    UIBarButtonItem *changeCount = [[UIBarButtonItem alloc]initWithTitle:@"注销关闭会话" style:UIBarButtonItemStylePlain target:self action:@selector(exitloginAndChange)];
    self.navigationItem.rightBarButtonItem = changeCount;
    
    //悬浮窗口
    [self performSelector:@selector(createButton) withObject:nil afterDelay:0];
    
    
    //全屏手势，点击隐藏键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
   [tap addTarget:self action:@selector(endEidting)];
   [self.view addGestureRecognizer:tap];
    
    //外部获取聊天消息的通知  新消息提醒通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti3:) name:@"getMessage" object:nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *default_customerID = @"";
    NSString *currentSystenID = @"";
    
    
    //
    self.default_customerID.text = @"hb123456789";
    self.default_systemid.text = @"123";
    
    default_customerID = [defaults objectForKey:@"default_customerID"];
    currentSystenID = [defaults objectForKey:@"currentSystenID"];
    
    if (default_customerID.length > 0) {
        self.default_customerID.text = default_customerID;
    }
    if (currentSystenID.length > 0) {
        self.default_systemid.text = currentSystenID;
    }
    [defaults synchronize];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [UIView animateWithDuration:0.3 animations:^{
        _button.frame = CGRectMake(self.view.frame.size.width - 70, self.view.frame.size.height - 100, 60, 60);
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIView animateWithDuration:0.3 animations:^{
        _button.frame =CGRectMake(0,0,0,0);
    }];
}

//清空聊天记录并刷新，若不调用reloadIMList则不会立即刷新，需重启app
- (void)testClearCache{
    //这是计算聊天记录数据大小的
    NSString *customerID = self.default_customerID.text;
    NSString *systemID = self.default_systemid.text;
    if (customerID.length == 0 || systemID.length == 0) {
        return;
    }
    unsigned long long size =  [IMViewController getCacheSizeWithUserID:customerID withSystemID:systemID];
    NSString *sizeStr = [NSString stringWithFormat:@"%lld 字节",size];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"聊天记录缓存" message:sizeStr preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //删除并刷新
        [IMViewController clearCacheWithUserID:customerID withSystemID:systemID  completeBlock:^(BOOL isComplete) {
            
            //刷新IM
            [self.im reloadIMList];
        }];
    }]];

    [self presentViewController:alert animated:YES completion:nil];
}

//  注销
- (void)exitloginAndChange{
   
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退出当前会话？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    __weak ViewController *weakself = self;
    [alert addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //关闭会话 ，退出客服聊天
        [weakself.im ExitLogin];
        weakself.currentCustomerID = nil;
        weakself.currentSystemID = nil;

    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

//开始会话
- (void)beginTalk{
    
    //切换渠道号，或者客户唯一标识的时候，需要先退出上一个会话
    if ((self.currentCustomerID != nil && self.currentSystemID != nil) && (![self.currentSystemID isEqualToString:self.default_systemid.text] || ![self.currentCustomerID isEqualToString:self.default_customerID.text])) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请先注销当前会话后再切换账号" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    NSString *default_customerID = self.default_customerID.text.length > 0 ? self.default_customerID.text:@"";
    NSString *currentSystenID = self.default_customerID.text.length > 0 ? self.default_systemid.text:@"";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    

    NSString *curentIsUat = [defaults objectForKey:@"curentIsUat"];
    
    [defaults setValue:default_customerID forKey:@"default_customerID"];
    [defaults setValue:currentSystenID forKey:@"currentSystenID"];
    
    [defaults synchronize];

    
    //调用方法
    self.im = [[IMViewController alloc]init];
    
    self.im.headTitle = @"客服";
    
    //默认必填参数
    self.im.systemId       = self.default_systemid.text;    //webChat企业接入号，由我司提供
    self.im.cust_im_number = self.default_customerID.text;  //代表用户ID
    
    //当前登陆信息为空，记录一下
    if (self.currentCustomerID == nil || self.currentSystemID == nil) {
        self.currentSystemID = self.default_systemid.text;
        self.currentCustomerID =  self.default_customerID.text;
    }
    
    if (self.im.systemId.length == 0 || self.im.cust_im_number.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"缺少systemid，customerID" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    
    
    //默认可选参数
    self.im.imUserNick         = self.default_nickname.text;  //显示在客服平台上的昵称
    self.im.sex = self.default_sex.selectedSegmentIndex == 0 ?@"1":@"2";  // 1男 2女
    self.im.City = self.default_city.text;  //城市
    self.im.userIP = self.default_userIP.text;
    self.im.logoUrl = self.default_logoUrl.text; //客户默认头像

    
    
    
    
    // 用户自定义字段（可选，字典格式，多个自定义参数就以多个键值对形式）
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    NSString *KFMode = self.cus_kfMode.isOn ? @"2":@"1"; //进入客服的模式开关，默认为智能客服 1:智能客服/半人工客服，2:全人工客服
//
//    NSString *phoneNumber = self.cus_phoneNum.text.length == 0 ? @"":self.cus_phoneNum.text; //手机号码
//    NSString *email = self.cus_email.text.length == 0 ? @"":self.cus_email.text; //邮箱地址
//    NSString *signature = self.cus_signature.text.length == 0 ? @"":self.cus_signature.text; //个性签名
//    NSString *certificationType = @[@"",@"身份证",@"护照",@"其它"][self.cus_certificationType.selectedSegmentIndex]; //证件类型，传值时转换为中文证件类型名称，如身份证、护照等
//    NSString *certificationNumber = self.cus_cetificationNumber.text.length == 0 ? @"":self.cus_cetificationNumber.text; //证件号码，传值时末后四位以星号代替
//    NSString *currentCompanyId = self.cus_currentCompanyId.text.length == 0 ? @"":self.cus_currentCompanyId.text; //当前企业号
//    NSString *currentCompanyName = self.cus_currentCompanyName.text.length == 0 ? @"":self.cus_currentCompanyName.text; //当前企业名称
//    NSString *currentCompanyRole = self.cus_currentCompanyRole.text.length == 0 ? @"":self.cus_currentCompanyRole.text; //在当前企业的角色
//    NSString *birthDate = self.cus_birthDate.text.length == 0? @"":self.cus_birthDate.text;
//
//    [param setValue:KFMode forKey:@"KFMode"];
//    [param setValue:phoneNumber forKey:@"phoneNumber"];
//    [param setValue:email forKey:@"email"];
//    [param setValue:signature forKey:@"signature"];
//    [param setValue:certificationType forKey:@"certificationType"];
//    [param setValue:certificationNumber forKey:@"certificationNumber"];
//    [param setValue:currentCompanyId forKey:@"currentCompanyId"];
//    [param setValue:currentCompanyName forKey:@"currentCompanyName"];
//    [param setValue:currentCompanyRole forKey:@"currentCompanyRole"];
//    [param setValue:birthDate forKey:@"birthDate"];
//
//
//    self.im.params = [NSDictionary dictionaryWithDictionary:param];
    
    NSLog(@"自定义参数==%@",self.im.params);
    [self.navigationController pushViewController:self.im animated:YES];
}
//
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//当处在聊天界面外，有新消息发送过来，会触发此方法
-(void)noti3:(NSNotification *)noti{
    NSDictionary *dic = noti.userInfo;
    NSString *message = dic[@"message"];
    NSLog(@"newMessage:%@",message);
}

- (void)createButton{
    
    _window = [UIApplication sharedApplication].windows[0];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_button setTitle:@"进入IM" forState:UIControlStateNormal];
    
    _button.frame = CGRectMake(self.view.frame.size.width - 70, self.view.frame.size.height - 70, 60, 60);
    
    _button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    
    [_button setBackgroundColor:[UIColor orangeColor]];
    
    _button.layer.cornerRadius = 30;
    
    _button.layer.masksToBounds = YES;
    
    [_button addTarget:self action:@selector(beginTalk) forControlEvents:UIControlEventTouchUpInside];
   
    [_window addSubview:_button];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
