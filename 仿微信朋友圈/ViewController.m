//
//  ViewController.m
//  仿微信朋友圈
//
//  Created by 苗建浩 on 2017/1/5.
//  Copyright © 2017年 苗建浩. All rights reserved.
//

#import "ViewController.h"
#import "HomeTableHeadView.h"
#import "HomeTableCell.h"
#import "NSString+Font.h"
#import "Header.h"
#import "HeadModel.h"
#import "ManyImageView.h"
#define NumberRow 4 //  设置每行显示的图片数量
#define CollClearance 3 //  图片据上下两边的宽度
#define ImageWidthMargin 3  //    图片据左右两边的宽度


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *homeTable;
@property (nonatomic, strong) NSArray *textArr;
@property (nonatomic, strong) UIView *popView;
@property (nonatomic, strong) UITableView *homeTextView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, assign) int judgeSection;
@property (nonatomic) BOOL judgeBOOL;
@property (nonatomic) BOOL clickBOOL;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.judgeBOOL = NO;
    self.clickBOOL = YES;
    self.title = @"朋友圈";
    self.dataArr = [NSMutableArray array];
    
    NSArray *textArr =
    @[@{@"text":@"中国中医科学院首席研究",@"name":@"老苗",@"time":@"2017-05-12",@"head":@"111",@"image":@[@"111",@"222"]},
      @{@"text":@"当巴克莱银行外包其结算业务后，新公司的价格更为便宜。",@"name":@"老张",@"time":@"2017-04-19",@"head":@"222",@"image":@[@"111"]},
      @{@"text":@"存在错误的结算单仍有可能发送出去，但告知我们的客户将不会遭受损失。",@"name":@"老刘",@"time":@"2017-05-05",@"head":@"333",@"image":@[@"222",@"444"]},
      @{@"text":@"我们公平地结算这笔损坏赔偿账吧。",@"name":@"老王",@"time":@"2017-05-02",@"head":@"444",@"image":@[@"111",@"555",@"666",@"222",@"333"]},
      @{@"text":@"他们建议，国际交易可以使用评级高的企业票据和债券来进行融资和结算。",@"name":@"老张",@"time":@"2017-05-01",@"head":@"555",@"image":@[@"444",@"666"]},
      @{@"text":@"他们希望直接与交易所竞争交易和结算业务。",@"name":@"老杨",@"time":@"2017-05-03",@"head":@"666",@"image":@[@"222",@"444",@"555"]}];
    for (NSDictionary *dic in textArr) {
        [self.dataArr addObject:[HeadModel modelWithDict:dic]];
    }
    [self homeTableInterface];
}


- (void)homeTableInterface{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 180 * DISTENCEH)];
    headView.backgroundColor = [UIColor redColor];
    
    UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, headView.width, headView.height)];
    headImage.image = [UIImage imageNamed:@"headImage"];
    [headView addSubview:headImage];
    
    
    self.homeTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVGATION_ADD_STATUS_HEIGHT, screenWidth, screenHight - NAVGATION_ADD_STATUS_HEIGHT) style:UITableViewStylePlain];
    self.homeTable.dataSource = self;
    self.homeTable.delegate = self;
    self.homeTable.tableHeaderView = headView;
    self.homeTable.tableFooterView = [[UIView alloc] init];
    self.homeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.homeTable];
    
    
    //创建手势对象
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    self.tap = tap;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    HeadModel *dataModel = _dataArr[section];
    NSString *text = [NSString stringWithFormat:@"%@",dataModel.text];
    CGFloat height = [text heightWithText:text font:[UIFont systemFontOfSize:15 * DISTENCEW] width:screenWidth - 60 * DISTENCEW - 20];
    int integer = (int)dataModel.image.count / NumberRow;  //整数
    int remainder = dataModel.image.count % NumberRow;//   余数
    if (remainder > 0) {
        remainder = 1;
    }
    int imageHeight = (((screenWidth - 70 * DISTENCEW  - 12 - (3 * (NumberRow - 1))) / NumberRow) * (integer + remainder) + (integer + remainder) * 4);
    if (imageHeight > screenHight - NAVGATION_ADD_STATUS_HEIGHT) {
        imageHeight = screenHight - NAVGATION_ADD_STATUS_HEIGHT - 2 * CollClearance;
    }
    if (height > 0) {
        return 75 * DISTENCEW + height + imageHeight;
    }else{
        return 92 * DISTENCEH + imageHeight;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50 * DISTENCEW;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HeadModel *dataModel = _dataArr[section];
    
    
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 80 * DISTENCEW)];
    mainView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = [UIColor grayColor];
    if (section == 0) {
        lineLabel.hidden = YES;
    }
    lineLabel.frame = CGRectMake(0, 0, screenWidth, 0.5);
    [mainView addSubview:lineLabel];
    
    
    UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(10 * DISTENCEH, 15 * DISTENCEH, 50 * DISTENCEH, 50 * DISTENCEH)];
    headImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",dataModel.head]];
    [mainView addSubview:headImage];
    
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(headImage.right + 10 * DISTENCEW, headImage.top, 100 * DISTENCEW, 17 * DISTENCEH)];
    nameLabel.text = [NSString stringWithFormat:@"%@",dataModel.name];
    nameLabel.textColor = RGB_COLOR(58, 87, 136);
    nameLabel.font = [UIFont boldSystemFontOfSize:15 * DISTENCEW];
    [mainView addSubview:nameLabel];
    
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.left, nameLabel.bottom + 5 * DISTENCEH, screenWidth - 60 * DISTENCEW - 20, 0)];
    textLabel.text = [NSString stringWithFormat:@"%@",dataModel.text];
    textLabel.font = [UIFont systemFontOfSize:15 * DISTENCEW];
    textLabel.textColor = RGB_COLOR(50, 50, 50);
    textLabel.numberOfLines = 0;
    NSString *text = [NSString stringWithFormat:@"%@",dataModel.text];
    CGFloat height = [text heightWithText:text font:[UIFont systemFontOfSize:15 * DISTENCEW] width:screenWidth - 60 * DISTENCEW - 20];
    textLabel.height = height;
    [mainView addSubview:textLabel];
    
    
    int integer = (int)dataModel.image.count / NumberRow;  //整数
    int remainder = dataModel.image.count % NumberRow;//   余数
    if (remainder > 0) {
        remainder = 1;
    }
    int imageHeight = (((screenWidth - 70 * DISTENCEW  - 12 - (3 * (NumberRow - 1))) / NumberRow) * (integer + remainder) + (integer + remainder) * 4);
    if (imageHeight > screenHight - NAVGATION_ADD_STATUS_HEIGHT) {
        imageHeight = screenHight - NAVGATION_ADD_STATUS_HEIGHT - 2 * CollClearance;
    }
    ManyImageView *imageView = [ManyImageView initWithFrame:CGRectMake(nameLabel.left, textLabel.bottom + 10, screenWidth - 70 * DISTENCEW , imageHeight) imageArr:dataModel.image numberRow:NumberRow widthClearance:ImageWidthMargin];
    imageView.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:imageView];
    
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(textLabel.left, imageView.bottom + 8 * DISTENCEH, 100 * DISTENCEW, 16 * DISTENCEH)];
    timeLabel.text = [NSString stringWithFormat:@"%@",dataModel.time];
    timeLabel.font = [UIFont systemFontOfSize:14 * DISTENCEW];
    timeLabel.textColor = [UIColor grayColor];
    if (timeLabel.text.length == 0) {
        timeLabel.frame = CGRectMake(textLabel.left, headImage.bottom , 100 * DISTENCEW, 16 * DISTENCEH);
    }
    [mainView addSubview:timeLabel];
    
    
    UIButton *newsBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth - 30 * DISTENCEW , timeLabel.top - 8 * DISTENCEH, 30 * DISTENCEW, 30 * DISTENCEW)];
    [newsBtn setImage:[UIImage imageNamed:@"弹出"] forState:UIControlStateNormal];
    [newsBtn setImage:[UIImage imageNamed:@"head"] forState:UIControlStateSelected];
    newsBtn.tag = 1000 + section;
    [newsBtn addTarget:self action:@selector(newsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:newsBtn];
    
    
    UIView *popView = [[UIView alloc] initWithFrame:CGRectMake(screenWidth - 160 * DISTENCEW, newsBtn.top, 130 * DISTENCEW, 30 * DISTENCEW)];
    popView.backgroundColor = RGB_COLOR(57, 58, 62);
    popView.layer.cornerRadius = 3;
    self.popView = popView;
    if (self.judgeBOOL == YES) {
        int i = _judgeSection - 1000;
        if (i == section) {
            popView.hidden = NO;
        }else{
            popView.hidden = YES;
        }
    }else{
        popView.hidden = YES;
    }
    [mainView addSubview:popView];
    
    
    UIButton *praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    praiseBtn.backgroundColor = [UIColor clearColor];
    praiseBtn.frame = CGRectMake(0, 0, _popView.width / 2, _popView.height);
    [praiseBtn addTarget:self action:@selector(praiseClick:) forControlEvents:UIControlEventTouchUpInside];
    [praiseBtn setTitle:@"赞" forState:0];
    praiseBtn.tag = 1000 + section;
    praiseBtn.titleLabel.font = [UIFont systemFontOfSize:15 * DISTENCEW];
    praiseBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [popView addSubview:praiseBtn];
    
    
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentBtn.backgroundColor = [UIColor clearColor];
    commentBtn.frame = CGRectMake(praiseBtn.right, 0, _popView.width / 2, _popView.height);
    [commentBtn addTarget:self action:@selector(commentClick:) forControlEvents:UIControlEventTouchUpInside];
    [commentBtn setTitle:@"评论" forState:0];
    commentBtn.titleLabel.font = [UIFont systemFontOfSize:15 * DISTENCEW];
    commentBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    commentBtn.tag = 1000 + section;
    [popView addSubview:commentBtn];
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(praiseBtn.right, 5 * DISTENCEH, 0.6, popView.height - 10 * DISTENCEH)];
    lineView.backgroundColor = RGB_COLOR(120, 120, 120);
    [popView addSubview:lineView];
    
    return mainView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableCell *cell = [HomeTableCell creatCellWithTableView:tableView];
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.judgeBOOL == YES) {
        //        int heght = scrollView.contentOffset.y;
        //        if (heght <= 3 || heght >= -3) {
        [_homeTable removeGestureRecognizer:_tap];
        _judgeBOOL = NO;
        _clickBOOL = YES;
        [self.homeTable reloadData];
        //        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:2];
        //        [self.homeTable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        //        }else{
        //
        //        }
    }
}


//  赞
- (void)praiseClick:(UIButton *)sender{
    [_homeTable removeGestureRecognizer:_tap];
    self.judgeBOOL = NO;
    _clickBOOL = YES;
    [self.homeTable reloadData];
}


//  评论
- (void)commentClick:(UIButton *)sender{
    [_homeTable removeGestureRecognizer:_tap];
    self.judgeBOOL = NO;
    _clickBOOL = YES;
    [self.homeTable reloadData];
}


//  手势方法
- (void)tapAction:(UITapGestureRecognizer *)tap{
    [_homeTable removeGestureRecognizer:_tap];
    if (self.judgeBOOL == YES) {
        _clickBOOL = YES;
        self.judgeBOOL = NO;
        [self.homeTable reloadData];
    }
}


- (void)newsBtnClick:(UIButton *)sender{
    if (_clickBOOL) {
        self.judgeBOOL = YES;
        self.judgeSection = (int)sender.tag;
        if (self.judgeBOOL == YES) {
            [self.homeTable reloadData];
            [_homeTable addGestureRecognizer:_tap];
        }
    }else{
        if (self.judgeBOOL == YES) {
            [_homeTable removeGestureRecognizer:_tap];
            self.judgeBOOL = NO;
            [self.homeTable reloadData];
        }
    }
    _clickBOOL = !_clickBOOL;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@",,,,,,,,");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
