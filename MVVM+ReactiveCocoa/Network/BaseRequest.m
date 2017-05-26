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

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (baseRequest == nil) {
            baseRequest = [[self alloc]initWithBaseURL:[NSURL URLWithString:kBaseUrl]];
        }
    });
    
    return baseRequest;
}

-(instancetype)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [self.requestSerializer setValue:@"69" forHTTPHeaderField:@"version"];
        [self.requestSerializer setValue:@"3" forHTTPHeaderField:@"platform"];
        [self.requestSerializer setValue:@"3" forHTTPHeaderField:@"source"];
        [self.requestSerializer setValue:@"1" forHTTPHeaderField:@"deviceType"];
        [self.requestSerializer setValue:@"" forHTTPHeaderField:@"registrationId"];
        [self.requestSerializer setValue:@([[NSDate date] timeIntervalSince1970]).stringValue forHTTPHeaderField:@"requestTimeStr"];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                                       @"text/html",
                                                                                       @"text/json",
                                                                                       @"text/plain",
                                                                                       @"text/javascript",
                                                                                       @"text/xml",
                                                                                       @"image/*"]];
        self.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        self.securityPolicy.allowInvalidCertificates = YES;

    }
    return self;
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

- (NSMutableDictionary *)defaultPars:(NSDictionary *)pars isNeedLocation:(BOOL)isNeedLocation{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"1" forKey:@"cityId"];
    [params setObject:@"" forKey:@"userToken"];
    [params setObject:@"3" forKey:@"deviceType"];
    [params setObject:@"3" forKey:@"source"];
    
    if (isNeedLocation)
    {
        [params setObject:@"118.8067112198866" forKey:@"userX"];
        [params setObject:@"32.03299303289314" forKey:@"userY"];
    }
    
    if (pars && [pars isKindOfClass:[NSDictionary class]])
    {
        [params addEntriesFromDictionary:pars];
    }
    return params;
}

- (instancetype)copyWithZone:(NSZone *)zone{
    return baseRequest;
}

+ (NSError *)errorWithApiErrorCode:(long)errCode errMsg:(NSString *)errMsg{
    NSError *err = [NSError errorWithDomain:@"com.line0.err" code:errCode userInfo:nil];
    err.errMsg = errMsg;
    return err;
}

//- (AFHTTPSessionManager *)createAFHTTPSessionManager{
//    self.manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:kBaseUrl]];
//    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [self.manager.requestSerializer setValue:@"69" forHTTPHeaderField:@"version"];
//    [self.manager.requestSerializer setValue:@"3" forHTTPHeaderField:@"platform"];
//    [self.manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"deviceType"];
//    [self.manager.requestSerializer setValue:@"" forHTTPHeaderField:@"registrationId"];
//    [self.manager.requestSerializer setValue:@([[NSDate date] timeIntervalSince1970]).stringValue forHTTPHeaderField:@"requestTimeStr"];
//    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
//                                                                              @"text/html",
//                                                                              @"text/json",
//                                                                              @"text/plain",
//                                                                              @"text/javascript",
//                                                                              @"text/xml",
//                                                                              @"image/*"]];
//    self.manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
//    return self.manager;
//}


//- (void)GET:(NSString *)path params:(NSDictionary *)params completeBlock:(void (^)(BOOL isSuccess, NSDictionary *dict,NSError *err))completeBlock{
//    [self requestWithApi:RequestTypeGET path:path params:params completeBlock:completeBlock];
//}
//
//- (void)POST:(NSString *)path params:(NSDictionary *)params completeBlock:(void (^)(BOOL isSuccess, NSDictionary *dict,NSError *err))completeBlock{
//    //参数加密
//    NSDictionary *finalParma = @{@"encryptedData":[DES3Util encrypt:[params jsonEncodedKeyValueString]]};
//    
//    NSString *strPath = [path stringByAppendingString:@"ForAPP"];
//    [self requestWithApi:RequestTypePOST path:strPath params:finalParma completeBlock:completeBlock];
//    
//}
//
//- (void)ImgPOST:(NSString *)path params:(NSDictionary *)params files:(NSDictionary *)files completeBlock:(void (^)(BOOL isSuccess, NSDictionary *dict,NSError *err))completeBlock{
//    
//}



- (void)requestWithApi:(RequestType)requestType
                  path:(NSString *)path
                params:(NSDictionary *)params
          successBlock:(requestSuccessBlock)success
             failBlock:(requestFailBlock)fail{
    if (requestType == RequestTypeGET) {
        [self GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            fail(error);
        }];

    }else if (requestType == RequestTypePOST){
        //参数加密
        NSDictionary *finalParma = @{@"encryptedData":@"41ABWFEFDww0K/UfVdio86CL9SODzPx48qT/8SPeM8hqahvpcPSFPH5uecvnn6PuWCfG2Jf4/2QuM9bAke48ntcOOHogEhOLREs2Lsh5Tm1a/rYklZTjnunVMThtyRQrTilXZwDLs5vLbZDpgt4Do8OX/cUqUtzVGsq2PUJyBc72nlSZW0vrAgkGd5zpYLVfiPhAVF8UumGFKERIpytGAQ=="};
        
        NSString *strPath = [path stringByAppendingString:@"ForAPP"];
        [self POST:strPath parameters:finalParma progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            id responseDict = [responseObject responseJSONDES3];
            NSString *logStr = [NSString stringWithFormat:@"%@\nRequest\n-------\nurl:%@%@\nparams:%@\n--------\nResponse\n--------\n%@\n",[[NSDate date] descriptionWithLocale:[NSLocale currentLocale]],kBaseUrl,strPath,[DES3Util decrypt:[finalParma safeBindStringValue:@"encryptedData"]],[DES3Util decrypt:[[NSString alloc] initWithData:responseDict encoding:NSUTF8StringEncoding]]];
            NSLog(@"%@",logStr);
            BOOL isSuccess = YES;
            NSError *err = nil;
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
            if (isSuccess) {
                success(responseDict);
            }else{
                fail(err);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSString *logStr = [NSString stringWithFormat:@"%@\nRequest\n-------\nurl:%@%@\nparams:%@\n--------\nResponse\n--------\n%@\n",[[NSDate date] descriptionWithLocale:[NSLocale currentLocale]],kBaseUrl,strPath,[DES3Util decrypt:[finalParma safeBindStringValue:@"encryptedData"]],error];
            NSLog(@"%@",logStr);
            fail(error);
        }];
    }
}


@end
