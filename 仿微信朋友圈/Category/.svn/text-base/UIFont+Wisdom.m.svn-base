//
//  UIFont+Wisdom.m
//  WLManager
//
//  Created by Leiqiqi on 16/6/23.
//  Copyright © 2016年 Leiqiqi. All rights reserved.
//

#import "UIFont+Wisdom.h"

@implementation UIFont (Wisdom)


+(UIFont *)fontWithWisdomSize:(CGFloat)font;
{
    UIFont *fonts = [UIFont fontWithName:@"ArialMT" size:font];
    return  fonts;
}

@end

@implementation NSString (StringLogin)

+ (NSString *)dictionaryWithJson:(NSDictionary *)dic

{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
    
    
}

+(NSString *)defautlsToJsonString
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *jsonString =  [defaults objectForKey:@"loginDetail"];
    
    return jsonString;
}

@end

@implementation NSDictionary (Login)


+ (NSDictionary *)dictionaryWithJson{
    
    NSString *jsonString = [NSString defautlsToJsonString];
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&error];
    
    
    if(error) {
        NSLog(@"json解析失败：%@",error);
        return nil;
    }
    return dic;
}


@end



@implementation NSUserDefaults (UserDetail)

+(NSUserDefaults *)defaultWithDic:(NSDictionary *)dic
{
    
    NSString *jsonString = [NSString dictionaryWithJson:dic];
    NSLog(@"jsonString------>%@", jsonString);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:jsonString forKey:@"loginDetail"];
    [defaults synchronize];
    
    return defaults;
    
}


@end