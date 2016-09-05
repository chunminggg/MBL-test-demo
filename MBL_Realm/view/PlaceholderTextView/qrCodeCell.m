//
//  qrCodeCell.m
//  NeotridentELN
//
//  Created by neo-mac on 16/7/12.
//  Copyright © 2016年 neo-mac. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#import "qrCodeCell.h"
#import <UIView+SDAutoLayout.h>
@interface qrCodeCell()
{   UILabel*_instrument_ID;
    UILabel*_nameLabel;
    UILabel*_modelVersion;
    UILabel*_ids_port;
    UILabel*_ids_server;
    UILabel*_instrment_ip;
    UILabel*_instrument_port;
    UIView*_line;
    
}
@end
@implementation qrCodeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self  createUI];
    }
    return self;
}
-(void)createUI{
    _nameLabel=[[UILabel alloc]init];
    _modelVersion=[[UILabel alloc]init];
    _ids_port=[[UILabel alloc]init];
    _ids_server=[[UILabel alloc]init];
    _instrment_ip=[[UILabel alloc]init];
    _instrument_port=[[UILabel alloc]init];
    _instrument_ID=[[UILabel alloc]init];
    _weight=[[UILabel alloc]init];
    _dateLabel=[[UILabel alloc]init];
    _line=[[UIView alloc]init];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_modelVersion];
    [self.contentView addSubview:_ids_server];
    [self.contentView addSubview:_ids_port];
    [self.contentView addSubview:_instrument_port];
    [self.contentView addSubview:_instrment_ip];
    [self.contentView addSubview:_instrument_ID];
    [self.contentView addSubview:_weight];
    [self.contentView addSubview:_dateLabel];
    [self.contentView addSubview:_line];
    _line.backgroundColor=[UIColor grayColor];
    _nameLabel.font=[UIFont systemFontOfSize:12];
    _modelVersion.font=[UIFont systemFontOfSize:12];
    _ids_server.font=[UIFont systemFontOfSize:12];
    _ids_port.font=[UIFont systemFontOfSize:12];
    _instrument_port.font=[UIFont systemFontOfSize:12];
    _instrument_ID.font=[UIFont systemFontOfSize:12];
    _instrment_ip.font=[UIFont systemFontOfSize:12];
    _weight.font=[UIFont systemFontOfSize:12];
    _dateLabel.font=[UIFont systemFontOfSize:12];
    
    _instrument_ID.sd_layout.leftSpaceToView(self.contentView,50).bottomSpaceToView(self.contentView,5).widthIs(80);
    _nameLabel.sd_layout.leftSpaceToView(_instrument_ID,5).bottomSpaceToView(self.contentView,5).widthIs(100);
    _modelVersion.sd_layout.leftSpaceToView(_nameLabel,5).bottomSpaceToView(self.contentView,5).widthIs(60);
    _ids_port.sd_layout.leftSpaceToView(_modelVersion,5).bottomSpaceToView(self.contentView,5).widthIs(80);
    _ids_server.sd_layout.leftSpaceToView(_ids_port,5).bottomSpaceToView(self.contentView,5).widthIs(80);
    _instrument_port.sd_layout.leftSpaceToView(_ids_server,5).bottomSpaceToView(self.contentView,5).widthIs(100);
    _instrment_ip.sd_layout.leftSpaceToView(_instrument_port,5).bottomSpaceToView(self.contentView,5).widthIs(80);
    _weight.sd_layout.leftSpaceToView(_instrment_ip,5).bottomSpaceToView(self.contentView,5).widthIs(80);
    _dateLabel.sd_layout.leftSpaceToView(_weight,5).bottomSpaceToView(self.contentView,5).widthIs(140);
    _line.sd_layout.leftSpaceToView(self.contentView,0).topSpaceToView(_instrment_ip,10).widthIs(SCREEN_WIDTH).heightIs(1);
}
-(void)setModel:(equipMentModel *)model{
    _model=model;
    [_nameLabel setText: model.name];
    [_modelVersion setText:model.model];
    [_ids_port setText:model.ids_port];
    [_ids_server setText:model.ids_server];
    [_instrment_ip setText:model.instrument_ip];
    [_instrument_port setText:model.instrument_port];
    [_instrument_ID setText:model.instrument_ID];
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
