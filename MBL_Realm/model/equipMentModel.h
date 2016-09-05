//
//  equipMentModel.h
//  MBL_CoreData
//
//  Created by neo-mac on 16/7/28.
//  Copyright © 2016年 neo-mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface equipMentModel : NSObject
@property(nonatomic,copy)NSString*instrument_ID;
@property(nonatomic,copy)NSString*name;
@property(nonatomic,copy)NSString*model;
@property(nonatomic,copy)NSString*ids_port;
@property(nonatomic,copy)NSString*ids_server;
@property(nonatomic,copy)NSString*instrument_ip;
@property(nonatomic,copy)NSString*instrument_port;
-(id)initwithName:(NSString*)name instrumentId:(NSString*)instrument_ID modelVersion:(NSString*)modelVersion ids_port:(NSString*)ids_port ids_server:(NSString*)ids_server instrument_ip:(NSString*)instrument_ip andInstrument_port:(NSString*)instrument_port;

@end
