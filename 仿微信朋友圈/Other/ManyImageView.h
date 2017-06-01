//
//  ManyImageView.h
//  多张图片显示
//
//  Created by 苗建浩 on 2017/5/8.
//  Copyright © 2017年 苗建浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManyImageView : UIView

+ (instancetype)initWithFrame:(CGRect)frame imageArr:(NSArray *)imageArr numberRow:(int)numberRow widthClearance:(int)widthMargin;

- (void)frame:(CGRect)frame imageWithArr:(NSArray *)imageArr;

@end
