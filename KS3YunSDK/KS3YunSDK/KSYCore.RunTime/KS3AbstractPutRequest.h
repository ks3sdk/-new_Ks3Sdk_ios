//
//  KSS3AbstractPutRequest.h
//  KS3SDK
//
//  Created by JackWong on 12/15/14.
//  Copyright (c) 2014 kingsoft. All rights reserved.
//

#import "KS3Request.h"
NS_ASSUME_NONNULL_BEGIN
@interface KS3AbstractPutRequest : KS3Request

- (void)addMetadataWithValue:(NSString *)value forKey:(NSString *)aKey;

@end
NS_ASSUME_NONNULL_END
