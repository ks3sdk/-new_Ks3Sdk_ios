//
//  KSS3ListPartsResponse.h
//  KS3SDK
//
//  Created by JackWong on 12/15/14.
//  Copyright (c) 2014 kingsoft. All rights reserved.
//

#import "KS3ListPartsResult.h"
#import "KS3Response.h"
NS_ASSUME_NONNULL_BEGIN
@class KS3ListPartsResult;
@interface KS3ListPartsResponse : KS3Response

@property(strong, nonatomic) KS3ListPartsResult *listResult;
@end
NS_ASSUME_NONNULL_END
