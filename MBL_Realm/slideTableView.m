//
//  slideTableView.m
//  MBL_Realm
//
//  Created by neo-mac on 16/8/19.
//  Copyright © 2016年 neo-mac. All rights reserved.
//

#import "slideTableView.h"

@interface slideTableView ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView* _tableView;
    NSMutableArray*_sectionArray;
    NSMutableArray*_sectionDataArray;
    NSMutableArray*_stateArray;
}
@end

@implementation slideTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTableView];
}
-(void)createTableView{
    _sectionArray= [NSMutableArray arrayWithObjects:@"关于直销银行",
                        @"关于理财产品",
                        @"关于我的投资",
                        @"安全中心",nil];
    NSArray *one = @[@"关于直销银行1",@"关于直销银行2",@"关于直销银行3"];
    NSArray *two = @[@"如何购买？",@"如何赎回？",@"业务办理时间？"];
    NSArray *three = @[@"关于我的投资1",@"关于我的投资2",@"关于我的投资3"];
    NSArray *four = @[@"安全中心1",@"安全中心2",@"安全中心3",@"安全中心4"];
    _sectionDataArray = [NSMutableArray arrayWithObjects:one,two,three,four, nil];
    _stateArray=[NSMutableArray array];
    for (int i=0; i<_sectionDataArray.count; i++) {
        [_stateArray addObject:@"0"];
    }
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[UIView new];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sectionDataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_stateArray[section] isEqualToString:@"1"]) {
        NSArray*array=[_sectionDataArray objectAtIndex:section];
        return array.count;
    }
    else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.textLabel.text=_sectionDataArray[indexPath.section][indexPath.row];
    return cell;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _sectionArray[section];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [button setTag:section+1];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 60)];
    [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(45, (44-20)/2, 200, 20)];
    [tlabel setBackgroundColor:[UIColor clearColor]];
    [tlabel setFont:[UIFont systemFontOfSize:14]];
    [tlabel setText:_sectionArray[section]];
    [button addSubview:tlabel];

    return button;
}
- (void)buttonPress:(UIButton *)sender//headButton点击
{
    NSLog(@"click");
    //判断状态值
    if ([_stateArray[sender.tag - 1] isEqualToString:@"1"]){
        //修改
        [_stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"0"];
    }else{
        [_stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"1"];
    }
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag-1] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",[indexPath section]);
    
    
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
