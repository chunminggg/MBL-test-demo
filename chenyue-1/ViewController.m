//
//  ViewController.m
//  chenyue-1
//
//  Created by neo-mac on 16/3/18.
//  Copyright © 2016年 neo-mac. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "LQQMonitorKeyboard.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
static NSString *reuseIdentifier = @"cell";
@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *imageArray;
@property(nonatomic,strong)UIScrollView*collectView;
@property(nonatomic,strong)UITextField*text;
@property(nonatomic,strong)UIButton*clickedButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        
    
    [self createUI];
}
-(void)createUI{
    
    self.navigationItem.title=@"交易支付";
    self.navigationController.navigationBar.barTintColor=[UIColor orangeColor];

    __weak typeof(self)weakSelf=self;
    //交易对象
    UILabel*titleLabel1=[[UILabel alloc]initWithFrame:CGRectMake(10, 75, 80, 30)];
    titleLabel1.text=@"交易对象";
    titleLabel1.textColor=[UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1];
    titleLabel1.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:titleLabel1];
    [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.top.offset(70);
        make.left.offset(15);
    }];
    //头像
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(150, 75, 60, 60)];
    imageView.image=[UIImage imageNamed:@"1.jpg"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.left.equalTo(titleLabel1).with.offset(80);
        make.top.offset(70);
    }];
    //名字  以及职称
    UILabel*nameLabel=[[UILabel alloc]init];
    nameLabel.text=@"醋溜蛋";
    nameLabel.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.left.equalTo(imageView).with.offset(70);
        make.top.offset(65);
    }];
    UILabel*jobLabel=[[UILabel alloc]init];
    jobLabel.text=@"/美食管家/";
    jobLabel.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:jobLabel];
    [jobLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.top.equalTo(nameLabel).with.offset(30);
          make.left.equalTo(imageView).with.offset(70);
        
    }];
    //交易场景
    UILabel*sceneLabel=[[UILabel alloc]init];
    sceneLabel.textColor=[UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1];
    sceneLabel.text=@"请选择交易的场景";
    [self.view addSubview:sceneLabel];
    [sceneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 30));
        make.left.offset(10);
        make.top.equalTo(imageView).with.offset(75);
        
    }];
    self.collectView=[[UIScrollView alloc]init];
    _collectView.alwaysBounceHorizontal=NO;
    _collectView.showsHorizontalScrollIndicator=NO;
    _collectView.layer.borderWidth=0.5;
    _collectView.contentSize=CGSizeMake(2*WIDTH-100, 120);
    _collectView.layer.borderColor=[[UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1]CGColor];
    [self.view addSubview:_collectView];
    [_collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(WIDTH+10, 120));
        make.top.equalTo(sceneLabel).with.offset(40);
        
    }];
//    self.collectionView=[[UICollectionView alloc]init];
    //初始化轮播图片来源
    self.imageArray=[[NSMutableArray alloc]initWithObjects:@"beauty1.png", @"beauty2.png",@"beauty3.png",@"beauty4.png",nil];
    for (int i=0; i<4; i++) {
        UIButton*button=[[UIButton alloc]initWithFrame:CGRectMake(10+ 100*i, 20, 75, 75)];
        [button setBackgroundImage:[UIImage imageNamed:self.imageArray[i]] forState:UIControlStateNormal];
        [_collectView addSubview:button];
        [button addTarget: self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=60+i;
    }
    UILabel*address=[[UILabel alloc]init];
    address.text=@"常州新北区御龙府火锅城";
    [self.view addSubview:address];
    address.font=[UIFont systemFontOfSize:12];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.collectView).with.offset(120);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 20));
        make.left.offset(10);
    }];
    UILabel*address1=[[UILabel alloc]init];
    address1.text=@"常州市新北区太湖东路188号万达";
    address1.font=[UIFont systemFontOfSize:10];
    [self.view addSubview:address1];
    [address1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(WIDTH, 20));
        make.top.equalTo(address).with.offset(15);
        make.left.offset(15);
    }];
    UIView*line=[[UIView alloc]init];
    line.backgroundColor=[UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(WIDTH, 0.5));
        make.top.equalTo(address1).with.offset(25);
        
    }];
    self.text=[[UITextField alloc]init];
    _text.placeholder=@"消费金额:            输入到店消费金额";
    [self.view addSubview:_text];
    _text.layer.borderWidth=0.5;
    _text.layer.borderColor=[[UIColor grayColor]CGColor];
    [_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(280, 30));
        make.left.offset(20);
        make.top.equalTo(line).with.offset(20);
//        make.bottom.offset(40);
    }];
    [LQQMonitorKeyboard LQQAddMonitorWithShowBack:^(NSInteger height) {
    
    } andDismissBlock:^(NSInteger height) {
        
    }];
    //确认支付
    UILabel*payMoneyLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-80, HEIGHT-90, 200, 40)];
//    [payMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(200, 40));
//        make.left.offset(20);
//        make.top.equalTo(self.text).with.offset(50);
//        
//        
//    }];
    [self.view addSubview:payMoneyLabel];
    payMoneyLabel.text=@"实付金额  ￥:88";
    UIButton*payButton=[[UIButton alloc]initWithFrame:CGRectMake(20, HEIGHT-50, WIDTH-40, 40)];
      payButton.backgroundColor=[UIColor orangeColor];
    [payButton setTitle:@"确认支付" forState:UIControlStateNormal];
    [self.view addSubview:payButton];
    
   }

//click交易场景
-(void)click:(UIButton*)sender{
    for (int i=0; i<4; i++) {
        UILabel*label1=[[UILabel alloc]init];

       UIButton *button =[[UIButton alloc]init];
        button=(UIButton*)[self.collectView viewWithTag:60+i];
            label1.frame=CGRectMake(30+100*i, 95, 75, 20);
            label1.text=@"选中";
            [self.collectView addSubview:label1];
        label1.hidden=YES;
        if ([sender isEqual:button]) {
            label1.hidden=NO;
        }else{
            label1.hidden=YES;
        }
        
    }
    
 }
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.text resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
