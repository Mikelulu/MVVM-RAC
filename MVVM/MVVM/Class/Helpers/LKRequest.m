//
//  LKRequest.m
//  MVVM
//
//  Created by Mike on 16/8/5.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKRequest.h"


@implementation LKRequest

+ (instancetype)request {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.operationManager = [AFHTTPSessionManager manager];
    }
    return self;
}

- (void)GET:(NSString *)URLString
 parameters:(NSDictionary*)parameters
    success:(void (^)(LKRequest *request, NSString *responseString))success
    failure:(void (^)(LKRequest *request, NSError *error))failure;{
    

    self.operationQueue=self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [self.operationManager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
//        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       id data = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        success(self,data);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error.localizedDescription);
        failure(self,error);
    }];
    
}

- (void)POST:(NSString *)URLString
  parameters:(NSDictionary*)parameters
     success:(void (^)(LKRequest *request, NSString* responseString))success
     failure:(void (^)(LKRequest *request, NSError *error))failure{
    
    self.operationQueue = self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self.operationManager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
//        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id data = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        
        success(self,data);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        failure(self,error);
        
    }];
}
- (void)cancelAllOperations{
    [self.operationQueue cancelAllOperations];
}
@end
