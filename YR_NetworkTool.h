//
//  YR_NetworkTool.h
//  YR_NetworkTool
//
//  Created by dllo on 2016/10/12.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successBlock)(id result);
typedef void(^failureBlock)(NSError *error);

typedef NS_ENUM(NSUInteger, YRResponseStyle) {
    YRJSON,
    YRDATA,
    YRXML,
};

typedef NS_ENUM(NSUInteger, YRRequestStyle) {
    YRBodyString,
    YRBodyJSON,
};

@interface YR_NetworkTool : NSObject

+ (void)GET:(NSString *)url
       body:(id)body
     header:(NSDictionary *)headers
   response:(YRResponseStyle)responseStyle
    success:(successBlock)success
    failure:(failureBlock)failure;

+ (void)POST:(NSString *)url
        body:(id)body
   bodyStyle:(YRResponseStyle)bodyStyle
      header:(NSDictionary *)headers
     reponse:(YRResponseStyle)responseStyle
     success:(successBlock)success
     failure:(failureBlock)failure;

@end
