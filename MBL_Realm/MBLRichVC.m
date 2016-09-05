//
//  MBLRichVC.m
//  MBL_Realm
//
//  Created by neo-mac on 16/9/5.
//  Copyright © 2016年 neo-mac. All rights reserved.
//

#import "MBLRichVC.h"
#import <AFNetworking.h>
@interface MBLRichVC ()

@end

@implementation MBLRichVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Standard";
    self.navigationController.navigationBar.translucent = NO;
    
    self.alwaysShowToolbar = YES;
    self.receiveEditorDidChangeEvents = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Export" style:UIBarButtonItemStylePlain target:self action:@selector(exportHTML)];
//    NSString*mainResource=[[NSBundle mainBundle]resourcePath];
//    NSString*htmlPath=[mainResource stringByAppendingPathComponent:@"test.html"];
//    NSString*htmlString=[[NSString alloc]initWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
//    NSString *html=htmlString;
    self.shouldShowKeyboard = NO;
    
//    [self setHTML:html];
//    [self createDownloadTask];
//    [self richTextView:nil];
}
- (void)exportHTML {
    
    NSLog(@"%@", [self getHTML]);
    [self uploadFile:[self getHTML]];
    
}
//创建下载任务
-(void)createDownloadTask{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://192.168.2.129:8009/test.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        //        NSLog(@"response:%@",response);
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        [self richTextView:filePath];
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
}
-(void)richTextView:(NSURL*)urlPath{
    NSLog(@"text vie");
       NSString*html=[[NSString alloc]initWithContentsOfURL:urlPath encoding:NSUTF8StringEncoding error:nil];
  
        [self setPlaceholder:@"This is a placeholder that will show when there is no content(html)"];
    [self setHTML:html];
    
}
-(void)uploadFile:(NSString*)richText{
    [self writeFile:@"mbl.html" andContent:richText];
    NSString*filePath=[self readFilePath:@"mbl.html"];
    NSLog(@"now file path:%@",[self readFilePath:@"mbl.html"]);
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    NSURL *URL = [NSURL URLWithString:@" http://61.177.48.74:8007/api/HtmlDocument"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    NSString *filed = [NSString stringWithFormat:@"multipart/form-data"];
    [request setValue:filed forHTTPHeaderField:@"Content-Type"];
    NSURL *filePath1 = [NSURL fileURLWithPath:filePath];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath1 progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"response:%@",response);
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
        }
    }];
    [uploadTask resume];
}
- (NSString *)getDocumentsPath
{
    //获取Documents路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}
//创建文件夹
-(void)createDirectory:(NSString*)fileName{
    NSString *documentsPath =[self getDocumentsPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *iOSDirectory = [documentsPath stringByAppendingPathComponent:fileName];
    BOOL isSuccess = [fileManager createDirectoryAtPath:iOSDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    if (isSuccess) {
        NSLog(@"success");
    } else {
        NSLog(@"fail");
    }
}
//创建文件
-(void)createFile:(NSString*)fileDetailName{
    NSString *documentsPath =[self getDocumentsPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *iOSPath = [documentsPath stringByAppendingPathComponent:fileDetailName];
    BOOL isSuccess = [fileManager createFileAtPath:iOSPath contents:nil attributes:nil];
    if (isSuccess) {
        NSLog(@"success");
    } else {
        NSLog(@"fail");
    }
}
//写文件
-(void)writeFile:(NSString*)fileName andContent:(NSString*)contentString{
    NSString *documentsPath =[self getDocumentsPath];
    NSString *iOSPath = [documentsPath stringByAppendingPathComponent:fileName];
    NSString *content =contentString;
    BOOL isSuccess = [content writeToFile:iOSPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (isSuccess) {
        NSLog(@"write success");
    } else {
        NSLog(@"write fail");
    }
}
//读取文件内容
-(void)readFileContent:(NSString*)fileName{
    NSString *documentsPath =[self getDocumentsPath];
    NSString *iOSPath = [documentsPath stringByAppendingPathComponent:fileName];
    NSString *content = [NSString stringWithContentsOfFile:iOSPath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"read success: %@",content);
}
-(NSString*)readFilePath:(NSString*)fileName{
    NSString *documentsPath =[self getDocumentsPath];
    NSString *iOSPath = [documentsPath stringByAppendingPathComponent:fileName];
    return iOSPath;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
