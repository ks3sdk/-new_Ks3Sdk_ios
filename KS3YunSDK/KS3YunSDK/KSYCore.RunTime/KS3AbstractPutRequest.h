//
//  KSS3AbstractPutRequest.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3Request.h"
NS_ASSUME_NONNULL_BEGIN
@interface KS3AbstractPutRequest : KS3Request

- (void)addMetadataWithValue:(NSString * _Nullable)value forKey:(NSString * _Nullable)aKey;

@end
NS_ASSUME_NONNULL_END
