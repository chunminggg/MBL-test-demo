//
//  collecitonCell.m
//  chenyue-1
//
//  Created by neo-mac on 16/3/18.
//  Copyright © 2016年 neo-mac. All rights reserved.
//

#import "collecitonCell.h"
@interface collecitonCell()
@property(nonatomic,strong)UIImageView*imageView;

@end
@implementation collecitonCell
#pragma mark - Lazy Methods
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
- (void)setImageName:(NSString *)imageName {
    _imageName = [imageName copy];
    NSString *file = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    NSData *imageData = [NSData dataWithContentsOfFile:file];
    UIImage *image = [UIImage imageWithData:imageData];
    self.imageView.image = image;
}
@end
