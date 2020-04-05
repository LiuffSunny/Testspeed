//
//  GSNetworkSpeed.h
//  STPingTest
//
//  Created by LiuffSunny on 2019/5/6.
//  Copyright © 2019 Suen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// 88kB/s
extern NSString *const GSDownloadNetworkSpeedNotificationKey;
// 2MB/s
extern NSString *const GSUploadNetworkSpeedNotificationKey;

@interface GSNetworkSpeed : NSObject
@property (nonatomic, copy, readonly) NSString *downloadNetworkSpeed;
@property (nonatomic, copy, readonly) NSString *uploadNetworkSpeed;
+ (instancetype)shareNetworkSpeed;
- (void)start;
- (void)stop;
@end

NS_ASSUME_NONNULL_END
