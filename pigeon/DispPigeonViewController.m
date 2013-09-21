//
//  DispPigeonViewController.m
//  pigeon
//
//  Created by 遠藤 豪 on 13/09/19.
//  Copyright (c) 2013年 endo.tuyo. All rights reserved.
//

#import "DispPigeonViewController.h"

@interface DispPigeonViewController ()

@end

UIImageView *iv_main = NULL;
NSTimer *tm = nil;
float count = 0;

@implementation DispPigeonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self ordinaryAnimationStart];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)myOnClickCloseButton:(id)sender {
    //画面を閉じる
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
}


- (void)ordinaryAnimationStart{
    //メイン部分
    //サイズ参考：http://ameblo.jp/sakurabishi/entry-11447586307.html
    int main_width = 200;
    int main_height = 200;
    int main_left = [[UIScreen mainScreen] bounds].size.width/2-main_width/2;//画面サイズに対して中央になるように左位置特定
    int main_top = 50;
    CGRect rect_main = CGRectMake(main_left, main_top, main_width, main_height);//左上座標、幅、高さ
    iv_main = [[UIImageView alloc]initWithFrame:rect_main];
    iv_main.image = [UIImage imageNamed:@"pengin.jpg"];
    [self.view addSubview:iv_main];
    
    UIImage *im1 = [UIImage imageNamed:@"origin_small4_384.png"];
    UIImage *im2 = [UIImage imageNamed:@"delight_small4_384.png"];
    
    NSArray *ims = [NSArray arrayWithObjects:im1, im2, nil];
    iv_main.animationImages = ims;
    iv_main.animationDuration = 1.5;
    iv_main.animationRepeatCount = 0;
    [self.view addSubview:iv_main];
    
    [iv_main startAnimating];
    
    //メイン部分終了
    
    
    //サブメイン(ボタン押下時に表示される部分)
    CGRect rect_sub = CGRectMake(10, 270, 300, 100);//左上座標、幅、高さ
    UIImageView *iv_sub = [[UIImageView alloc]initWithFrame:rect_sub];
    iv_sub = [[UIImageView alloc]initWithFrame:rect_sub];
    iv_sub.image = [UIImage imageNamed:@"sample2.jpg"];
    [self.view addSubview:iv_sub];
    
    
    //サブメイン終了
    
    
    //下段ボタン開始(アイコン：http://freeicon.blog.shinobi.jp/psd-vector%20%E3%83%87%E3%83%BC%E3%82%BF/%E5%95%86%E7%94%A8%E7%84%A1%E6%96%99%E3%81%AE%E3%83%A2%E3%83%8E%E3%82%AF%E3%83%AD%E3%82%A2%E3%82%A4%E3%82%B3%E3%83%B3%E3%80%8Cwpzoom%20developer%20icon%20set%E3%80%8D)
    CGRect rect_bt;
    int bt_size = 35;
    int bt_left = 10;
    int bt_top = 400;
    UIImageView *iv_bt = nil;
    NSArray *bt_name = [NSArray arrayWithObjects:
                    @"icon_smile2.png",
                    @"home3.png",
                    @"icon_fight2.png",
                    @"icon_tool.png",
                    nil];
    for (int bt_no = 0;bt_no < 4;bt_no++){
        //位置とサイズの決定
        rect_bt = CGRectMake(bt_left + bt_no * bt_size,
                             bt_top,
                             bt_size,
                             bt_size);
//        NSLog(@"no = %d, x = %d, y = %d",bt_no, bt_left + bt_no * bt_size, bt_top);
        iv_bt = [[UIImageView alloc]initWithFrame:rect_bt];
        iv_bt.image = [UIImage imageNamed:[bt_name objectAtIndex:bt_no]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(onTappedIcon:)];
        [iv_bt addGestureRecognizer:tap];
        iv_bt.userInteractionEnabled = YES;
        [self.view addSubview:iv_bt];
    }
    
    
    //下段ボタン終了
    
    
    NSLog(@"startAnimating");
}

- (void)time:(NSTimer*)timer{
    count += 0.1;
    NSLog(@"time:%f", count);
    //タイマーが有効かどうか
    NSString *str = [tm isValid] ? @"yes" : @"no";
    
    NSLog(@"isValid:%@", str);
    
    
    //アクションアニメーションへの終了
    if(count >=3.0){
        //３秒経過したらタイマー終了
        [tm invalidate];
        //終了したら通常アニメーション実行
        [self ordinaryAnimationStart];
    }
}

//サブメニューをタップした時に起動
- (void)onTappedSubMenu:(UITapGestureRecognizer*)gr{
    //http://lepetit-prince.net/ios/?p=1822
    
    NSLog(@"tapped sub image");
    
    [iv_main stopAnimating];
    count = 0;
    tm = [NSTimer scheduledTimerWithTimeInterval:0.1
                                          target:self
                                        selector:@selector(time:)//タイマー呼び出し
                                        userInfo:nil
                                         repeats:YES];
    
    
    CGRect rect = CGRectMake(10, 50, 300, 200);//左上座標、幅、高さ
    UIImageView *iv = [[UIImageView alloc]initWithFrame:rect];
    iv.image = [UIImage imageNamed:@"sample3.jpg"];
    [self.view addSubview:iv];
    
    UIImage *im3 = [UIImage imageNamed:@"sample3.jpg"];
    UIImage *im4 = [UIImage imageNamed:@"sample4.jpg"];
    
    NSArray *ims = [NSArray arrayWithObjects:im3, im4, nil];
    iv.animationImages = ims;
    iv.animationDuration = 1.5;//1.5秒間アニメーションを実施
    iv.animationRepeatCount = 5;
    [self.view addSubview:iv];
    
    [iv startAnimating];//アクションアニメーション開始
    
    //    NSLog(@"onClickCare Exit");
    
    
}

//- (IBAction)onClickCareButton:(id)sender {
- (void)onTappedIcon:(UITapGestureRecognizer*)gr{
    //おせわボタン押下時->一定時間、別のアニメーションを設定
    NSLog(@"onTappedIcon");
    
    //サブメインの(x_no,y_no)要素
    int wid_sub = 50;
    int hei_sub = 50;
    for(int y_no = 0; y_no < 2;y_no++){
        for (int x_no = 0; x_no < 6; x_no++){
            NSLog(@"x = %d, y = %d", x_no, y_no);
            CGRect rect_subXY = CGRectMake(
                                           10 + x_no * wid_sub + 10,
                                           275 + y_no * hei_sub + 10,
                                           wid_sub,
                                           hei_sub);
            UIImageView *iv_subXY = [[UIImageView alloc]initWithFrame:rect_subXY];
            iv_subXY.image = [UIImage imageNamed:@"sample4.jpg"];
            iv_subXY.userInteractionEnabled = YES;
            [self.view addSubview:iv_subXY];
            iv_subXY.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTappedSubMenu:)];
            [iv_subXY addGestureRecognizer:tap];
        }
    }
    //サブメイン終了
    
}
@end