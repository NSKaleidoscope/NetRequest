//
//  YR_NetworkTool.m
//  YR_NetworkTool
//
//  Created by dllo on 2016/10/12.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "YR_NetworkTool.h"
#import "AFNetworking.h"

@implementation YR_NetworkTool

+ (void)GET:(NSString *)url body:(id)body header:(NSDictionary *)headers response:(YRResponseStyle)responseStyle success:(successBlock)success failure:(failureBlock)failure {
    
    // 1. 设置网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 2. 设置请求头
    if (headers) {
        for (NSString *key in headers.allKeys) {
            [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
        }
    }
    
    // 3. 设置返回数据类型
    switch (responseStyle) {
        case YRJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case YRXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        case YRDATA:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        default:
            break;
    }
    
    // 4. 设置相应数据类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/jsion", @"text/json", @"application/javascript", @"image/jpeg", @"text/vnd.wap.wml", @"text/xml", nil]];
    
    // 5. UTF-8转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // 6. 使用AFN进行网络请求
    [manager GET:url parameters:body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
    
    
}

+ (void)POST:(NSString *)url body:(id)body bodyStyle:(YRResponseStyle)bodyStyle header:(NSDictionary *)headers reponse:(YRResponseStyle)responseStyle success:(successBlock)success failure:(failureBlock)failure {
    
    // 1. 设置网络管理者
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    
    // 2. 设置body的数据类型
    switch (bodyStyle) {
        case YRBodyJSON:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        case YRBodyString:
            [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
                return parameters;
            }];
            break;
            
        default:
            break;
    }
    
    // 3. 设置请求头
    switch (responseStyle) {
        case YRJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case YRXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        case YRDATA:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
            
        default:
            break;
    }
    
    // 4. 设置相应数据类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/plain", @"application/javascript", @"image/jpeg", @"text/vnd.wap.wml", nil]];
    
    // 5. UTF-8转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // 6. 使用AFN进行网络请求
    [manager POST:url parameters:body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
        
    }];
    
}

@end
