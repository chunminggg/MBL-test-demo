//
//  equipMentModel.m
//  MBL_CoreData
//
//  Created by neo-mac on 16/7/28.
//  Copyright © 2016年 neo-mac. All rights reserved.
//

#import "equipMentModel.h"

@implementation equipMentModel
-(id)initwithName:(NSString *)name instrumentId:(NSString *)instrument_ID modelVersion:(NSString *)modelVersion ids_port:(NSString *)ids_port ids_server:(NSString *)ids_server instrument_ip:(NSString *)instrument_ip andInstrument_port:(NSString *)instrument_port{
    if (self==[super init]) {
        _name=name;
        _model=modelVersion;
        _instrument_ID=instrument_ID;
        _instrument_port=instrument_port;
        _instrument_ip=instrument_ip;
        _ids_server=ids_server;
        _ids_port=ids_port;
        
    }
    return self;
}

@end
