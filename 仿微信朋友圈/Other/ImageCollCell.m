//
//  ImageCollCell.m
//  多张图片显示
//
//  Created by 苗建浩 on 2017/5/9.
//  Copyright © 2017年 苗建浩. All rights reserved.
//

#import "ImageCollCell.h"

@interface ImageCollCell()
@property (nonatomic, strong) UIImageView *headImage;

@end

@implementation ImageCollCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        self.headImage = headImage;
        [self.contentView addSubview:headImage];
    }
    return self;
}


- (void)creatArr:(NSArray *)creatArr indexRow:(int)indexRow{
    self.headImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",creatArr[indexRow]]];
}


@end
