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

UIImageView *iv1 = NULL;
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

- (IBAction)onClickCareButton:(id)sender {
    //おせわボタン押下時->一定時間、別のアニメーションを設定
    
//    [iv1 stopAnimating];
    
    NSLog(@"onClickCareButton");
    
    count = 0;
    tm = [NSTimer scheduledTimerWithTimeInterval:0.1
                                          target:self
                                        selector:@selector(time:)
                                        userInfo:nil
                                         repeats:YES];

    
    CGRect rect = CGRectMake(10, 50, 200, 200);//左上座標、幅、高さ
    UIImageView *iv = [[UIImageView alloc]initWithFrame:rect];
    iv.image = [UIImage imageNamed:@"sample3.jpg"];
    [self.view addSubview:iv];
    
    UIImage *im3 = [UIImage imageNamed:@"sample3.jpg"];
    UIImage *im4 = [UIImage imageNamed:@"sample4.jpg"];
    
    NSArray *ims = [NSArray arrayWithObjects:im3, im4, nil];
    iv.animationImages = ims;
    iv.animationDuration = 1.5;
    iv.animationRepeatCount = 2;
    [self.view addSubview:iv];
    
    [iv startAnimating];
    
    NSLog(@"onClickCare Exit");
    
    
    
}


- (IBAction)onClickRoomButton:(id)sender {
    //
}


- (void)ordinaryAnimationStart{
    //複数画像のアニメーション例
    CGRect rect = CGRectMake(10, 50, 200, 200);//左上座標、幅、高さ
    iv1 = [[UIImageView alloc]initWithFrame:rect];
    iv1.image = [UIImage imageNamed:@"sample1.jpg"];
    [self.view addSubview:iv1];
    
    UIImage *im1 = [UIImage imageNamed:@"sample1.jpg"];
    UIImage *im2 = [UIImage imageNamed:@"sample2.png"];
    
    NSArray *ims = [NSArray arrayWithObjects:im1, im2, nil];
    iv1.animationImages = ims;
    iv1.animationDuration = 1.5;
    [self.view addSubview:iv1];
    
    [iv1 startAnimating];
    
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

@end