//
//  photoCell.h
//  MBL_CoreData
//
//  Created by neo-mac on 16/7/28.
//  Copyright © 2016年 neo-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIView+SDAutoLayout.h>
#import <ZLPhotoActionSheet.h>
#import <ZLDefine.h>
#import <ZLPhotoBrowser.h>
#import <ZLCollectionCell.h>
#import <ZLShowBigImgViewController.h>
@protocol MLBPhotoDelegate
-(void)removePhotoView;
-(void)addPhotoView;
@end
@interface photoCell : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UICollectionView*collectionView;
@property(nonatomic,strong)UITableView*photoInfoTableView;
@property (nonatomic, strong) NSArray<ZLSelectPhotoModel *> *lastSelectMoldels;
@property (nonatomic, strong) NSArray *arrDataSources;
@property(nonatomic,assign)id<MLBPhotoDelegate>photoDelegate;
-(NSArray*)photoArray;
@end
