//
//  BaseRequest.h
//  EBook
//
//  Created by juanmao on 16/11/30.
//  Copyright © 2016年 juanmao. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger,RequestType){
    RequestTypeGET = 1,     //GET请求
    
    RequestTypePOST = 2,    //POST请求
    
};

    ///请求成功回调
typedef void (^requestSuccessBlock)(NSDictionary *dict);

    ///请求失败回调
typedef void (^requestFailBlock)(NSError *error);

@interface NSError(Ext)
/// 扩展属性
@property(nonatomic, strong) NSString *errMsg;

@end

@interface BaseRequest : AFHTTPSessionManager

+ (instancetype)shareInstance;

+ (void)netWorkStatus;

- (void)GET:(NSString *)path params:(NSDictionary *)params completeBlock:(void (^)(BOOL isSuccess, NSDictionary *dict,NSError *err))completeBlock;

- (void)POST:(NSString *)path params:(NSDictionary *)params completeBlock:(void (^)(BOOL isSuccess, NSDictionary *dict,NSError *err))completeBlock;

- (void)ImgPOST:(NSString *)path params:(NSDictionary *)params files:(NSDictionary *)files completeBlock:(void (^)(BOOL isSuccess,NSDictionary *dict,NSError *err))completeBlock;

- (NSMutableDictionary *)defaultPars:(NSDictionary *)pars isNeedLocation:(BOOL)isNeedLocation;

- (void)requestWithApi:(RequestType)requestType
                  path:(NSString *)path
                params:(NSDictionary *)params
          successBlock:(requestSuccessBlock)success
             failBlock:(requestFailBlock)fail;
@end
