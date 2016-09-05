//
//  MBLSocket.m
//  MBL_Realm
//
//  Created by neo-mac on 16/8/16.
//  Copyright © 2016年 neo-mac. All rights reserved.
//

#import "MBLSocket.h"

@interface MBLSocket ()<GCDAsyncSocketDelegate>
@property (nonatomic, strong) NSMutableArray *clientSockets;// 客户端socket


@end
@implementation MBLSocket
+ (instancetype)sharedSocket {
    static MBLSocket *scoket;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scoket = [[self alloc] init];
    });
    return scoket;
}
- (instancetype)init {
    if (self = [super init]) {
        _asyncSocket.delegate=nil;
        [_asyncSocket disconnect];
        _asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    }
    return self;
}
- (void)startConnectSocket {
    
    NSError *error = nil;
    [_asyncSocket acceptOnPort:self.port error:&error];
    
    if (!error) {
        NSLog(@"success  %@",_asyncSocket);
        [_asyncSocket readDataWithTimeout:-1 tag:0];
    } else {
        NSLog(@"服务开启失败 %@", error);
    }
}
-(void)onSocket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag

{
    
    // 对得到的data值进行解析与转换即可
    
[self.asyncSocket readDataWithTimeout:-1 tag:0];
    NSLog(@"data:%@",data);
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"yes :%@   %hu",host,port);
}
- (void)socket:(GCDAsyncSocket *)sock didConnectToUrl:(NSURL *)url{
    NSLog(@"url:%@",url);
}
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket {
    NSLog(@"服务端  %@", sock);
    NSLog(@"客户端  %@", newSocket);
    [self.clientSockets addObject:newSocket];
    NSLog(@"now :%@",self.clientSockets);
}
- (NSMutableArray *)clientSockets {
    if (_clientSockets == nil) {
        _clientSockets = [NSMutableArray array];
    }
    return _clientSockets;
}

@end
