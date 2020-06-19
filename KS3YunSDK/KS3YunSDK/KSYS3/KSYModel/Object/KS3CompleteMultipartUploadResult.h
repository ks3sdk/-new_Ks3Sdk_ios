//
//  KSS3CompleteMultipartUploadResult.h
//  KS3SDK
//
//  Created by JackWong on 12/15/14.
//  Copyright (c) 2014 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface KS3CompleteMultipartUploadResult : NSObject

@property(nonatomic, strong) NSString *location;

@property(nonatomic, strong) NSString *bucket;

@property(nonatomic, strong) NSString *key;

@property(nonatomic, strong) NSString *etag;
@end
NS_ASSUME_NONNULL_END
