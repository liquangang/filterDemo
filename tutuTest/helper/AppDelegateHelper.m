//
//  AppDelegateHelper.m
//  tutuTest
//
//  Created by liquangang on 2017/3/29.
//  Copyright © 2017年 必要. All rights reserved.
//

#import "AppDelegateHelper.h"
#import <TuSDK/TuSDK.h>

#define TuTuAppKey @"002f16b7bb5dbf25-00-265qq1"

@implementation AppDelegateHelper

#pragma mark - appInit
- (void)appSetUp{
    
    // 初始化SDK (请前往 http://tusdk.com 获取您的 APP 开发密钥)
    [TuSDK initSdkWithAppKey:TuTuAppKey];
    
    //打开tusdk的调试日志功能
    [TuSDK setLogLevel:lsqLogLevelDEBUG];
}

@end
