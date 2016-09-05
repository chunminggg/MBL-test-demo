//
//  MBLSocket.h
//  MBL_Realm
//
//  Created by neo-mac on 16/8/16.
//  Copyright © 2016年 neo-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GCDAsyncSocket.h>
#import <GCDAsyncUdpSocket.h>
@interface MBLSocket : NSObject
@property (nonatomic, strong) GCDAsyncSocket *asyncSocket;

@property (nonatomic, assign) uint16_t port; // 端口
@property (nonatomic, copy) NSString *socketHost; // 服务器地址
- (void)startConnectSocket;

+ (instancetype)sharedSocket;
@end
