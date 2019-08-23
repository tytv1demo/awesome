//
//  YTVideoList+bridge.m
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/23/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"
#import "React/RCTEventEmitter.h"

@interface RCT_EXTERN_MODULE(YTVideoListManager, RCTEventEmitter)
RCT_EXTERN_METHOD(pushToDetail);
@end
