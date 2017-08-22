//
//  LLSearchResultListView.m
//  LLSearchViewController
//
//  Created by 李龙 on 2017/7/28.
//
//

#import "LLSearchResultListView.h"
#import "UIView+LLRect.h"
#import "LLSearchVCConst.h"


@interface LLSearchResultListView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,copy) resultListViewCellDidClickBlock myCellDidClickBlock;
@end

@implementation LLSearchResultListView
static NSString *const flag = @"LLSearchResultListViewCell";



//不要xxx.frame = GRectmake()这样设置frame
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //初始化控件
        [self addSubview:self.myTableView];
    }
    return self;
}


//---------------------------------------------------------------------------------------------------
#pragma mark ================================== UITableViewDataSource/UITableViewDataSource ==================================
//---------------------------------------------------------------------------------------------------
static CGFloat const RowHeight = 44.f;

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resultArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:flag forIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.backgroundColor = [UIColor clearColor];
    UIImageView *line = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"base_cell-content-line"]];
    line.height = 0.5;
    line.alpha = 0.7;
    line.x = 10;
    line.y = 43;
    line.width = ZYHT_ScreenWidth;
    [cell.contentView addSubview:line];
    
    cell.imageView.image = [UIImage imageNamed:@"base_search"];
    cell.textLabel.text = self.resultArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RowHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //回调
    LLBLOCK_EXEC(_myCellDidClickBlock,tableView,indexPath.row);
}



- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _myTableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.tableFooterView = [UIView new];
        
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:flag];

    }
    return _myTableView;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _myTableView.frame = self.bounds;
}


//---------------------------------------------------------------------------------------------------
#pragma mark ================================== 对外接口 ==================================
//---------------------------------------------------------------------------------------------------
-(void)setResultArray:(NSArray<NSString *> *)resultArray
{
    _resultArray = resultArray;
    [self.myTableView reloadData];
}

- (void)resultListViewDidSelectedIndex:(resultListViewCellDidClickBlock)cellDidClickBlock
{
    _myCellDidClickBlock = cellDidClickBlock;
}


@end
