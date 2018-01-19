# webChat-iOS-SDK
webChat-iOS版本
WebChatSDK 接入文档
一、​版本更新说明：​2
二、​接入后效果图​2
三、​WebChatSDK文件说明：​2
四、​加入ThirdLib文件夹中的第三方库报错及解决方案：​3
五、​添加依赖库文件：​5
六、​WebChatSDK库所支持的架构：​5
七、​加入SDK后工程配置：​5
八、​接入方法​6
九、​IMViewController相关函数：​7
十、​IMViewController相关属性说明​8
 
 
 
 
 
 
 
 
​•​版本更新说明： 
 
​•​接入后效果图 
 
​​​​​​​​ 
​•​WebChatSDK文件说明： 
   WebChatSDK  IM核心框架
    资源文件
相关接入URL地址
请将以上3个文件加入工程中,由于WebChatSDK 依赖一些第三方,所以需要导入ThirdLib文件夹中使用到的第三方库(如若您工程中已存在对应第三方库，可不用导入,但必须保证最新)
YR_webChat_Url.plist 中保存着3个URL地址请联系相关人员拿对应的地址进行修改。​​​​​​​​​​​​​
 
（img_UploadUrl   图片上传Url）
（img_downloadUrl 文件下载Url 此URL末尾带“/”,若没有自行添加）
（ServiceInfoUrl 客服信息Url）
（loginUrl 登录Url）
   （ImmediatelyLogin默认YES）
​•​加入ThirdLib文件夹中的第三方库报错及解决方案： 
​•​GDataXML报错： 
 
解决方案：
1.1在工程的“Build Settings”页中找到“Header Search Path”项，添加”/usr/include/libxml2”到路径中
 
 
 
 
 
 
 
 
​•​向工程中增加“libxml2.dylib”库 
 
1.3在工程的Build Phases 中点开Compile Sources里找到  GDataXMLNode 添加标记“-fno-objc-arc”
​•​RegexKitLite 报错 
 
解决方案：
在工程的Build Phases 中点开Compile Sources里找到 RegexKitLite.m 添加标记“-fno-objc-arc”
​•​Reachability 报错解决： 
如 2中。
​•​加入VoiceConvert报错 
 
 
解决方案：
注释掉VoiceConverter 中的 GetAudioRecorderSettingDict方法
​•​添加依赖库文件： 
libsqlite3.tbd、libxml2.tbd、libicucore.tbd、SystemConfiguration.framework
​•​WebChatSDK库所支持的架构： 
支持armv7 armv7s i386 x86_64 arm64
​•​加入SDK后工程配置： 
（1）在工程的 Build Settings 中查找 other linker Flags 添加 “-all_load”或“-ObjC”
（2）注意：由于内部的客服聊天请求协议用的是http协议，在Xocde7.0或7.0以上版本，系统默认会拦截对http协议接口的访问，因此无法获取http协议接口的数据。解决的办法是暂时退回到http协议，具体方法：在项目的info.plist中添加一个Key：NSAppTransportSecurity，类型为字典类型。然后给它添加一个Key ：NSAllowsArbitraryLoads，类型为Boolean类型，值为YES；(注意项目有两个info.plist注意区分，修改单元测试下面的Info.plist无效)。
 
 
 
（3）添加相机、相册、麦克风等权限
 
Privacy - Camera Usage Description      是否允许访问您的相机？
Privacy - Photo Library Usage Description 是否允许访问您的相册？
Privacy - Microphone Usage Description   是否允许访问您的麦克风？
​•​接入方法 
导入头文件 #import <YR_webChat/YR_webChat.h>  
注:Demo 中不可直接运行，下图中的systemId, cust_im_number字段需要填写：
 接入方式采用导航入栈：
 
 
 
 
  其中systemId，cust_im_number 2个属性为必填项，其他为非必须(相关说明可查看第十二条IMViewController相关属性说明)
 
​•​IMViewController相关函数： 
​•​获取聊天记录的大小 
 
 
2.清除缓存，并刷新IMViewController（若不调用刷新，需重启app才能达到效果）
 
 
 
3.在IMViewcontroller控制器页面外获取聊天消息
1）注册通知，name必须为getMessage
 
​•​调用接受通知的方法 
 
 
userInfo中包含的key为：
message ：消息内容，语音和图片的URL会自动显示为[语音]、[图片]等；
cStrmessage ： 消息内容，语音和图片等显示为URL。
​•​IMViewController相关属性说明 
（* 必须 为 必填字段）
企业标识（* 必须，可登录客服平台，在左下角点击设置-接入渠道-webchat查看）
@property (nonatomic , copy) NSString *systemId;
 
用户标识 例如手机号等（* 必须，自定义，每个用户ID必须唯一，只能使用英文、数字、下划线）
@property(nonatomic,copy)NSString*cust_im_number;
 
用户昵称(* 建议填写，在接入客服的时候，昵称会展示给客服查看，可传任何字符)
@property (nonatomic, copy) NSString * imUserNick;
/**
* 用户Logo(可选)
*/
@property(nonatomic,copy)NSString* logoUrl;
 
用户所在城市(可选)
@property (nonatomic,copy)NSString * City;
 
用户IP(可选)
@property (nonatomic,copy)NSString * userIP;
 
用户生日(可选)
@property (nonatomic,copy)NSString * Birthday;
 
用户性别： 1:男  2：女(可选)
@property (nonatomic,copy)NSString * sex;
 
/**
* 用户自定义字段（可选，字典格式，多个自定义参数就以多个键值对形式）
*/
@property (nonatomic,strong)NSDictionary * params;
 
/**
*  自定义标题（默认为在线客服）
*/
@property (nonatomic, copy) NSString *headTitle;
/**
*  退出聊天界面时，是否继续接收消息（默认为NO不接收 、YES接收）此处必须push入栈才生效，模态视图弹出无效
*/
@property (nonatomic, assign) BOOL getMessage;
TabelView背景颜色（可选）
@property (nonatomic,strong)UIColor * tabBackColo;
/**
* 文字大小(可选，默认 17.0f)
*/
@property (nonatomic,strong)UIFont * textFont;
/**
* 客服聊天文字颜色(可选，默认黑色)
*/
@property(nonatomic,strong)UIColor*serviceTextColor;
/**
* 顾客聊天文字颜色（可选,默认 黑色）
*/
@property(nonatomic,strong)UIColor*customerTextColor;
/**
* 客服气泡上TextView的背景颜色(可选,默认 RGB(79, 209, 140, 1))
*/
@property(nonatomic,strong)UIColor*serviceTextViewBgColor;
/**
* 顾客气泡上TextView的背景颜色（可选,默认 RGB(241, 245, 248, 1)）
*/
@property(nonatomic,strong)UIColor*customerTextViewBgColor;
/**
* 是否隐藏头部视图(默认不隐藏,顶部视图高 64,建议设置为YES)
*/
@property (nonatomic,assign)BOOL IshiddenHeaderView;
 
/**
*  size(138,40);为@1x
*  自定义Logo图片（默认为云软Logo,IshiddenHeaderView 为YES 时不存在）
*/
@property (nonatomic, strong) UIImage *headLogo;
关键字（可选,对应不同的导航流程）
@property (nonatomic,copy)NSString * keywords;
