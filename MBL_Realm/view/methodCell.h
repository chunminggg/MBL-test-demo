//
//  methodCell.h
//  MBL_CoreData
//
//  Created by neo-mac on 16/7/28.
//  Copyright © 2016年 neo-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRPlaceholderTextView.h"
@protocol MethodCellProtocol
-(void)removeMethodViewFromSuperView;

@end

@interface methodCell : UIView
@property(nonatomic,strong)BRPlaceholderTextView*methodTextView;
@property(nonatomic,copy)NSString*endText;
@property(nonatomic,assign)id<MethodCellProtocol> methodDelegate;
@end
