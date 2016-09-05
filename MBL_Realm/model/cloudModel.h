//
//  cloudModel.h
//  MBL_Realm
//
//  Created by neo-mac on 16/8/24.
//  Copyright © 2016年 neo-mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cloudModel : NSObject
@property(nonatomic,copy)NSString*ID;
@property(nonatomic,copy)NSString*expTitle;
@property(nonatomic,copy)NSString*expAuthor;
@property(nonatomic,copy)NSString*updatedAt;
@property(nonatomic,copy)NSString*expNumber;
@property(nonatomic,copy)NSString*expVault;
@property(nonatomic,copy)NSString*expVersion;
@end
