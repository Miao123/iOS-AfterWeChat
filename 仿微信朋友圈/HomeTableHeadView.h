//
//  HomeTableHeadView.h
//  仿微信朋友圈
//
//  Created by 苗建浩 on 2017/1/12.
//  Copyright © 2017年 苗建浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableHeadView : UITableViewHeaderFooterView
@property (nonatomic, assign) int judgeSection;
@property (nonatomic) BOOL judgeBOOL;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *textShowLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *newsBtn;
@property (nonatomic, strong) UIView *popView;
@property (nonatomic, strong) UIButton *commentBtn;

- (void)sendDataArr:(NSArray *)dataArr andIndexRow:(int)indexSection;

@end
