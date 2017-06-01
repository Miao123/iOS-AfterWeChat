//
//  HomeTableHeadView.m
//  仿微信朋友圈
//
//  Created by 苗建浩 on 2017/1/12.
//  Copyright © 2017年 苗建浩. All rights reserved.
//

#import "HomeTableHeadView.h"
#import "Header.h"
@implementation HomeTableHeadView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
    }
    return self;
}


-(void)createSubviews{
    //自定义的UI
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = [UIColor grayColor];
    //    if (section == 0) {
    //        lineLabel.hidden = YES;
    //    }
    lineLabel.frame = CGRectMake(0, 0, screenWidth, 0.5);
    [self.contentView addSubview:lineLabel];
    
    
    self.headImage = [[UIImageView alloc] initWithFrame:CGRectMake(10 * DISTENCEH, 15 * DISTENCEH, 50 * DISTENCEH, 50 * DISTENCEH)];
    self.headImage.image = [UIImage imageNamed:@"head"];
    [self.contentView addSubview:self.headImage];
    
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImage.right + 10 * DISTENCEW, self.headImage.top, 100 * DISTENCEW, 17 * DISTENCEH)];
    self.nameLabel.text = @"中国";
    //    nameLabel.backgroundColor = [UIColor redColor];
    self.nameLabel.textColor = RGB_COLOR(58, 87, 136);
    self.nameLabel.font = [UIFont boldSystemFontOfSize:15 * DISTENCEW];
    [self.contentView addSubview:self.nameLabel];
    
    
    
    
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.textShowLabel.left, self.textShowLabel.bottom + 5 * DISTENCEH, 100 * DISTENCEW, 16 * DISTENCEH)];
    self.timeLabel.text = @"3小时前";
    self.timeLabel.font = [UIFont systemFontOfSize:14 * DISTENCEW];
    self.timeLabel.textColor = [UIColor grayColor];
    if (self.timeLabel.text.length == 0) {
        self.timeLabel.frame = CGRectMake(self.textShowLabel.left, self.headImage.bottom , 100 * DISTENCEW, 16 * DISTENCEH);
    }
    //    timeLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.timeLabel];
    
    
    self.newsBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth - 30 * DISTENCEW , self.timeLabel.top, 30 * DISTENCEW, 30 * DISTENCEW)];
    [self.newsBtn setImage:[UIImage imageNamed:@"弹出"] forState:UIControlStateNormal];
    [self.newsBtn setImage:[UIImage imageNamed:@"head"] forState:UIControlStateSelected];
    //    newsBtn.tag = 1000 + section;
    [self.newsBtn addTarget:self action:@selector(newsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.newsBtn];
    
    
    self.popView = [[UIView alloc] initWithFrame:CGRectMake(screenWidth - 130 * DISTENCEW, self.newsBtn.top, 100 * DISTENCEW, 30 * DISTENCEW)];
    self.popView.backgroundColor = [UIColor redColor];
    if (self.judgeBOOL == YES) {
        //        int i = _judgeSection - 1000;
        //        if (i == section) {
        //            self.popView.hidden = NO;
        //        }else{
        //            self.popView.hidden = YES;
        //        }
    }else{
        self.popView.hidden = YES;
    }
    [self.contentView addSubview:self.popView];
    
    
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentBtn.backgroundColor = [UIColor blueColor];
    self.commentBtn.frame = CGRectMake(0, 0, _popView.width / 2, _popView.height);
    [self.commentBtn addTarget:self action:@selector(commentClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.popView addSubview:self.commentBtn];
    
}

- (void)sendDataArr:(NSArray *)dataArr andIndexRow:(int)indexSection{
    self.textShowLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.left, self.nameLabel.bottom + 5 * DISTENCEH, screenWidth - 60 * DISTENCEW - 20, 0)];
    self.textShowLabel.font = [UIFont systemFontOfSize:15 * DISTENCEW];
    //    textLabel.backgroundColor = [UIColor blueColor];
    self.textShowLabel.text = [NSString stringWithFormat:@"%@",dataArr[indexSection]];
    self.textShowLabel.numberOfLines = 0;
    [self.textShowLabel sizeToFit];
    [self.contentView addSubview:self.textShowLabel];
    
}


- (void)commentClick:(UIButton *)sender{
    NSLog(@"sssssddd");
}

- (void)newsBtnClick:(UIButton *)sender{
    self.popView.hidden = YES;
    self.judgeBOOL = YES;
    self.judgeSection = (int)sender.tag;
    //    [self.homeTable reloadData];
    if (self.judgeBOOL == YES) {
        //        [self.homeTable reloadData];
    }
    NSLog(@"ssssddddfff   点击");
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
