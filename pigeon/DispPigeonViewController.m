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
    
    
    // 生成例
    //    UIImageView *iv = [[UIImageView alloc] init];
    
    // UIImageを指定した生成例
    //    UIImage *image = [UIImage imageNamed:@"sample.jpg"];
    //    UIImageView *iv = [[UIImageView alloc] initWithImage:image];
    //    [self.view addSubview:iv];
    
    
    // 画像サイズを指定して表示
    //    CGRect rect = CGRectMake(10, 10, 300, 400);
    //    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    //    imageView.image = [UIImage imageNamed:@"sample.jpg"];
    //    [self.view addSubview:imageView];// UIImageViewのインスタンスをビューに追加
    
    //複数画像のアニメーション例
    CGRect rect = CGRectMake(10, 50, 300, 300);
    UIImageView *iv = [[UIImageView alloc]initWithFrame:rect];
    iv.image = [UIImage imageNamed:@"sample1.jpg"];
    //    UIImageView *iv = [[UIImageView alloc] init];
    [self.view addSubview:iv];
    
    UIImage *im1 = [UIImage imageNamed:@"sample1.jpg"];
    UIImage *im2 = [UIImage imageNamed:@"sample2.png"];
    //    UIImageView *iv = [[UIImageView alloc] initWithImage:im1];
    
    //    UIImage *im3 = [UIImage imageNamed:@"sample2.jpg"];
    NSArray *ims = [NSArray arrayWithObjects:im1, im2, nil];
    iv.animationImages = ims;
    iv.animationDuration = 1.5;
    [self.view addSubview:iv];
    
    [iv startAnimating];
    //    for(int i = 0;i < 100000;i++){
    //        NSLog(@"%d", i);
    //    }
    //    [iv stopAnimating];
    
    
    //    UIImage *hand_img = [UIImage imageNamed: @"sample.jpg"];
    //    UIImageView *hand_iv = [[UIImageView alloc] initWithImage: hand_img];
    //    hand_iv.frame = CGRectMake(46, 5, 229, 342);
    //    [self.view addSubview:hand_iv];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)myOnClickCloseButton:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
}
@end
