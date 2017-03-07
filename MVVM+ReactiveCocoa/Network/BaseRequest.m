//
//  BaseRequest.m
//  EBook
//
//  Created by juanmao on 16/11/30.
//  Copyright © 2016年 juanmao. All rights reserved.
//

#import "BaseRequest.h"
#import <objc/runtime.h>
#import "DES3Util.h"
#import "UserAddressModel.h"

@implementation NSError(Ext)

- (void)setErrMsg:(NSString *)errMsg{
    objc_setAssociatedObject(self, "errMsg", errMsg, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)errMsg{
    return objc_getAssociatedObject(self, "errMsg");
}

- (NSString *)localizedDescription
{
#ifdef DEBUG
    return self.errMsg ? self.errMsg : [NSString stringWithFormat:@"未知错误, 错误码%ld, 原始错误信息:\n%@\n", (long)self.code, [self.userInfo objectForKey:NSLocalizedDescriptionKey]];
#endif
    return self.errMsg ? self.errMsg : [NSString stringWithFormat:@"未知错误, 错误码%ld", (long)self.code];
}

@end


@implementation BaseRequest
static BaseRequest *baseRequest = nil;

+ (BaseRequest *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (baseRequest == nil) {
            baseRequest = [[self alloc]init];
        }
    });
    
    return baseRequest;
}

+ (void)netWorkStatus{
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            return ;
        }
    }];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (baseRequest == nil) {
            baseRequest = [super allocWithZone:zone];
        }
    });
    return baseRequest;
}

//+ (NSMutableDictionary *)appendDefaultPars:(NSDictionary *)pars isNeedLocation:(BOOL)isNeedLocation{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    UserAddressModel *model = [UserDefaultControl shareInstance].cacheUserAddrModel;
//}

- (instancetype)copyWithZone:(NSZone *)zone{
    return baseRequest;
}

+ (NSError *)errorWithApiErrorCode:(long)errCode errMsg:(NSString *)errMsg{
    NSError *err = [NSError errorWithDomain:@"com.line0.err" code:errCode userInfo:nil];
    err.errMsg = errMsg;
    return err;
}

- (AFHTTPSessionManager *)createAFHTTPSessionManager{
    AFHTTPSessionManager    *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@"http://handset.line0.com/ws/handset/v10/"]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"69" forHTTPHeaderField:@"version"];
    [manager.requestSerializer setValue:@"3" forHTTPHeaderField:@"platform"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"deviceType"];
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"registrationId"];
    [manager.requestSerializer setValue:@([[NSDate date] timeIntervalSince1970]).stringValue forHTTPHeaderField:@"requestTimeStr"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    return manager;
}


- (void)GET:(NSString *)path params:(NSDictionary *)params completeBlock:(void (^)(BOOL isSuccess, NSDictionary *dict,NSError *err))completeBlock{
    [self requestWithApi:RequestTypeGET path:path params:params completeBlock:completeBlock];
}

- (void)POST:(NSString *)path params:(NSDictionary *)params completeBlock:(void (^)(BOOL isSuccess, NSDictionary *dict,NSError *err))completeBlock{
    //参数加密
    NSDictionary *finalParma = @{@"encryptedData":[DES3Util encrypt:[params jsonEncodedKeyValueString]]};
    
    NSString *strPath = [path stringByAppendingString:@"ForAPP"];
    [self requestWithApi:RequestTypePOST path:strPath params:finalParma completeBlock:completeBlock];
}

- (void)ImgPOST:(NSString *)path params:(NSDictionary *)params files:(NSDictionary *)files completeBlock:(void (^)(BOOL isSuccess, NSDictionary *dict,NSError *err))completeBlock{
    
}



- (void)requestWithApi:(RequestType)requestType  path:(NSString *)path params:(NSDictionary *)params completeBlock:(void (^)(BOOL isSuccess, NSDictionary *dict,NSError *err))completeBlock{
//    AFHTTPSessionManager *manager  = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@"http://handset.line0.com/ws/handset/v10/"]];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    AFHTTPSessionManager    *manager = [self createAFHTTPSessionManager];
    
    __block id responseDict = nil;
    __block NSError *err = nil;
    __block BOOL  isSuccess = YES;
    if (requestType == RequestTypeGET) {
        [manager GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            completeBlock(NO,nil,error);
        }];
    }else if (requestType == RequestTypePOST){
        [manager POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            responseDict = [responseObject responseJSONDES3];
            if (![responseDict isKindOfClass:[NSDictionary class]]) {
                err = [BaseRequest errorWithApiErrorCode:-1000 errMsg:@"未知错误"];
                isSuccess = NO;
            }else{
                NSDictionary *respDict = [responseDict safeBindValue:@"response"];
                if (![respDict isKindOfClass:[NSDictionary class]]) {
                    err = [BaseRequest errorWithApiErrorCode:-101 errMsg:@"返回response数据格式错误"];
                    isSuccess = NO;
                }else{
                    int errCode = [[respDict safeBindStringValue:@"errorCode"]intValue];
                    NSString *errMsg = [respDict safeBindStringValue:@"msg"];
                    if (errCode != 1) {
                        err = [BaseRequest errorWithApiErrorCode:errCode errMsg:errMsg];
                        isSuccess = NO;
                    }
                }
            }
            
            if (completeBlock) {
                completeBlock(isSuccess,responseDict,err);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            completeBlock(NO,nil,error);
        }];
        NSString *logStr = [NSString stringWithFormat:@"%@\nRequest\n-------\nurl:%@%@\nparams:%@\n--------\nResponse\n--------\n%@\n",[[NSDate date] descriptionWithLocale:[NSLocale currentLocale]],@"http://handset.line0.com/ws/handset/v10/",path,[DES3Util decrypt:[params safeBindStringValue:@"encryptedData"]],err.errMsg];
        NSLog(@"%@",logStr);
    }
}


@end
