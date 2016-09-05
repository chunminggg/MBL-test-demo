//
//  methodCell.m
//  MBL_CoreData
//
//  Created by neo-mac on 16/7/28.
//  Copyright © 2016年 neo-mac. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "methodCell.h"
#import <UIView+SDAutoLayout.h>
#import "KxMenu.h"

@interface methodCell()
{
    BOOL flag;
    UIImageView*_imageView;
    
}
@end
@implementation methodCell
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self initMethodTableView];
    }
    return self;
    
}
-(void)initMethodTableView{
    flag=YES;

    UIView*expMethod=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
//    expMethod.backgroundColor=[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1  ];
    expMethod.backgroundColor=[UIColor whiteColor];
    UIView*line=[[UIView alloc]init];
    line.backgroundColor=[UIColor blueColor];
    [self addSubview:expMethod];
    UILabel*expMethodLabel=[[UILabel alloc]init];
    expMethodLabel.textColor=[UIColor blackColor];
    expMethodLabel.text=@"实验方法";
    _imageView=[[UIImageView alloc]init];
    _imageView.image=[UIImage imageNamed:@"n_icon_1"];
    UIButton*actionButton=[UIButton buttonWithType:UIButtonTypeCustom];
    actionButton.imageView.contentMode=UIViewContentModeScaleAspectFill;
    [actionButton setBackgroundImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];    actionButton.backgroundColor=[UIColor clearColor];
    actionButton.tag=999;
    [expMethod addSubview:expMethodLabel];
    [expMethod addSubview:actionButton];
    [expMethod addSubview:line];
    [expMethod addSubview:_imageView];

    [actionButton addTarget:self  action:@selector(addItems:) forControlEvents:UIControlEventTouchUpInside];
    _imageView.sd_layout.leftSpaceToView(expMethod,20).widthIs(30).heightIs(30).centerYEqualToView(expMethod);
    expMethodLabel.sd_layout.leftSpaceToView(expMethod,50).widthIs(80).heightIs(30).centerYEqualToView(expMethod);
    expMethodLabel.sd_layout.leftSpaceToView(expMethod,3).widthIs(80).heightIs(30).centerYEqualToView(expMethod);
    actionButton.sd_layout.leftSpaceToView(expMethodLabel,10).widthIs(30).heightIs(30).centerYEqualToView(expMethod);
    line.sd_layout.bottomSpaceToView(expMethod,0).widthIs(SCREEN_WIDTH).heightIs(1);
  self.methodTextView=[[BRPlaceholderTextView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH , SCREEN_WIDTH/4)];
    self.methodTextView.placeholder=@"请输入实验方法";
    _methodTextView.font=[UIFont boldSystemFontOfSize:14];
    _methodTextView.layer.borderColor=[UIColor blackColor].CGColor;
    [self addSubview:self.methodTextView];
    [_methodTextView setPlaceholderColor:[UIColor redColor]];
    [_methodTextView setPlaceholderOpacity:0.6];
    [_methodTextView addMaxTextLengthWithMaxLength:300 andEvent:^(BRPlaceholderTextView *text) {
        
        NSLog(@"----------");
    }];
    [_methodTextView addTextViewBeginEvent:^(BRPlaceholderTextView *text) {
        NSLog(@"begin");
    }];
    
    
}
+ (UIImageView *)rotate360DegreeWithImageView:(UIImageView *)imageView{
    CABasicAnimation *animation = [ CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D:
                         
                         CATransform3DMakeRotation(M_PI, 0.0, 0.0, 1.0) ];
    animation.duration = 0.5;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = 1000;
    
    //在图片边缘添加一个像素的透明区域，去图片锯齿
    CGRect imageRrect = CGRectMake(0, 0,imageView.frame.size.width, imageView.frame.size.height);
    UIGraphicsBeginImageContext(imageRrect.size);
    [imageView.image drawInRect:CGRectMake(1,1,imageView.frame.size.width-2,imageView.frame.size.height-2)];
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [imageView.layer addAnimation:animation forKey:nil];
    return imageView;
}

-(void)addItems:(UIButton*)sender{
    [self.methodDelegate removeMethodViewFromSuperView];
//    [methodCell rotate360DegreeWithImageView:sender.imageView];
//    [sender setBackgroundImage:[UIImage imageNamed:@"arrowUP.png"] forState:UIControlStateNormal];
    if (flag) {
        [UIView animateWithDuration:0.5 animations:^{
            sender.transform= CGAffineTransformMakeRotation(M_PI);
        } completion:^(BOOL finished) {
            flag=NO;
        }];
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            sender.transform = CGAffineTransformMakeRotation(0);

        } completion:^(BOOL finished) {
            flag = YES;

        }];
    }
}

@end
