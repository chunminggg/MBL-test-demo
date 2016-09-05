//
//  ViewController.m
//  MBL_Realm
//
//  Created by neo-mac on 16/7/29.
//  Copyright © 2016年 neo-mac. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "ViewController.h"
#import "methodCell.h"
#import "photoCell.h"
#import <UIView+SDAutoLayout.h>
#import "equipCell.h"
#import "ViewController.h"
#import "localExp.h"
#import <AFNetworking.h>
#import <GCDAsyncSocket.h>
#import "equipMentModel.h"
#import <MJExtension.h>
#import "cloudModel.h"
#import "MBLRichVC.h"
@interface ViewController ()<MethodCellProtocol,MLBPhotoDelegate,MBLEquipDelegate,GCDAsyncSocketDelegate>
@property(nonatomic,strong)UIScrollView*scrollView;
@property(nonatomic,copy)NSString*endedString;
@property(nonatomic,strong)photoCell*photoView;
@property(nonatomic,strong)methodCell*methodView;
@property(nonatomic,strong)equipCell*equipView;
@property (readonly) GCDAsyncSocket *socket;
@property(nonatomic,strong)NSString*guidString;

@end

@implementation ViewController
@synthesize socket = _socket;
@synthesize url = _url;
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor=[UIColor redColor];
    button.frame=CGRectMake(100,100 , 300, 300);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(jumpToVC) forControlEvents:UIControlEventTouchUpInside];
//    [cloudModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
//        return @{@"ID":@"guid",
//                 @"expTitle":@"title",
//                 @"expAuthor":@"creator",
//                 @"updatedAt":@"modifyTime",
//                 @"expVault":@"syncIdentity",
//                 @"expVersion":@"appVersion"
//                 
//                 };
//    }];
//
//    self.guidString=[self createCUID:@""];
//    [self httpRequest];
    // Do any additional setup after loading the view, typically from a nib.
//    [self gorequeset];
//    [self fuckSocket];
//    [self createUI];
    
//    [self httpRequestNow];
//    [self syncConcurrent];
//    [self getExpList];
//    [self getExpDetail];
//    UIButton*rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    [rightButton addTarget:self action:@selector(synchroExp:) forControlEvents:UIControlEventTouchUpInside];
//    UIImage*rightImage=[UIImage imageNamed:@"synchro"];
//    [rightButton setImage:rightImage forState:UIControlStateNormal];
//    rightButton.size=CGSizeMake(32, 32);
//    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton];
}
-(void)jumpToVC{
    MBLRichVC*rich=[[MBLRichVC alloc]init];
    [self.navigationController pushViewController:rich animated:YES];
}
//同步
-(void)synchroExp:(UIButton*)sender{
//   [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//       sender.transform= CGAffineTransformMakeRotation(M_PI);
//   } completion:^(BOOL finished) {
//       NSLog(@"ok");
//   }];
    
}
-(void)getExpDetail{
    NSString*path=@"http://61.177.48.74:8007/api/Experiment/Detail/1E5AFB15-4F99-437B-8B6A-88228C7BA3A2";
    [[AFHTTPSessionManager manager]GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"response:%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
}
-(void)getExpList{
     NSString*path= @"http://61.177.48.74:8007/api/Experiment/page?creator=0&page=1&rows=10";
    [[AFHTTPSessionManager manager]GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray*rows=responseObject[@"rows"];
               NSArray*listArray=[cloudModel mj_objectArrayWithKeyValuesArray:rows];
        NSLog(@"get list:%@",responseObject);
        
        for (cloudModel*model in listArray) {
            NSLog(@"%@ %@ %@ %@ %@ %@",model.ID,model.expTitle,model.expAuthor,model.updatedAt,model.expVault,model.expVersion);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
}
//获取当前时间字符串
-(NSString*)getNowDate{
    NSDate *date=[NSDate date];
    NSDateFormatter*df=[[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString=[df stringFromDate:date];
    return dateString;
    
}
- (NSString *)createCUID:(NSString *)prefix

{
    CFUUIDRef  uuid;
    CFStringRef uuidStr;
    uuid=CFUUIDCreate(NULL);
    uuidStr=CFUUIDCreateString(NULL, uuid);
    NSString* result=[NSString stringWithFormat:@"%@%@",prefix,uuidStr];
    CFRelease(uuidStr);
    CFRelease(uuid);
    return result;
    
   }


- (void)stop;
{
    _socket = nil;
    NSLog(@"[Server] Stopped.");
}

-(void)fuckSocket{
    _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError*error=nil;
    BOOL result = [self.socket connectToHost:@"192.168.0.207" onPort:3001 error:&error];
    if (result) {
        [_socket readDataWithTimeout:-1 tag:0];
        [_socket disconnectAfterReading];
    }

}
-(void)gorequeset{
    
 
}
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket;
{
    NSLog(@"[Server] New connection.");
    [self.connectedSockets addObject:newSocket];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)socket withError:(NSError *)error;
{
    [self.connectedSockets removeObject:socket];
    NSLog(@"[Server] Closed connection: %@", error);
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag;
{
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"天平读书: %@",[self speraTeString:text]);
    NSLog(@"text:%@",text);
//    [sock writeData:data withTimeout:-1 tag:0];
    [sock readDataWithTimeout:-1 tag:0];
}
-(NSString*)speraTeString:(NSString*)String{
    NSArray*array=[String componentsSeparatedByString:@"+   "];
    NSArray*array1= [array[4] componentsSeparatedByString:@"   "];
    NSString*endString=[NSString stringWithFormat:@"%@%@",array1[0],array1[1]];
    return endString;
}


- (void)syncConcurrent
{
    // 1.获得全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 2.将任务加入队列
    dispatch_sync(queue, ^{
        NSLog(@"1-----%@", [NSThread currentThread]);
        [self httpRequestNow];
    });
    dispatch_sync(queue, ^{
        NSLog(@"2-----%@", [NSThread currentThread]);
        [self httpImageRequest];
    });
    dispatch_sync(queue, ^{
        NSLog(@"3-----%@", [NSThread currentThread]);
    });
    
    NSLog(@"syncConcurrent--------end");
}
- (void)asyncConcurrent
{
    // 1.创建一个并发队列
    
    // 1.获得全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 2.将任务加入队列
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i<10; i++) {
            NSLog(@"1-----%@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i<10; i++) {
            NSLog(@"2-----%@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i<10; i++) {
            NSLog(@"3-----%@", [NSThread currentThread]);
        }
    });
    
    NSLog(@"asyncConcurrent--------end");
    //    dispatch_release(queue);
}
-(void)createUI{
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.scrollView];
    self.title=@"test";
    
    //添加实验方法
    _methodView=[[methodCell alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3)];
    [self.scrollView addSubview:_methodView];
    __weak typeof(self) weakSelf = self;
    
    [_methodView.methodTextView addTextViewEndEvent:^(BRPlaceholderTextView *text) {
        weakSelf.endedString=text.text;
        NSLog(@"end:%@",weakSelf.endedString);
        
    }];
    _methodView.methodDelegate=self;
    
    //实验现象
    _photoView=[[photoCell alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/3, SCREEN_WIDTH, 40)];
    [self.scrollView addSubview:_photoView];
    _photoView.photoDelegate=self;
    //实验分析
    _equipView=[[equipCell alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/3+45, SCREEN_HEIGHT, 40)];
    [self.scrollView addSubview:_equipView];
    self.scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, _methodView.height+_photoView.height+_equipView.height);
    _equipView.equipDelegate=self;
    NSLog(@"change :%@",NSStringFromCGSize(_scrollView.contentSize));
    
    
}

-(void)getData{
    NSArray*array=[_photoView photoArray];
    NSLog(@"array:%@",array);
}
#pragma mark---methodview
-(void)removeMethodViewFromSuperView{
    NSLog(@"ok  go to the delegate");
//    [_methodView removeFromSuperview];
//    _methodView=nil;
//    if (_equipView!=nil&&_photoView!=nil) {
//    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
//                CGRect rect=_photoView.frame;
//                CGRect rect1=_equipView.frame;
//                rect.origin.y -=SCREEN_HEIGHT/3;
//                rect1.origin.y-=SCREEN_HEIGHT/3;
//                _photoView.frame=rect;
//                _equipView.frame=rect1;
//
//        } completion:^(BOOL finished) {
//            _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, _photoView.frame.size.height+_equipView.frame.size.height);
//            NSLog(@"change :%@",NSStringFromCGSize(_scrollView.contentSize));
//
//        }];
//    }
//    else if (_equipView!=nil&&_photoView==nil)
//    {
//        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
//            CGRect rect1=_equipView.frame;
//            rect1.origin.y-=SCREEN_HEIGHT/3;
//            _equipView.frame=rect1;
//            
//        } completion:^(BOOL finished) {
//            _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, _equipView.frame.size.height);
//            NSLog(@"change :%@",NSStringFromCGSize(_scrollView.contentSize));
//            
//        }];
//
//    }
//    
//    else if (_photoView!=nil&&_equipView==nil)
//    {
//        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
//            CGRect rect1=_photoView.frame;
//            rect1.origin.y-=SCREEN_HEIGHT/3;
//            _photoView.frame=rect1;
//            
//        } completion:^(BOOL finished) {
//            _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, _photoView.frame.size.height);
//            NSLog(@"change :%@",NSStringFromCGSize(_scrollView.contentSize));
//            
//        }];
//        
//    }

    
}
#pragma mark---photoView
-(void)addPhotoView{
    NSLog(@"add photoview");

        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            CGRect rect1=_photoView.frame;
            CGRect rect2=_equipView.frame;
            rect1.origin.y=SCREEN_HEIGHT/3;
            rect1.size.height=SCREEN_HEIGHT/3;
            rect2.origin.y+=SCREEN_HEIGHT/3;
            _photoView.frame=rect1;
            _equipView.frame=rect2;
            
        } completion:^(BOOL finished) {
            _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, _methodView.frame.size.height+_photoView.frame.size.height+_equipView.frame.size.height);
            NSLog(@"change :%@",NSStringFromCGSize(_scrollView.contentSize));
            
        }];

    
}
-(void)removePhotoView{
    NSLog(@"remove photoview");
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        CGRect rect1=_photoView.frame;
        CGRect rect2=_equipView.frame;
//        rect1.origin.y-=SCREEN_HEIGHT/3;
        rect1.size.height-=SCREEN_HEIGHT/3-40;
        rect2.origin.y-=SCREEN_HEIGHT/3;
        _photoView.frame=rect1;
        _equipView.frame=rect2;
        
    } completion:^(BOOL finished) {
        _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, _methodView.frame.size.height+_photoView.frame.size.height+_equipView.frame.size.height);
        NSLog(@"change :%@",NSStringFromCGSize(_scrollView.contentSize));
        
    }];
    
}
#pragma mark---equipView
-(void)addEquipView{
    NSLog(@"add photoview");

    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        CGRect rect1=_equipView.frame;
        rect1.size.height=SCREEN_HEIGHT/2;
        _equipView.frame=rect1;
        
    } completion:^(BOOL finished) {
        _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, _methodView.frame.size.height+_photoView.frame.size.height+_equipView.frame.size.height);
        NSLog(@"change :%@",NSStringFromCGSize(_scrollView.contentSize));
        
    }];

}
-(void)removeEquipView{
    NSLog(@"remove equipview");
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        CGRect rect1=_equipView.frame;
        rect1.size.height-=SCREEN_HEIGHT/2-40;
        _equipView.frame=rect1;
        
    } completion:^(BOOL finished) {
        _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, _methodView.frame.size.height+_photoView.frame.size.height+_equipView.frame.size.height);
        NSLog(@"change :%@",NSStringFromCGSize(_scrollView.contentSize));
        
    }];

}
-(void)viewAnimated:(UIView*)view1 view2:(UIView*)view2 view3:(UIView*)view3{
    
}



-(void)httpImageRequest{
    NSLog(@"photo:%@",[_photoView photoArray]);
    NSArray*array=[_photoView photoArray];
//    NSString*guid=[self createCUID:@""];
    NSString*path=[NSString stringWithFormat:@"http://61.177.48.74:8007/api/Experiment/Image/%@",_guidString];
    
    
    
    [[AFHTTPSessionManager manager]POST:path parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i=0; i<array.count; i++) {
            
            NSData* imageData=UIImageJPEGRepresentation(array[i], 0.7);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *imageName = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%d-%@.jpg",i,imageName];
            NSLog(@"filename:%@",fileName);
            NSString*describe=[NSString stringWithFormat:@"%d",i];
            [formData appendPartWithFileData:imageData name:describe fileName:fileName mimeType:@"image/jpeg"];
            
            
            
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"response:%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
    
}
-(void)httpRequestNow{
    equipMentModel*model1=[[equipMentModel alloc]initwithName:@"2" instrumentId:@"3" modelVersion:@"323" ids_port:@"323" ids_server:@"232323" instrument_ip:@"44" andInstrument_port:@"234"];
    equipMentModel*model2=[[equipMentModel alloc]initwithName:@"2" instrumentId:@"3" modelVersion:@"323" ids_port:@"323" ids_server:@"232323" instrument_ip:@"44" andInstrument_port:@"234"];
    equipMentModel*model3=[[equipMentModel alloc]initwithName:@"1" instrumentId:@"3" modelVersion:@"323" ids_port:@"323" ids_server:@"232323" instrument_ip:@"44" andInstrument_port:@"234"];
    equipMentModel*model4=[[equipMentModel alloc]initwithName:@"1" instrumentId:@"3" modelVersion:@"323" ids_port:@"323" ids_server:@"232323" instrument_ip:@"44" andInstrument_port:@"234"];
    NSArray*array=[NSArray arrayWithObjects:model1,model2,model3,model4 , nil];
    NSArray*dictArray=[equipMentModel mj_keyValuesArrayWithObjectArray:array];
    NSDictionary*dic=@{@"guid":_guidString,
                       @"title":@"first experiment",
                       @"creator":@"1",
                       @"createTime":[self getNowDate],
                       @"modifyTime":[self getNowDate],
                       @"content":@"2343242342343242342",
                       @"syncIdentity":@"1",
                       @"appVersion":@"V2.0",
                       @"instrument":dictArray
                       };
    NSString*jsonString=[self dictionaryToJson:dic ];
    NSLog(@"jsonString:%@",jsonString);
    NSLog(@"guid:%@  time:%@",self.guidString,[self getNowDate]);
//    NSString*path=@"http://192.168.2.129:7844/api/Experiment";
    NSString*path=@"http://61.177.48.74:8007/api/Experiment";
    
        AFHTTPSessionManager*manger=[AFHTTPSessionManager manager];
        manger.requestSerializer=[AFJSONRequestSerializer serializer];
    [ manger POST:path parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"response2222:%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
}
-(NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
