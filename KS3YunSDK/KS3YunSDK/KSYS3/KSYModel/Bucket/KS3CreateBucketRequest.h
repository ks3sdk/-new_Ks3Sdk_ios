//
//  KSS3CreateBucketRequest.h
//  KS3SDK
//
//  Created by JackWong on 12/12/14.
//  Copyright (c) 2014 kingsoft. All rights reserved.
//

#import "KS3Request.h"
@interface KS3CreateBucketRequest : KS3Request
- (instancetype)initWithName:(NSString *)bucketName;
@end
