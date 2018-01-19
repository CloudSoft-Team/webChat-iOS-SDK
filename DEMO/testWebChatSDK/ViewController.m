//
//  ViewController.m
//  testWebChatSDK
//
//  Created by Luck on 17/6/7.
//  Copyright © 2017年 hongmw. All rights reserved.
//

#import "ViewController.h"
#import <YR_webChat/YR_webChat.h>

static NSString * systemId = @"QbTXZB";


@interface ViewController (){
    IMViewController *im;
    UITextView *_textV;
    NSMutableString *_str;
    NSString *cust_im_number;
}
/**
 *  注释
 */
@property (nonatomic, strong) UILabel *cacheSize;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置
    self.navigationController.navigationBar.translucent = NO;
    
    //获取沙盒路径
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSLog(@"沙盒路径：%@",path);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"进入IM" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(50, 50, 250, 40);
    btn.backgroundColor = [UIColor yellowColor];
    [btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"删除缓存" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn2.frame = CGRectMake(50, 100, 100, 40);
    btn2.backgroundColor = [UIColor yellowColor];
    [btn2 addTarget:self action:@selector(testClearCache) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:@"缓存大小" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn3.frame = CGRectMake(50, 150, 100, 40);
    btn3.backgroundColor = [UIColor yellowColor];
    [btn3 addTarget:self action:@selector(testGetCache) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    self.cacheSize = [[UILabel alloc]init];
    self.cacheSize.backgroundColor = [UIColor orangeColor];
    self.cacheSize.textAlignment = NSTextAlignmentCenter;
    self.cacheSize.frame = CGRectMake(200, 100, 100, 90);
    [self.view addSubview:self.cacheSize];
    
    _textV = [[UITextView alloc] initWithFrame:CGRectMake(50, 200, 250, 200)];
    _textV.backgroundColor = [UIColor greenColor];
    _textV.textColor = [UIColor redColor];
    _textV.text = @"什么都没有！";
    [self.view addSubview:_textV];
    _str = [NSMutableString string];
    
    //全屏手势，点击隐藏键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(endEidting)];
    [self.view addGestureRecognizer:tap];
    
    //外部获取聊天消息的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti3:) name:@"getMessage" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

//清空聊天记录并刷新，若不调用reloadIMList则不会立即刷新，需重启app
- (void)testClearCache{
    [IMViewController clearCacheWithUserID:cust_im_number completeBlock:^(BOOL isComplete) {
        
        //刷新IM
        [im reloadIMList];
    }];
}

- (void)testGetCache{
    [[[IMViewController alloc] init]ExitLogin];
    unsigned long long size =  [IMViewController getCacheSizeWithUserID:cust_im_number];
    
    NSLog(@"size = %lld",size);
    
    self.cacheSize.text = [NSString stringWithFormat:@"%lld 字节",size];
}

- (void)test{
    
    //调用方法
    im = [[IMViewController alloc]init];
    im.systemId       = systemId;
    im.cust_im_number = @"appName_telephoneNumber1";//代表用户ID
    im.getMessage         = YES;
    im.imUserNick         = @"iOS-App用户";  //显示在客服平台上的昵称
    [im setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:im animated:YES];
}

//当处在聊天界面外，有新消息发送过来，会触发此方法
-(void)noti3:(NSNotification *)noti{
    NSDictionary *dic = noti.userInfo;
    NSString *sss = dic[@"message"];
    [_str appendFormat:@"\n%@",sss];
    _textV.text = _str;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) endEidting{
    
    [_textV endEditing:YES];
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
