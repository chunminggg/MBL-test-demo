//
//  equipCell.m
//  MBL_CoreData
//
//  Created by neo-mac on 16/7/28.
//  Copyright © 2016年 neo-mac. All rights reserved.
//

#import "equipCell.h"
#import "equipMentModel.h"
#import "qrCodeCell.h"
#import "KxMenu.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import <UIView+SDAutoLayout.h>
@interface equipCell()
    {
        BOOL flag;
        UIImageView*_imageView;

    }

@property(nonatomic,strong)UIView*expAlaSizeView;
@end
@implementation equipCell
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame: frame];
    if (self) {
        [self initTableView];
    }
    return self;
}
-(void)initTableView{
    //实验分析
    flag=YES;

    _expAlaSizeView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 40)];
//    _expAlaSizeView.backgroundColor=[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1];
    [self addSubview:_expAlaSizeView];
    UILabel*expAlaLabel=[[UILabel alloc]init];
    expAlaLabel.text=@"实验分析";
    [_expAlaSizeView addSubview:expAlaLabel];
    UIView*line=[[UIView alloc]init];
    line.backgroundColor=[UIColor blueColor];
    [_expAlaSizeView addSubview:line];
    UIButton*scanButton=[UIButton buttonWithType:UIButtonTypeCustom];
    scanButton.tag=997;
    [scanButton  setTitle:@"扫描取数" forState:UIControlStateNormal];
    [scanButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    scanButton.hidden=YES;
    [_expAlaSizeView addSubview:scanButton];
    UIButton*actionButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [actionButton setBackgroundImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];    actionButton.backgroundColor=[UIColor clearColor];
    [actionButton addTarget:self  action:@selector(addItems:) forControlEvents:UIControlEventTouchUpInside];
    actionButton.tag=999;
    [_expAlaSizeView addSubview:actionButton];
     expAlaLabel.sd_layout.leftSpaceToView(_expAlaSizeView,3).centerYEqualToView(_expAlaSizeView).widthIs(80).heightIs(30);
    actionButton.sd_layout.leftSpaceToView(expAlaLabel,10).widthIs(30).heightIs(30).centerYEqualToView(_expAlaSizeView);

    scanButton.sd_layout.leftSpaceToView(expAlaLabel,30).centerYEqualToView(_expAlaSizeView).widthIs(200).heightIs(40);
    line.sd_layout.bottomSpaceToView(_expAlaSizeView,0).widthIs(SCREEN_WIDTH).heightIs(1);

//    [scanButton addTarget:self action:@selector(startQRcodeScan) forControlEvents:UIControlEventTouchUpInside];
    //继续扫描
    UIButton*nextButton=[UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.hidden=YES;
    nextButton.tag=998;
    [nextButton  setTitle:@"继续扫描" forState:UIControlStateNormal];
    [_expAlaSizeView addSubview:nextButton];
    nextButton.sd_layout.rightSpaceToView(expAlaLabel,5).widthIs(120).centerYEqualToView(_expAlaSizeView).heightIs(40);
//    [nextButton addTarget:self action:@selector(goToAgainScan) forControlEvents:UIControlEventTouchUpInside];
    
    
   
    
    
}
-(void)createTableView{
    UIButton*button=(UIButton*)[self viewWithTag:997];
    button.hidden=NO;
    self.qrcodeTableView=[[UITableView alloc]init];
    self.qrcodeTableView.delegate=self;
    self.qrcodeTableView.dataSource=self;
    [self addSubview:self.qrcodeTableView];
    self.qrcodeTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    self.qrcodeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.qrcodeTableView.sd_layout.topSpaceToView(_expAlaSizeView,0).widthIs(SCREEN_WIDTH*3/2).heightIs(SCREEN_HEIGHT/3).leftSpaceToView(self,0);
    self.qrcodeTableView.alwaysBounceHorizontal=YES;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   qrCodeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[qrCodeCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        
    }
    if (indexPath.row==0) {
        equipMentModel*equipModel=[[equipMentModel alloc]initwithName:@"name" instrumentId:@"instrumentID" modelVersion:@"model" ids_port:@"ids_port" ids_server:@"ids_server" instrument_ip:@"instrment_ip" andInstrument_port:@"instrment_port"];
        
        cell.model=equipModel;
        cell.weight.text=@"weight";
        cell.dateLabel.text=@"date";
    }
   

    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(void)addItems:(UIButton*)sender{
    UIButton*button=(UIButton*)[self viewWithTag:997];

   
    if (flag) {
        NSLog(@"e:1");

        [UIView animateWithDuration:0.5 animations:^{
            sender.transform= CGAffineTransformMakeRotation(M_PI);
            [self.equipDelegate addEquipView];
            [self createTableView];

        } completion:^(BOOL finished) {
            flag=NO;
            button.hidden=NO;
            self.qrcodeTableView.hidden=NO;
        }];
    }
    else{
        NSLog(@"e:2");

        [UIView animateWithDuration:0.5 animations:^{
            sender.transform = CGAffineTransformMakeRotation(0);
            [self.equipDelegate removeEquipView];
            self.qrcodeTableView.hidden=YES;
            button.hidden=YES;
        } completion:^(BOOL finished) {
            flag = YES;
        }];
}


//    self.size=CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT/3);

}
@end
