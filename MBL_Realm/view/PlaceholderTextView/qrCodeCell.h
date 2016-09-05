//
//  qrCodeCell.h
//  NeotridentELN
//
//  Created by neo-mac on 16/7/12.
//  Copyright © 2016年 neo-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "equipMentModel.h"
@interface qrCodeCell : UITableViewCell
@property(nonatomic,strong)equipMentModel*model;
@property(nonatomic,strong)UILabel*weight;
@property(nonatomic,strong)UILabel*dateLabel;
@end
