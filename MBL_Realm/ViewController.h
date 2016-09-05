//
//  ViewController.h
//  MBL_Realm
//
//  Created by neo-mac on 16/7/29.
//  Copyright © 2016年 neo-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSSRichTextEditor.h"
@interface ViewController : UIViewController


@property (readonly) NSMutableSet *connectedSockets;
@property (strong) NSURL *url;


- (void)stop;
@end

