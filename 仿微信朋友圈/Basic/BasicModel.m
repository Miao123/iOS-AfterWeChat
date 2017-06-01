//
//  BasicModel.m
//  仿微信朋友圈
//
//  Created by 苗建浩 on 2017/5/31.
//  Copyright © 2017年 苗建浩. All rights reserved.
//

#import "BasicModel.h"

@implementation BasicModel

+ (instancetype)modelWithDict:(NSDictionary *)dict{
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    BasicModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key{
    
}


@end
