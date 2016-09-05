//
//  equipCell.h
//  MBL_CoreData
//
//  Created by neo-mac on 16/7/28.
//  Copyright © 2016年 neo-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MBLEquipDelegate
-(void)removeEquipView;
-(void)addEquipView;
@end
@interface equipCell : UICollectionViewCell<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView*qrcodeTableView;
@property(nonatomic,assign)id<MBLEquipDelegate> equipDelegate;
@end
