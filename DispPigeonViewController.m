//
//  DispPigeonViewController.m
//  pigeon
//
//  Created by 遠藤 豪 on 13/09/19.
//  Copyright (c) 2013年 endo.tuyo. All rights reserved.
//

#import "DispPigeonViewController.h"
#import "PetClass.h"

@interface DispPigeonViewController ()

@end

CGRect rect_main;
UIImageView *iv_main = NULL;
NSMutableArray *iv_subAr = nil;//[NSMutableArray array];=>ここでは初期化できない
NSTimer *tm = nil;
float count = 0;//0.1秒おきのカウンター
int icon_Xinterval = 30;//アイコン横感覚
int icon_Yinterval = 10;//アイコン縦感覚
int bt_size = 25;//アイコンの大きさ
int bt_left = 25;//アイコンの左位置
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
    int main_width = 200;
    int main_height = 200;
    int main_left = [[UIScreen mainScreen] bounds].size.width/2-main_width/2;//画面サイズに対して中央になるように左位置特定
    int main_top = 50;
    //メイン画面の大きさの決定
    rect_main = CGRectMake(main_left, main_top, main_width, main_height);//左上座標、幅、高さ
    iv_main = [[UIImageView alloc]initWithFrame:rect_main];
    iv_main.userInteractionEnabled = YES;
    
    [self ordinaryAnimationStart];
    
    
    /**
      *ペットクラスのテスト
    NSLog(@"start init");
    PetClass *pc = [[PetClass alloc]init];
    
    NSLog(@"add image");
    [pc setPetImage:[NSString stringWithFormat:@"aaa.png"]];
    NSLog(@"count = %d", [pc getPetImageSum]);
    for(int i = 0; i < [pc getPetImageSum]; i++){
        NSLog(@"i = %d, image = %@", i, [pc getPetImage:i]);
    }
    
    NSLog(@"add image");
    [pc setPetImage:[NSString stringWithFormat:@"bbb.png"]];
    NSLog(@"count = %d", [pc getPetImageSum]);
    for(int i = 0; i < [pc getPetImageSum]; i++){
        NSLog(@"i = %d, image = %@", i, [pc getPetImage:i]);
    }
    
    NSLog(@"finish init");
    */

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
    
    
//    iv_main.image = [UIImage imageNamed:@"pengin___.jpg"];
//    [self.view addSubview:iv_main];
    
    //個別指定の場合
//    UIImage *im1 = [UIImage imageNamed:@"origin_small4_384.png"];
//    UIImage *im2 = [UIImage imageNamed:@"delight_small4_384.png"];=>触ったときの反応：作る必要
//    UIImage *im2 = [UIImage imageNamed:@"origin_small4_motion_384.png"];
//    switch case でペットのレベルに応じて画像を変える(引数は配列指定)
//    NSMutableArray *imageList = [NSArray arrayWithObjects:im1, im2, nil];
    NSMutableArray *imageList = [NSMutableArray array];
    for (NSInteger i = 1; i < 5; i++) {
//        NSLog(@"f%01d.png", i);
        NSString *imagePath = [NSString stringWithFormat:@"f%01d.png", i];
        UIImage *img = [UIImage imageNamed:imagePath];
        [imageList addObject:img];
    }
    
    iv_main.animationImages = imageList;
    iv_main.animationDuration = 2.5;
    iv_main.animationRepeatCount = 0;
    
    
    
    //ジェスチャーレコナイザーを付与して、タップイベントに備える
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(onTappedMainImage:)];
    [iv_main addGestureRecognizer:tap];
    
    //ビューにメインイメージを貼り付ける
    [self.view addSubview:iv_main];
    
    [iv_main startAnimating];
    
    //メイン部分終了
    
    
    //サブメイン(ボタン押下時に表示される部分)
    CGRect rect_sub = CGRectMake(0, 250, 320, 100);//左上座標、幅、高さ
    UIImageView *iv_sub = [[UIImageView alloc]initWithFrame:rect_sub];
    iv_sub = [[UIImageView alloc]initWithFrame:rect_sub];
    iv_sub.image = [UIImage imageNamed:@"frame_paste.png"];
    [self.view addSubview:iv_sub];
    
    
    //サブメイン終了
    
    
    //下段ボタン開始(アイコン：http://www.wpzoom.com/wpzoom/new-freebie-wpzoom-developer-icon-set-154-free-icons/)
    CGRect rect_bt;
    int bt_top = 350;
    UIImageView *iv_bt = nil;
    NSArray *bt_name = [NSArray arrayWithObjects:
                    @"man.png",
                    @"home.png",
                    @"fight.png",
                    @"tools.png",
                    nil];
    for (int bt_no = 0;bt_no < 4;bt_no++){
        //位置とサイズの決定
        rect_bt = CGRectMake(bt_left + bt_no * (bt_size + icon_Xinterval),
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

//メインイメージをタップした時に起動
- (void)onTappedMainImage:(UITapGestureRecognizer*)gr{
    
    //タップされた位置座標を取得する(左上端からの座標値を取得)
    CGPoint location = [gr locationInView:iv_main];
    NSLog(@"tapped main image@[ x = %f, y = %f]", location.x , location.y);
    
    
}


//サブメニューをタップした時に起動
- (void)onTappedSubMenu:(UITapGestureRecognizer*)gr{
    //http://lepetit-prince.net/ios/?p=1822
    
    NSLog(@"tapped sub image");
    
//    [iv_main stopAnimating];
    [iv_main removeFromSuperview];//メイン画面を一時的に非表示
    count = 0;
    tm = [NSTimer scheduledTimerWithTimeInterval:0.1
                                          target:self
                                        selector:@selector(time:)//タイマー呼び出し
                                        userInfo:nil
                                         repeats:YES];
    
    //メイン画面と同じ大きさで別のアニメーションを実施(食べる仕草、運動する仕草等)
//    UIImageView *iv = [[UIImageView alloc]initWithFrame:rect_main];
    iv_main.image = [UIImage imageNamed:@"slime2_3.png"];
    UIImage *im3 = [UIImage imageNamed:@"slime2_3.png"];
    UIImage *im4 = [UIImage imageNamed:@"slime2_jumpPre.png"];
    UIImage *im5 =[UIImage imageNamed:@"slime2_jump.png"];
    UIImage *im6 = [UIImage imageNamed:@"slime2_jumpPre.png"];
    
    
    //switch case でペットのレベルに応じて画像を変える(引数は配列指定)
    NSArray *imageList = [NSArray arrayWithObjects:im3, im4, im5, im6, nil];
    iv_main.animationImages = imageList;
    iv_main.animationDuration = 2.5;//1.5秒間アニメーションを実施
    iv_main.animationRepeatCount = 5;
    [self.view addSubview:iv_main];
    
    
    
    //ジェスチャーレコナイザーを付与して、タップイベントに備える
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(onTappedMainImage:)];
    [iv_main addGestureRecognizer:tap];
    
    
    [iv_main startAnimating];//アクションアニメーション開始
    
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
        int icon_sub_no = 0;
        int max_icon_no = 5;
        iv_subAr = [NSMutableArray array];//初期化
        for(int y_no = 0; y_no < 2 && [iconAr count] > icon_sub_no;y_no++){
            for (int x_no = 0; x_no < max_icon_no && [iconAr count] > icon_sub_no; x_no++){
                //一行のアイコン個数が最大配置個数(=max_icon_no)以下もしくはアイコンの格納数まで。
//                NSLog(@"x = %d, y = %d", x_no, y_no);
                CGRect rect_subXY = CGRectMake(
                                               bt_left + x_no * (bt_size + icon_Xinterval),
                                               275 + y_no * (bt_size + icon_Yinterval),
                                               bt_size,
                                               bt_size);
//                UIImageView *iv_subXY = [[UIImageView alloc]initWithFrame:rect_subXY];
                [iv_subAr addObject:[[UIImageView alloc]initWithFrame:rect_subXY]];
                
                ((UIImageView *)[iv_subAr objectAtIndex:icon_sub_no]).image = [UIImage imageNamed:[iconAr objectAtIndex:icon_sub_no]];
                
                ((UIImageView *)[iv_subAr objectAtIndex:icon_sub_no]).userInteractionEnabled = YES;
                ((UIImageView *)[iv_subAr objectAtIndex:icon_sub_no]).tag =
                    x_no + y_no;//[iconAr objectAtIndex:icon_sub_no];=>tagは整数型のみ取り得るので工夫して一意的な数値にする必要あり。。？
                
                //ジェスチャーレコナイザーを付与して、タップイベントに備える
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
//    NSLog(@"time:%f", count);
    //タイマーが有効かどうか
//    NSString *str = [tm isValid] ? @"yes" : @"no";
//    NSLog(@"isValid:%@", str);
    
    
    //アクションアニメーションへの終了
    if(count >=10.0){
        //３秒経過したらタイマー終了
        [tm invalidate];
        
        //メイン画面の別アニメーション停止
        
        
        //        for(int i = 0; i < [iv_subAr count];i++){
        //            [[iv_subAr objectAtIndex:i] removeFromSuperview];
        //        }
        
        
        //通常アニメーション再実行
        [self ordinaryAnimationStart];
    }
}


@end