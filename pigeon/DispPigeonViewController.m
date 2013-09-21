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
NSMutableArray *iv_subAr = nil;//[NSMutableArray array];=>ここでは初期化できない
NSTimer *tm = nil;
float count = 0;//0.1秒おきのカウンター
int icon_interval = 30;
Boolean isSubMainDisplayed = false;


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
    
    //initializing parameter
    iv_subAr = [NSMutableArray array];
    
    
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
    iv_main.image = [UIImage imageNamed:@"pengin___.jpg"];
    [self.view addSubview:iv_main];
    
    UIImage *im1 = [UIImage imageNamed:@"origin_small4_384___.png"];
    UIImage *im2 = [UIImage imageNamed:@"delight_small4_384____.png"];
    
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
//    iv_sub.image = [UIImage imageNamed:@"sample2.jpg"];
    [self.view addSubview:iv_sub];
    
    
    //サブメイン終了
    
    
    //下段ボタン開始(アイコン：http://www.wpzoom.com/wpzoom/new-freebie-wpzoom-developer-icon-set-154-free-icons/)
    CGRect rect_bt;
    int bt_size = 35;
    int bt_left = 10;
    int bt_top = 400;
    UIImageView *iv_bt = nil;
    NSArray *bt_name = [NSArray arrayWithObjects:
                    @"man.png",
                    @"home.png",
                    @"fight.png",
                    @"tools.png",
                    nil];
    for (int bt_no = 0;bt_no < 4;bt_no++){
        //位置とサイズの決定
        rect_bt = CGRectMake(bt_left + bt_no * (bt_size + icon_interval),
                             bt_top,
                             bt_size,
                             bt_size);
//        NSLog(@"no = %d, x = %d, y = %d",bt_no, bt_left + bt_no * bt_size, bt_top);
        iv_bt = [[UIImageView alloc]initWithFrame:rect_bt];
        iv_bt.image = [UIImage imageNamed:[bt_name objectAtIndex:bt_no]];
        iv_bt.tag = bt_no;//タップされた時に判別できるように番号付けしておく
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(onTappedIcon:)];
        [iv_bt addGestureRecognizer:tap];
        iv_bt.userInteractionEnabled = YES;
        [self.view addSubview:iv_bt];
    }
    
    
    //下段ボタン終了
    
    
    NSLog(@"startAnimating");
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
    if (isSubMainDisplayed){//既に表示されている場合は削除する
        NSLog(@"icon removeFromSuperview");
        for (int i = 0; i < [iv_subAr count]; i++){
            //https://github.com/DeveloperForceJapan/SalesforceMobileSDK-iOS-JpSample/blob/master/StoreOrders/OrderViewController.m
            [[iv_subAr objectAtIndex:i] removeFromSuperview];//各種アイコンの削除(非表示)
        }
        isSubMainDisplayed = false;
    }else{
        
        //おせわボタン押下時->一定時間、別のアニメーションを設定
        NSLog(@"onTappedIcon");
        
        NSLog(@"%d",[(UIGestureRecognizer *)gr view].tag);//タップされたビューの番号
        
        //表示するアイコンの名称設定
        NSArray *iconAr = nil;//[[NSMutableArray alloc]init];
        switch([(UIGestureRecognizer *)gr view].tag){
            case 0://おせわボタンが選択された時
                iconAr = [[NSArray alloc] initWithObjects:@"restaurant.png",
                          @"joystick.png",
                          @"tree.png",
                          @"pencil.png",
                          @"first-aid-kit.png",
                          @"bath.png",
                          @"sleep.png", nil];
                break;
                
            case 1://ホームボタンが押された時
                iconAr = [[NSArray alloc] initWithObjects:@"bag.png",
                          @"heart.png",
                          @"",
                          @"",
                          nil];
                break;
                
            case 2:
                iconAr = [[NSArray alloc] initWithObjects:@"soccer.png",
                          @"baseball.png",
                          @"basket.png",
                          @"tennis",
                          @"",
                          @"",
                          nil];
                
                break;
                
            case 3:
                
                break;
            
            case 4:
                
                break;
            case 5:
                
                break;
            default://
                
                break;
        }
        
        
        
        //サブメインの(x_no,y_no)要素：アイコンの実装(表示)
        int wid_sub = 30;
        int hei_sub = 25;
        int icon_sub_no = 0;
        int max_icon_no = 5;
        iv_subAr = [NSMutableArray array];//初期化
        for(int y_no = 0; y_no < 2 && [iconAr count] > icon_sub_no;y_no++){
            for (int x_no = 0; x_no < max_icon_no && [iconAr count] > icon_sub_no; x_no++){
                //一行のアイコン個数が最大配置個数(=max_icon_no)以下もしくはアイコンの格納数まで。
//                NSLog(@"x = %d, y = %d", x_no, y_no);
                CGRect rect_subXY = CGRectMake(
                                               10 + x_no * (wid_sub + icon_interval),
                                               275 + y_no * (hei_sub + icon_interval),
                                               wid_sub,
                                               hei_sub);
//                UIImageView *iv_subXY = [[UIImageView alloc]initWithFrame:rect_subXY];
                [iv_subAr addObject:[[UIImageView alloc]initWithFrame:rect_subXY]];
                
                ((UIImageView *)[iv_subAr objectAtIndex:icon_sub_no]).image = [UIImage imageNamed:[iconAr objectAtIndex:icon_sub_no]];
                
                ((UIImageView *)[iv_subAr objectAtIndex:icon_sub_no]).userInteractionEnabled = YES;
                
                
                UITapGestureRecognizer *tap =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(onTappedSubMenu:)];
                [[iv_subAr objectAtIndex:icon_sub_no] addGestureRecognizer:tap];
                [self.view addSubview:[iv_subAr objectAtIndex:icon_sub_no]];//親ビューに貼付ける

                icon_sub_no ++;
                
            }
        }
        //サブメイン表示フラグを立てる
        isSubMainDisplayed = true;
        //サブメイン終了
    }
    
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