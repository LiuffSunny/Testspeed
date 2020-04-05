//
//  MonitorNetSppedViewController.m
//  STPingTest
//
//  Created by LiuffSunny on 2019/5/6.
//  Copyright © 2019 Suen. All rights reserved.
//

#import "MonitorNetSppedViewController.h"
#import "UIColor+Utility.h"
#import "ClockDialView.h"
#import "STDebugFoundation.h"
#import "STDPingServices.h"
#import "OYNetSpeedTool.h"
#import "AFHTTPSessionManager.h"
#import "GSNetworkSpeed.h"
#import "UIView+Addition.h"



#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface MonitorNetSppedViewController ()
<OYNetSpeedToolDelegate>
@property (nonatomic, strong) OYNetSpeedTool *tool;
@property (nonatomic,strong)UIButton *downLoadButton;
@property (nonatomic,strong)UIButton *sendButton;

@property (strong, nonatomic) ClockDialView *clockDiaView;
@property (strong, nonatomic) ClockDialView *netclockDiaView;
@property(nonatomic, strong) STDPingServices    *pingServices;
//@property (strong, nonatomic)  UILabel *downloadLabel;
//
//@property (strong, nonatomic)  UILabel *netDelayLabel;
@property (strong ,nonatomic) NSString *speedString;
//@property (strong ,nonatomic) GSNetworkSpeed *speed;
@property (strong ,nonatomic) NSArray *dataSource;
@property (strong,nonatomic) UIImageView *wifiImage;

@property (strong,nonatomic) UIImageView *downLoadImage;
@property (strong,nonatomic) UIImageView *netImageview;
@property (strong,nonatomic) UILabel *downLoadNamelabel;
@property (strong,nonatomic) UILabel *netdelayNamelabel;
//@property (strong,nonatomic) UILabel *downLoadNumlabel;
//@property (strong,nonatomic) UILabel *netDelayNumlabel;

@property (strong,nonatomic) UILabel *downLoadPurplelabel;
@property (strong,nonatomic) UILabel *downLoadbottomNumlabel;

@property (strong,nonatomic) UILabel *netOrangelabel;
@property (strong,nonatomic) UILabel *netbottomNumlabel;
@property (assign,nonatomic) CGFloat currentAvgSpeed;
@property (assign,nonatomic) CGFloat currentAvgnettime;
@property (assign,nonatomic) CGFloat currentDelayTime;
@property (strong,nonatomic) NSMutableArray *speedArray;
@property (strong,nonatomic) NSMutableArray *timeArray;

@property (strong,nonatomic) HWDownloadModel *downloadModel;

@property (strong, nonatomic) ClockDialView *leftclockDiaView;
@property (strong, nonatomic) ClockDialView *rightclockDiaView;
@end

@implementation MonitorNetSppedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.speedArray = [NSMutableArray array];
    self.timeArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHex:0x111111 alpha:1];
    [self setNavigationBar];
    [self.view addSubview:self.downLoadButton];
    [self.view addSubview:self.wifiImage];

//    [self.view addSubview:self.downloadLabel];
//    [self.view addSubview:self.netDelayLabel];
    [self.view addSubview:self.clockDiaView];
    self.clockDiaView.hidden = YES;
    [self.view addSubview:self.netclockDiaView];
    self.netclockDiaView.hidden = YES;
    [self.view addSubview:self.downLoadImage];
    self.downLoadImage.hidden = YES;
    [self.view addSubview:self.downLoadNamelabel];
    self.downLoadNamelabel.hidden = YES;
//    [self.view addSubview:self.downLoadNumlabel];
    [self.view addSubview:self.downLoadPurplelabel];
    self.downLoadPurplelabel.hidden = YES;
    [self.view addSubview:self.downLoadbottomNumlabel];
    self.downLoadbottomNumlabel.hidden = YES;
    
    [self.view addSubview:self.netdelayNamelabel];
    self.netdelayNamelabel.hidden = YES;
//    [self.view addSubview:self.netDelayNumlabel];
    [self.view addSubview:self.netImageview];
    self.netImageview.hidden = YES;
    [self.view addSubview:self.netOrangelabel];
    self.netOrangelabel.hidden = YES;
    [self.view addSubview:self.netbottomNumlabel];
    self.netbottomNumlabel.hidden = YES;

    
    self.tool = [OYNetSpeedTool shareTool];
    self.tool.delegate = self;
//    self.speed = [[GSNetworkSpeed alloc] init];
//    [self.speed start];
    [self getInfo];
    // 添加通知
    [self addNotification];
}
- (void)changeTosmallNet
{
    UIImage *net = [UIImage imageNamed:@"yanshi_ic"];
    [self.netImageview setImage:net];
    self.netImageview.frameWidth = net.size.width;
    self.netImageview.frameHeight = net.size.height;
    self.netdelayNamelabel.textColor = [UIColor colorWithHex:0xFFFFFF alpha:0.5];
    self.netdelayNamelabel.font = [UIFont systemFontOfSize:10];
    self.netdelayNamelabel.frameY = 27;
//    self.netDelayNumlabel.textColor = [UIColor colorWithHex:0xFFFFFF alpha:0.5];
//    self.netDelayNumlabel.font = [UIFont systemFontOfSize:24];
//    self.netDelayNumlabel.text = @"......";
//    self.netDelayNumlabel.frameY = 35;

}
- (void)changeSpeedToSmall
{
    UIImage *spped = [UIImage imageNamed:@"xiazai_ic"];
    [self.downLoadImage setImage:spped];
    self.downLoadImage.frameWidth = spped.size.width;
    self.downLoadImage.frameHeight = spped.size.height;
    self.downLoadNamelabel.textColor = [UIColor colorWithHex:0xFFFFFF alpha:0.5];
    self.downLoadNamelabel.font = [UIFont systemFontOfSize:10];
    self.downLoadNamelabel.frameY = 27;
//    self.downLoadNumlabel.textColor = [UIColor colorWithHex:0xFFFFFF alpha:0.5];
//    self.downLoadNumlabel.font = [UIFont systemFontOfSize:24];
//    if (self.currentAvgSpeed > 0) {
//        self.downLoadNumlabel.text = [NSString stringWithFormat:@"%.2f",self.currentAvgSpeed];
//        self.downLoadNumlabel.frameY = 40;
//    }else
//    {
//        self.downLoadNumlabel.text = @"......";
//        self.downLoadNumlabel.frameY = 35;
//    }

}
// 展示网络延时刻度盘 并隐藏速度
- (void)showNetclockDiaView
{
    // 隐藏紫色的速度
    self.downLoadPurplelabel.hidden = YES;
    self.downLoadbottomNumlabel.hidden = YES;
    
    self.netOrangelabel.hidden = NO;
    self.netbottomNumlabel.hidden = NO;
    
    self.clockDiaView.hidden = YES;
    self.netclockDiaView.minValue = 0;
    self.netclockDiaView.maxValue = 10;
    self.netclockDiaView.hidden = NO;
    [self.netclockDiaView drawArcWithStartAngle:-M_PI_4*5 endAngle:M_PI_4 lineWidth:3.0f fillColor:[UIColor clearColor] strokeColor:RGBA(255, 255, 255, 0.5) isSpeed:NO];
    //刻度
    [self.netclockDiaView drawScaleWithDivide:10 andRemainder:10 strokeColor:RGBA(255, 255, 255, 1) filleColor:RGBA(247,107,28,0.70) scaleLineNormalWidth:10 scaleLineBigWidth:10];
    // 增加刻度值
    [self.netclockDiaView DrawScaleValueWithDivide:0];
    self.netOrangelabel.frameX = 0;
    self.netOrangelabel.frameWidth = SCREEN_WIDTH;
    self.netbottomNumlabel.frameX = 0;
    self.netbottomNumlabel.frameWidth = SCREEN_WIDTH;
}
// 展示速度刻度盘 并隐藏网络
- (void)showSpeedclockDiaView
{
    
    self.netOrangelabel.hidden = YES;
    self.netbottomNumlabel.hidden = YES;
    
    self.netclockDiaView.hidden = YES;
    self.clockDiaView.hidden = NO;
    self.clockDiaView.minValue = 0;
    self.clockDiaView.maxValue = 10;
    [self.clockDiaView drawArcWithStartAngle:-M_PI_4*5 endAngle:M_PI_4 lineWidth:3.0f fillColor:[UIColor clearColor] strokeColor:RGBA(255, 255, 255, 0.5) isSpeed:YES];
    //刻度
    [self.clockDiaView drawScaleWithDivide:10 andRemainder:10 strokeColor:RGBA(255, 255, 255, 1) filleColor:[UIColor colorWithHex:0x6A11CB alpha:0.8] scaleLineNormalWidth:10 scaleLineBigWidth:10];
    // 增加刻度值
    [self.clockDiaView DrawScaleValueWithDivide:0];
    self.downLoadPurplelabel.frameX = 0;
    self.downLoadPurplelabel.frameWidth = SCREEN_WIDTH;
    self.downLoadbottomNumlabel.frameX = 0;
    self.downLoadbottomNumlabel.frameWidth = SCREEN_WIDTH;
}
- (void)changeSpeedTobig
{
    UIImage *bigspped = [UIImage imageNamed:@"xiazai_ic_hl"];
    [self.downLoadImage setImage:bigspped];
    self.downLoadImage.frameWidth = bigspped.size.width;
    self.downLoadImage.frameHeight = bigspped.size.height;
    self.downLoadNamelabel.textColor = [UIColor colorWithHex:0xFFFFFF alpha:1];
    self.downLoadNamelabel.font = [UIFont systemFontOfSize:12];
    self.downLoadNamelabel.frameY = 30;
//    self.downLoadNumlabel.textColor = [UIColor colorWithHex:0xFFFFFF alpha:1];
//    self.downLoadNumlabel.font = [UIFont systemFontOfSize:30];
//    self.downLoadNumlabel.text = [NSString stringWithFormat:@"%.2f",self.currentAvgSpeed];
//    self.downLoadNumlabel.frameY = 50;
}
- (void)changenetTobig
{
    UIImage *bignet = [UIImage imageNamed:@"yanshi_ic_hl"];
    [self.netImageview setImage:bignet];
    self.netImageview.frameWidth = bignet.size.width;
    self.netImageview.frameHeight = bignet.size.height;
    self.netdelayNamelabel.textColor = [UIColor colorWithHex:0xFFFFFF alpha:1];
    self.netdelayNamelabel.font = [UIFont systemFontOfSize:12];
    self.netdelayNamelabel.frameY = 30;
//    self.netDelayNumlabel.textColor = [UIColor colorWithHex:0xFFFFFF alpha:1];
//    self.netDelayNumlabel.font = [UIFont systemFontOfSize:30];
//    if (self.currentAvgnettime > 0) {
//        self.netDelayNumlabel.text =[NSString stringWithFormat:@"%.2f",self.currentAvgnettime];
//    }else
//    {
//        self.netDelayNumlabel.text = @"......";
//    }
//    self.netDelayNumlabel.frameY = 50;
}
// 自定义导航栏菜单
- (void)setNavigationBar {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor  = [UIColor colorWithHex:0x111111 alpha:1];
//    self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
    self.navigationItem.title = @"测速";
    //修改导航栏文字字体和颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:16]};
}
- (void)addNotification
{
    // 进度通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoadProgress:) name:HWDownloadProgressNotification object:nil];
    // 状态改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoadStateChange:) name:HWDownloadStateChangeNotification object:nil];
}
-(void)download
{
    HWDownloadModel *downloadModel = self.dataSource[0];
    self.downloadModel = downloadModel;
    // 点击默认、暂停、失败状态，调用开始下载
    [[HWDownloadManager shareManager] startDownloadTask:self.downloadModel];
}
- (void)getInfo
{
    // 模拟网络数据
    NSArray *testData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"testData.plist" ofType:nil]];
    // 转模型
    self.dataSource = [HWDownloadModel mj_objectArrayWithKeyValuesArray:testData];
}
- (void)start:(UIButton *)sender
{
//     [self.clockDiaView refreshDashboard:5];
    
    if ([sender.titleLabel.text isEqualToString:@"开始测速"]) {
        self.wifiImage.hidden = YES;
        self.downLoadButton.hidden = YES;
        [self download];
        [self.tool startMonitor];
        // 5s后自动调用self的ping方法
        [self performSelector:@selector(startPing) withObject:nil afterDelay:10];
        self.downLoadImage.hidden = NO;
        self.downLoadNamelabel.hidden = NO;
        self.downLoadPurplelabel.hidden = NO;
        self.downLoadbottomNumlabel.hidden = NO;
        self.netImageview.hidden = NO;
        self.netdelayNamelabel.hidden = NO;
        [self changeTosmallNet];
        [self showSpeedclockDiaView];
    }else
    {
        self.downLoadButton.hidden = YES;
        [self.leftclockDiaView removeFromSuperview];
        [self.rightclockDiaView removeFromSuperview];
        [self showSpeedclockDiaView];
        [self changeSpeedTobig];
        [self changeTosmallNet];
        [self download];
        [self.tool startMonitor];
        // 5s后自动调用self的ping方法
        [self performSelector:@selector(startPing) withObject:nil afterDelay:10];
    }
}
- (void)startPing
{
    self.downLoadButton.hidden = YES;
    self.netdelayNamelabel.hidden = NO;
    self.netImageview.hidden = NO;
    self.netOrangelabel.hidden = NO;
    self.netbottomNumlabel.hidden = NO;
    // 暂停下载
    [[HWDownloadManager shareManager] pauseDownloadTask:self.downloadModel];
    [self.tool stopMonitor];
    // 然后取平均速度
    CGFloat totalPeed = 0.00;
    for (int i = 0; i <self.speedArray.count; i ++) {
        NSString *speed = self.speedArray[i];
        CGFloat speednum = [speed doubleValue];
        totalPeed += speednum;
    }
    CGFloat avgspeed = totalPeed/self.speedArray.count;
    [self.clockDiaView refreshDashboard:avgspeed];
    self.downLoadbottomNumlabel.text = [NSString stringWithFormat:@"%.2f",avgspeed];
    self.currentAvgSpeed =  avgspeed;

    [self changeSpeedToSmall];
    [self changenetTobig];
    [self showNetclockDiaView];
    // 这里 开始ping
    self.pingServices = [STDPingServices startPingAddress:@"www.baidu.com" callbackHandler:^(STDPingItem *pingItem, NSArray *pingItems) {
        if (pingItem.status != STDPingStatusFinished) {
            //            [weakSelf.textView appendText:pingItem.description];
            NSLog(@"pingItem.description%@",pingItem.description);
//            self.netDelayLabel.text = [NSString stringWithFormat:@"网络延迟%f毫秒",pingItem.timeMilliseconds];
            self.currentDelayTime = pingItem.timeMilliseconds;
            [self.timeArray addObject:[NSString stringWithFormat:@"%.2f",pingItem.timeMilliseconds]];
            [self.netclockDiaView refreshDashboard:pingItem.timeMilliseconds];
            self.netbottomNumlabel.text = [NSString stringWithFormat:@"%.2f",pingItem.timeMilliseconds];
//            self.netDelayNumlabel.text =  [NSString stringWithFormat:@"%.2f",pingItem.timeMilliseconds];
        } else {
            //            [weakSelf.textView appendText:[STDPingItem statisticsWithPingItems:pingItems]];
            //            [button setTitle:@"Ping" forState:UIControlStateNormal];
            //            button.tag = 10001;
            self.pingServices = nil;
            NSLog(@"111pingItem.description%@",pingItem.description);
        }
    }];
    // 10秒后展示测试结果
    [self performSelector:@selector(gotoresult) withObject:nil afterDelay:10];
}
- (void)gotoresult
{
    [self.pingServices cancel];
    self.downLoadButton.hidden = NO;
    [[HWDownloadManager shareManager] deleteTaskAndCache:self.dataSource[0]];
    [self.downLoadButton setTitle:@"重新测速" forState:UIControlStateNormal];
    [self changeToShowresult];
}
- (void)changeToShowresult
{
    // 取平均时间
    CGFloat totalTime = 0.00;
    for (int i = 0; i <self.timeArray.count; i ++) {
        NSString *time = self.timeArray[i];
        CGFloat timenum = [time doubleValue];
        totalTime += timenum;
    }
    CGFloat avgtime = totalTime/self.timeArray.count;
    self.currentAvgnettime = avgtime;
    [self.netclockDiaView refreshDashboard:avgtime];
    self.netbottomNumlabel.text = [NSString stringWithFormat:@"%.2f",avgtime];
    
    CGFloat width = (SCREEN_WIDTH -26 * 3)/2;
    self.clockDiaView.hidden = YES;
//    self.clockDiaView.frame = CGRectMake(26, 100, width, width);
    ClockDialView *leftclockDiaView = [[ClockDialView alloc] initWithFrame:CGRectMake(26, 100, width, width)];
    [self.view addSubview:leftclockDiaView];
    leftclockDiaView.minValue = 0;
    leftclockDiaView.maxValue = 10;
    [leftclockDiaView drawArcWithStartAngle:-M_PI_4*5 endAngle:M_PI_4 lineWidth:3.0f fillColor:[UIColor clearColor] strokeColor:RGBA(255, 255, 255, 0.5) isSpeed:YES];
    //刻度
    [leftclockDiaView drawScaleWithDivide:10 andRemainder:10 strokeColor:RGBA(255, 255, 255, 1) filleColor:[UIColor colorWithHex:0x6A11CB alpha:0.8] scaleLineNormalWidth:10 scaleLineBigWidth:10];
    // 增加刻度值
    [leftclockDiaView DrawScaleValueWithDivide:0];
    [leftclockDiaView refreshDashboard:self.currentAvgSpeed];
    self.leftclockDiaView = leftclockDiaView;
//        self.clockDiaView.minValue = 0;
//        self.clockDiaView.maxValue = 5;
//        [self.clockDiaView drawArcWithStartAngle:-M_PI_4*5 endAngle:M_PI_4 lineWidth:3.0f fillColor:[UIColor clearColor] strokeColor:RGBA(255, 255, 255, 0.5) isSpeed:YES];
//        //刻度
//        [self.clockDiaView drawScaleWithDivide:10 andRemainder:10 strokeColor:RGBA(255, 255, 255, 1) filleColor:[UIColor colorWithHex:0x6A11CB alpha:0.8] scaleLineNormalWidth:10 scaleLineBigWidth:10];
//        // 增加刻度值
//        [self.clockDiaView DrawScaleValueWithDivide:0];
    self.downLoadPurplelabel.hidden = NO;
    self.downLoadPurplelabel.frameX = 26;
    self.downLoadPurplelabel.frameWidth = width;
    self.downLoadbottomNumlabel.hidden = NO;
    self.downLoadbottomNumlabel.frameX = 26;
    self.downLoadbottomNumlabel.frameWidth = width;
    [self changeSpeedTobig];
    
    self.netclockDiaView.hidden = YES;
//    self.netclockDiaView.frame = CGRectMake(width, 100, 50, 50);
    ClockDialView *rightclockDiaView = [[ClockDialView alloc] initWithFrame:CGRectMake(26*2 + width, 100, width, width)];
    [self.view addSubview:rightclockDiaView];
    rightclockDiaView.minValue = 0;
    rightclockDiaView.maxValue = 10;
    [rightclockDiaView drawArcWithStartAngle:-M_PI_4*5 endAngle:M_PI_4 lineWidth:3.0f fillColor:[UIColor clearColor] strokeColor:RGBA(255, 255, 255, 0.5) isSpeed:NO];
    //刻度
    [rightclockDiaView drawScaleWithDivide:10 andRemainder:10 strokeColor:RGBA(255, 255, 255, 1) filleColor:RGBA(247,107,28,0.70) scaleLineNormalWidth:10 scaleLineBigWidth:10];
    // 增加刻度值
    [rightclockDiaView DrawScaleValueWithDivide:0];
//    self.netclockDiaView = [[ClockDialView alloc] initWithFrame:CGRectMake(26*2 + width, 100, width, width)];
    [rightclockDiaView refreshDashboard:self.currentAvgSpeed];
    self.rightclockDiaView = rightclockDiaView;
    self.netOrangelabel.hidden = NO;
    self.netbottomNumlabel.hidden = NO;
    self.netbottomNumlabel.frameX = 26*2 + width;
    self.netbottomNumlabel.frameWidth = width;
    self.netOrangelabel.frameX = 26*2 + width;
    self.netOrangelabel.frameWidth = width;
    [self changenetTobig];
}
-(void)onUpdateNetReceiveSpeed:(unsigned long long)speed{

    dispatch_async(dispatch_get_main_queue(), ^{
//        if(speed <1024) {
//            self.speedString = [NSString stringWithFormat:@"下行速度%lludB/秒", speed];
//            NSLog(@"%@",[NSString stringWithFormat:@"下行速度%lludB/秒", speed]);
//        }else if(speed >=1024 && speed <1024*1024) {
//            self.speedString = [NSString stringWithFormat:@"下行速度%lluKB/秒", speed /1024];
//            NSLog(@"%@",[NSString stringWithFormat:@"下行速度%lluKB/秒", speed /1024]);
//        }else if(speed >= 1024*1024){
        self.speedString = [NSString stringWithFormat:@"下行速度%.2fMB/秒", speed / (1024.00*1024.00)];
//        self.currentAvgSpeed =  speed / (1024.00*1024.00);
        [self.speedArray addObject:[NSString stringWithFormat:@"%.2f",speed / (1024.00*1024.00)]];
            NSLog(@"%@",[NSString stringWithFormat:@"下行速度%lluMB/秒", speed / (1024*1024)]);
////        }
        CGFloat speednum = speed / (1024.00*1024.00);
//        NSLog(@"------------%.2f",[ doubleValue]);
        self.downLoadbottomNumlabel.text = [NSString stringWithFormat:@"%.2f",speed / (1024.00*1024.00)];
//        self.downLoadNumlabel.text = [NSString stringWithFormat:@"%.2f",speed / (1024.00*1024.00)];
        [self.clockDiaView refreshDashboard:speednum];
//        self.downloadLabel.text = [NSString stringWithFormat:@"下载速度%@",self.speedString];
    });
}

- (UIButton *)downLoadButton {
    if (!_downLoadButton) {
        _downLoadButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 168)/2, 338, 168, 50)];
        [_downLoadButton setTitle:@"开始测速" forState:UIControlStateNormal];
        [_downLoadButton setTitleColor:[UIColor colorWithHex:0xC54B5B alpha:1] forState:UIControlStateNormal];
        _downLoadButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _downLoadButton.layer.cornerRadius = 10;
        _downLoadButton.layer.borderWidth = 3;
        _downLoadButton.layer.borderColor = [UIColor colorWithHex:0xC54B5B alpha:1].CGColor;
        [_downLoadButton addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downLoadButton;
}
//- (UILabel *)downloadLabel{
//    if (!_downloadLabel) {
//        _downloadLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 20)];
//        _downloadLabel.textColor = [UIColor whiteColor];
//        _downloadLabel.textAlignment = NSTextAlignmentCenter;
//        _downloadLabel.font = [UIFont systemFontOfSize:16];
////        _downloadLabel.text = @"";
//    }
//    return _downloadLabel;
//}
//- (UILabel *)netDelayLabel{
//    if (!_netDelayLabel) {
//        _netDelayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 500, SCREEN_WIDTH, 20)];
//        _netDelayLabel.textColor = [UIColor whiteColor];
//        _netDelayLabel.font = [UIFont systemFontOfSize:16];
//        _netDelayLabel.textAlignment = NSTextAlignmentCenter;
//    }
//    return _netDelayLabel;
//}

- (UIImageView *)downLoadImage{
    if (!_downLoadImage) {
        _downLoadImage = [[UIImageView alloc] initWithFrame:CGRectMake(52, 29, 18, 18)];
        _downLoadImage.image = [UIImage imageNamed:@"xiazai_ic_hl"];
    }
    
    return _downLoadImage;
}
- (UIImageView *)wifiImage{
    if (!_wifiImage) {
        _wifiImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 120 -18, 100, 18, 18)];
        UIImage *wifiImage = [UIImage imageNamed:@"wifi_ic"];
        _wifiImage.frameSize = wifiImage.size;
        _wifiImage.frameX = (SCREEN_WIDTH - wifiImage.size.width)/2;
        _wifiImage.image = wifiImage;
    }
    
    return _wifiImage;
}
- (UIImageView *)netImageview{
    if (!_netImageview) {
        _netImageview = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 120 -18, 29, 18, 18)];
        _netImageview.image = [UIImage imageNamed:@"yanshi_ic_hl"];
    }
    
    return _netImageview;
}
- (UILabel *)downLoadNamelabel{
    if (_downLoadNamelabel == nil) {
        _downLoadNamelabel = [[UILabel alloc] initWithFrame:CGRectMake(76, 30, 78, 20)];
        _downLoadNamelabel.textColor = [UIColor whiteColor];
        _downLoadNamelabel.font = [UIFont systemFontOfSize:12];
        _downLoadNamelabel.text = @"下载Mbps";
        _downLoadNamelabel.textAlignment = NSTextAlignmentLeft;
    }
    return _downLoadNamelabel;
}
- (UILabel *)netdelayNamelabel{
    if (_netdelayNamelabel == nil) {
        _netdelayNamelabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 115, 30, 100, 20)];
        _netdelayNamelabel.textColor = [UIColor whiteColor];
        _netdelayNamelabel.font = [UIFont systemFontOfSize:12];
        _netdelayNamelabel.text = @"网络延迟ms";
        _netdelayNamelabel.textAlignment = NSTextAlignmentLeft;
    }
    return _netdelayNamelabel;
}
//- (UILabel *)downLoadNumlabel{
//    if (_downLoadNumlabel == nil) {
//        _downLoadNumlabel = [[UILabel alloc] initWithFrame:CGRectMake(52, 50, 100, 30)];
//        _downLoadNumlabel.textColor = [UIColor whiteColor];
//        _downLoadNumlabel.font = [UIFont systemFontOfSize:30];
//        _downLoadNumlabel.text = @"7.6";
//        _downLoadNumlabel.textAlignment = NSTextAlignmentCenter;
//    }
//    return _downLoadNumlabel;
//}
//- (UILabel *)netDelayNumlabel{
//    if (_netDelayNumlabel == nil) {
//        _netDelayNumlabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 120 -18, 50, 100, 30)];
//        _netDelayNumlabel.textColor = [UIColor whiteColor];
//        _netDelayNumlabel.font = [UIFont systemFontOfSize:30];
//        _netDelayNumlabel.text = @"7.6";
//        _netDelayNumlabel.textAlignment = NSTextAlignmentCenter;
//    }
//    return _netDelayNumlabel;
//}
- (UILabel *)downLoadPurplelabel{
    if (_downLoadPurplelabel == nil) {
        _downLoadPurplelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.clockDiaView.YMax - 20, SCREEN_WIDTH, 30)];
        _downLoadPurplelabel.textColor = [UIColor colorWithHex:0x6A11CB alpha:1];
        _downLoadPurplelabel.font = [UIFont systemFontOfSize:14];
        _downLoadPurplelabel.text = @"下载速度";
        _downLoadPurplelabel.textAlignment = NSTextAlignmentCenter;
    }
    return _downLoadPurplelabel;
}
- (UILabel *)downLoadbottomNumlabel{
    if (_downLoadbottomNumlabel == nil) {
        _downLoadbottomNumlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.clockDiaView.YMax - 50, SCREEN_WIDTH, 30)];
        _downLoadbottomNumlabel.textColor = [UIColor whiteColor];
        _downLoadbottomNumlabel.font = [UIFont systemFontOfSize:30];
        _downLoadbottomNumlabel.text = @"......";
        _downLoadbottomNumlabel.textAlignment = NSTextAlignmentCenter;
    }
    return _downLoadbottomNumlabel;
}
- (UILabel *)netOrangelabel{
    if (_netOrangelabel == nil) {
        _netOrangelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.clockDiaView.YMax - 20, SCREEN_WIDTH, 30)];
        _netOrangelabel.textColor = RGBA(247,107,28,0.70);
        _netOrangelabel.font = [UIFont systemFontOfSize:14];
        _netOrangelabel.text = @"网络延迟";
        _netOrangelabel.textAlignment = NSTextAlignmentCenter;
    }
    return _netOrangelabel;
}
- (UILabel *)netbottomNumlabel{
    if (_netbottomNumlabel == nil) {
        _netbottomNumlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.clockDiaView.YMax - 50, SCREEN_WIDTH, 30)];
        _netbottomNumlabel.textColor = [UIColor whiteColor];
        _netbottomNumlabel.font = [UIFont systemFontOfSize:30];
        _netbottomNumlabel.text = @"00:00";
        _netbottomNumlabel.textAlignment = NSTextAlignmentCenter;
    }
    return _netbottomNumlabel;
}
//- (UIButton *)sendButton {
//    if (!_sendButton) {
//        CGFloat margin = (SCREEN_WIDTH - 130* 2)/3;
//        _sendButton = [[UIButton alloc] initWithFrame:CGRectMake(margin * 2 +130, 0, 130, 30)];
//        [_sendButton setTitle:@"在这里提货" forState:UIControlStateNormal];
//        [_sendButton setTitleColor:blackTextColor forState:UIControlStateNormal];
//        _sendButton.titleLabel.font = [UIFont systemFontOfSize:15];
//        _sendButton.layer.cornerRadius = 10;
//        _sendButton.layer.borderWidth = 1;
//        _sendButton.layer.borderColor = [UIColor colorWithHex:0xCCCCCC alpha:1].CGColor;
//        [_sendButton addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _sendButton;
//}
/*

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (ClockDialView *)clockDiaView
{
    if (_clockDiaView == nil) {
        _clockDiaView = [[ClockDialView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200)/2, 100, 200, 200)];
    }
    return _clockDiaView;
}
- (ClockDialView *)netclockDiaView
{
    if (_netclockDiaView == nil) {
        _netclockDiaView = [[ClockDialView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200)/2, 100, 200, 200)];
    }
    return _netclockDiaView;
}
#pragma mark - HWDownloadNotification
// 正在下载，进度回调
- (void)downLoadProgress:(NSNotification *)notification
{
    HWDownloadModel *downloadModel = notification.object;
    
    [self.dataSource enumerateObjectsUsingBlock:^(HWDownloadModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([model.url isEqualToString:downloadModel.url]) {
            // 主线程更新cell进度
            dispatch_async(dispatch_get_main_queue(), ^{
//                HWHomeCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
//                [cell updateViewWithModel:downloadModel];
//                NSLog(@"下载进度%@", [NSString stringWithFormat:@"%@ / s", [HWToolBox stringFromByteCount:model.speed]]);
//                 [NSString stringWithFormat:@"%@ / s", [HWToolBox stringFromByteCount:model.speed]];
//                [self.clockDiaView refreshDashboard:downloadModel.speed];
//                self.downloadLabel.text = [NSString stringWithFormat:@"下载速度%@", [NSString stringWithFormat:@"%@ / s", [HWToolBox stringFromByteCount:model.speed]]];
//                CGFloat speednum = model.speed / (1024.00*1024.00);
//                //        NSLog(@"------------%.2f",[ doubleValue]);
//                [self.clockDiaView refreshDashboard:speednum];
//                self.downloadLabel.text = [NSString stringWithFormat:@"下载速度%@", [NSString stringWithFormat:@"%@ / s", [HWToolBox stringFromByteCount:model.speed]]];
            });
            
            *stop = YES;
        }
    }];
}

// 状态改变
- (void)downLoadStateChange:(NSNotification *)notification
{
//    HWDownloadModel *downloadModel = notification.object;
    
//    [self.dataSource enumerateObjectsUsingBlock:^(HWDownloadModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([model.url isEqualToString:downloadModel.url]) {
//            // 更新数据源
//            self.dataSource[idx] = downloadModel;
//
//            // 主线程刷新cell
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//            });
//
//            *stop = YES;
//        }
//    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
