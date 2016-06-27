//
//  YQNetworkStatus.m
//  NetWorkStatus
//
//  Created by 尹永奇 on 16/6/24.
//  Copyright © 2016年 尹永奇. All rights reserved.
//

#import "YQNetworkStatus.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "Reachability.h"

@interface YQNetworkStatus ()

@property (nonatomic ,strong)CTTelephonyNetworkInfo *telephonyNetworkInfo;

@property (nonatomic ,strong)Reachability *reachability;

@property (nonatomic ,strong)NSString *currentRaioAccess;

/** 2G数组 */
@property (nonatomic,strong) NSArray *technology2GArray;

/** 3G数组 */
@property (nonatomic,strong) NSArray *technology3GArray;

/** 4G数组 */
@property (nonatomic,strong) NSArray *technology4GArray;

/**
 *  网络状态类型字符串
 */
@property (nonatomic ,strong)NSArray *networkStatusStringArray;

@property (nonatomic ,copy)NetworkStatusChangeBlock block;

@end

@implementation YQNetworkStatus

+(YQNetworkStatus *)shareNetworkStatus{
    static dispatch_once_t pred = 0;
    __strong static id _shareObject = nil;
    dispatch_once(&pred, ^{
        
        _shareObject = [[self alloc] init];
    });

    return _shareObject;
}

+(YQNetworkStatusType)currentNetworkStatus{

    YQNetworkStatus *networkStatus = [YQNetworkStatus shareNetworkStatus];

    return [networkStatus netWorkStatusWithRadioAccessTechnology];
}

+(NSString *)currentNetworkStatusString{
    YQNetworkStatus *networkStatus = [YQNetworkStatus shareNetworkStatus];
    
    return [networkStatus.networkStatusStringArray objectAtIndex:[self currentNetworkStatus]];
}

- (YQNetworkStatusType)netWorkStatusWithRadioAccessTechnology{

    YQNetworkStatusType status = (YQNetworkStatusType)[self.reachability currentReachabilityStatus];
    
    NSString *technology = self.currentRaioAccess;
    
    if (status == YQNetworkStatusTypeWWAN && technology !=nil) {
        
        if ([self.technology2GArray containsObject:technology]) {//2G
            
            status = YQNetworkStatusType2G;
        
        }else if([self.technology3GArray containsObject:technology]){//3G
        
            status = YQNetworkStatusType3G;
            
        }else if([self.technology4GArray containsObject:technology]){//4G
        
            status = YQNetworkStatusType4G;
        }
        
    }
    
    return status;
}

+ (void)beginListeningInObject:(id)listener handle:(NetworkStatusChangeBlock)handle{

    YQNetworkStatus *status = [YQNetworkStatus shareNetworkStatus];
    
    [self stopListeningInObject:listener];
    
    status.block = [handle copy];
    
    //注册监听
    
    [NSNotificationCenter.defaultCenter addObserverForName:kReachabilityChangedNotification
                                                    object:nil
                                                     queue:nil
                                                usingBlock:^(NSNotification *note)
     {
         handle([self currentNetworkStatusString],[self currentNetworkStatus]);
     }];
    
    
    [status.reachability startNotifier];
    
}

+(void)stopListeningInObject:(id)listener{

    YQNetworkStatus *status = [YQNetworkStatus shareNetworkStatus];
    
    status.block = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:status name:kReachabilityChangedNotification object:nil];
    [status.reachability stopNotifier];
}


-(Reachability *)reachability{
    
    if(_reachability == nil){
        
        _reachability = [Reachability reachabilityForInternetConnection];
    }
    
    return _reachability;
}


-(CTTelephonyNetworkInfo *)telephonyNetworkInfo{
    
    if(_telephonyNetworkInfo == nil){
        
        _telephonyNetworkInfo = [[CTTelephonyNetworkInfo alloc] init];
        
    }
    return _telephonyNetworkInfo;
}

-(NSString *)currentRaioAccess{
    
    if(_currentRaioAccess == nil){
        
        _currentRaioAccess = self.telephonyNetworkInfo.currentRadioAccessTechnology;
    }
    
    return _currentRaioAccess;
}

-(NSArray *)technology2GArray{
    
    if (_technology2GArray == nil) {
        _technology2GArray = @[CTRadioAccessTechnologyEdge,CTRadioAccessTechnologyGPRS];
    }
    return _technology2GArray;
}


-(NSArray *)technology3GArray{
    
    if (_technology3GArray == nil) {
        _technology3GArray = @[CTRadioAccessTechnologyWCDMA,
                               CTRadioAccessTechnologyHSDPA,
                               CTRadioAccessTechnologyHSUPA,
                               CTRadioAccessTechnologyCDMA1x,
                               CTRadioAccessTechnologyCDMAEVDORev0,
                               CTRadioAccessTechnologyCDMAEVDORevA,
                               CTRadioAccessTechnologyCDMAEVDORevB,
                               CTRadioAccessTechnologyeHRPD];
    }
    
    return _technology3GArray;
}

-(NSArray *)technology4GArray{

    if (_technology4GArray == nil) {
        _technology4GArray = @[CTRadioAccessTechnologyLTE];
    }
    return _technology4GArray;
}

-(NSArray *)networkStatusStringArray{

    if (_networkStatusStringArray == nil) {
        
        _networkStatusStringArray = @[@"无网络",@"Wifi",@"蜂窝网",@"2G",@"3G",@"4G",@"未知网络"];
    }
    
    return _networkStatusStringArray;
}



@end
