//
//  YQNetworkStatus.h
//  NetWorkStatus
//
//  Created by 尹永奇 on 16/6/24.
//  Copyright © 2016年 尹永奇. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 网络的状态
 */
typedef enum : NSUInteger {
    YQNetworkStatusTypeNone = 0,//无网络
    YQNetworkStatusTypeWifi,//wifi
    YQNetworkStatusTypeWWAN,//蜂窝网
    YQNetworkStatusType2G,//2G
    YQNetworkStatusType3G,//3G
    YQNetworkStatusType4G,//4G
    YQNetworkStatusTypeUnkhow //未知
} YQNetworkStatusType;

typedef void(^NetworkStatusChangeBlock)(NSString *statusString , YQNetworkStatusType type);

@interface YQNetworkStatus : NSObject

+ (YQNetworkStatus *)shareNetworkStatus;

/**
 *  获取当前网络状态，返回当前网络状态的枚举
 *
 *  @return 网络状态的枚举
 */
+ (YQNetworkStatusType)currentNetworkStatus;

/**
 *  获取当前网络状态，返回当前网络状态的字符串如：2G  3G 4G
 *
 *  @return 网络状态字符串
 */
+ (NSString *)currentNetworkStatusString;

/**
 *  开始监听网络改变 当网络状态改变时。回调通知
 *
 *  @param listener 监听者
 *  @param handle   网络状态改变之后的回调
 */
+ (void)beginListeningInObject:(id)listener handle:(NetworkStatusChangeBlock)handle;

/**
 *  结束监听网络
 */
+ (void)stopListeningInObject:(id)listener;

@end
