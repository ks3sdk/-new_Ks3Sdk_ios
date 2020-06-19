//
//  KSS3GetObjectACLResponse.h
//  KS3SDK
//
//  Created by JackWong on 12/15/14.
//  Copyright (c) 2014 kingsoft. All rights reserved.
//

#import "KS3Response.h"
NS_ASSUME_NONNULL_BEGIN
@class KS3BucketACLResult;
@interface KS3GetObjectACLResponse : KS3Response
@property(nonatomic, strong) KS3BucketACLResult *listBucketsResult;
@end
NS_ASSUME_NONNULL_END
