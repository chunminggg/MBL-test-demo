//
//  photoCell.m
//  MBL_CoreData
//
//  Created by neo-mac on 16/7/28.
//  Copyright © 2016年 neo-mac. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#import "photoCell.h"
#import "KxMenu.h"
@interface photoCell()
{
    BOOL flag;
    UIImageView*_imageView;

}
@property(nonatomic,strong)UIView*expPhenomena;
@end
@implementation photoCell
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self initCollectionView];
        
    }
    return self;
}
-(void)initCollectionView{
    flag=YES;
    //实验现象
    _expPhenomena=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
//    _expPhenomena.backgroundColor=[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1];
    [self addSubview:_expPhenomena];
    UILabel*expMethodLabel=[[UILabel alloc]init];
    expMethodLabel.textColor=[UIColor blackColor];
    UIView*line=[[UIView alloc]init];
    line.backgroundColor=[UIColor blueColor];

    expMethodLabel.text=@"实验现象";
    [_expPhenomena addSubview:expMethodLabel];
    [_expPhenomena addSubview:line];
       UIButton*photoButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [photoButton  setTitle:@"选择照片" forState:UIControlStateNormal];
    [photoButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_expPhenomena addSubview:photoButton];
    photoButton.tag=998;
    photoButton.hidden=YES;
    UIButton*actionButton=[UIButton buttonWithType:UIButtonTypeCustom];
    actionButton.imageView.contentMode=UIViewContentModeScaleAspectFill;

    [actionButton setBackgroundImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
    [_expPhenomena addSubview:actionButton];
    [actionButton addTarget:self  action:@selector(addItems:) forControlEvents:UIControlEventTouchUpInside];
    expMethodLabel.sd_layout.leftSpaceToView(_expPhenomena,3).widthIs(80).heightIs(30).centerYEqualToView(_expPhenomena);
    
    line.sd_layout.bottomSpaceToView(_expPhenomena,0).widthIs(SCREEN_WIDTH).heightIs(1);

    actionButton.sd_layout.leftSpaceToView(expMethodLabel,10).widthIs(30).heightIs(30).centerYEqualToView(_expPhenomena);
    
    photoButton.sd_layout.leftSpaceToView(actionButton,30).centerYEqualToView(_expPhenomena).widthIs(80).heightIs(40);
    
    
    [photoButton addTarget:self action:@selector(choosePhotos) forControlEvents:UIControlEventTouchUpInside];
    
    
   }

-(void)initTableView{
    UIButton*button=(UIButton*)[self viewWithTag:998];
    button.hidden=NO;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((SCREEN_WIDTH-4)/8, (SCREEN_WIDTH-4)/8);
    layout.minimumInteritemSpacing = 1.5;
    layout.minimumLineSpacing = 1.5;
    layout.sectionInset = UIEdgeInsetsMake(3, 0, 3, 0);
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, SCREEN_HEIGHT/3) collectionViewLayout:layout];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.collectionView];
    self.collectionView.sd_layout.topSpaceToView(_expPhenomena,5).leftSpaceToView(self,0).widthIs(SCREEN_WIDTH/2).heightIs(SCREEN_HEIGHT/3);
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZLCollectionCell" bundle:kZLPhotoBrowserBundle] forCellWithReuseIdentifier:@"ZLCollectionCell"];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.photoInfoTableView=[[UITableView alloc]init];
    [self addSubview:self.photoInfoTableView];
    self.photoInfoTableView.sd_layout.leftSpaceToView(self.collectionView,5).rightSpaceToView(self,0).widthIs(SCREEN_WIDTH/2).heightIs(SCREEN_HEIGHT/3).topSpaceToView(_expPhenomena,5);
    self.photoInfoTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    self.photoInfoTableView.delegate=self;
    self.photoInfoTableView.dataSource=self;

}
-(void)choosePhotos{
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置照片最大选择数
    actionSheet.maxSelectCount = 9;
    //设置照片最大预览数
    actionSheet.maxPreviewCount = 20;
    weakify(self);
    [actionSheet showWithSender:[self viewController] animate:YES lastSelectPhotoModels:self.lastSelectMoldels completion:^(NSArray<UIImage *> * _Nonnull selectPhotos, NSArray<ZLSelectPhotoModel *> * _Nonnull selectPhotoModels) {
        strongify(weakSelf);

        strongSelf.arrDataSources = selectPhotos;
        strongSelf.lastSelectMoldels = selectPhotoModels;
        NSLog(@"photo array :%@  ",strongSelf.arrDataSources);
        [strongSelf.collectionView reloadData];
        [strongSelf.photoInfoTableView reloadData];

    }];

}
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
#pragma mark----collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return
    _arrDataSources.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZLCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZLCollectionCell" forIndexPath:indexPath];
   
        cell.imageView.image = _arrDataSources[indexPath.row];
  
    
    cell.btnSelect.hidden = YES;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
#pragma mark-----tableviewdelegata
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell1" ];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}
#pragma mark------tableviewdatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrDataSources.count;
    
}
-(NSArray*)photoArray{
    return _arrDataSources;
}
-(void)addItems:(UIButton*)sender{
    UIButton*button=(UIButton*)[self viewWithTag:998];
        if (flag) {
        [UIView animateWithDuration:0.5 animations:^{
            sender.transform= CGAffineTransformMakeRotation(M_PI);
            [self.photoDelegate addPhotoView];
            [self initTableView];

        } completion:^(BOOL finished) {
            flag=NO;
            button.hidden=NO;
            self.photoInfoTableView.hidden=NO;
            self.collectionView.hidden=NO;
        }];
    }
    else{

        [UIView animateWithDuration:0.5 animations:^{
            sender.transform = CGAffineTransformMakeRotation(0);
            [self.photoDelegate removePhotoView];
            self.photoInfoTableView.hidden=YES;
            self.collectionView.hidden=YES;
        } completion:^(BOOL finished) {
            flag = YES;
            button.hidden=YES;

        }];
    }

    
}
//    UIButton*button=(UIButton*)[self viewWithTag:999];
//    NSArray *menuItems =
//    @[
//
//      [KxMenuItem menuItem:@"重命名"
//                     image:nil
//                    target:self
//                    action:@selector(method1)],
//
//      [KxMenuItem menuItem:@"排序"
//                     image:nil
//                    target:self
//                    action:@selector(method2)],
//
//      [KxMenuItem menuItem:@"展开"
//                     image:nil
//                    target:self
//                    action:@selector(method3)]
//
//      ];
//    [KxMenu showMenuInView:self
//                  fromRect:button.frame
//                 menuItems:menuItems];
@end
