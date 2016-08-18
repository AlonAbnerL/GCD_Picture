//
//  ViewController.m
//  GCD_Picture_One
//
//  Created by KangMei_Mac on 16/8/18.
//  Copyright © 2016年 AronAbnerL. All rights reserved.
//

#import "ViewController.h"

#define NumberofPicture 9 //图片加载数目
#define PictureHeight 70 //图片高度
#define PictureWidth 70  //图片宽度
#define PerLineNumber 3 //每行图片数目

@interface ViewController ()
{
    UIImageView *pictureImageView;
    UIButton *btn;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    btn = UIButton.new;
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(50);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(150));
        make.height.equalTo(@(50));
    }];
    //    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(addPicture:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"异步图片加载" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.layer.borderWidth = 1;
    btn.titleLabel.textColor = [UIColor blueColor];
}
-(void) addPicture:(id *)btn{
    
    for (NSInteger i = 0; i< NumberofPicture; i++) {
        UIImageView *image = UIImageView.new;
        [self.view addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).with.offset((i/PerLineNumber)*(PictureHeight+20 )+100);
            make.left.equalTo(self.view.mas_left).with.offset((i%PerLineNumber)*((self.view.frame.size.width-20*2-PictureWidth*PerLineNumber)/2 + PictureWidth)+20);
            make.width.equalTo(@(PictureWidth));
            make.height.equalTo(@(PictureHeight));
        }];
        image.backgroundColor = [UIColor blackColor];
        
        //不做处理
        //        NSString *iconURL = @"http://img.km1818.com/b2c/userImg/436467.png?i=1471492121835";//
        //        NSURL *imageUrl = [NSURL URLWithString:iconURL];
        //        UIImage *iconImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
        //        image.image = iconImage;
        
        
        //异步非同时加载  多次点击会引起奔溃
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            NSString *iconURL = @"http://img.km1818.com/b2c/userImg/436467.png?i=1471492121835";
            NSURL *imageUrl = [NSURL URLWithString:iconURL];
            UIImage *iconImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                image.image = iconImage;
                
            });
            
        });
        
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
