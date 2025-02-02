//
//  KSS3ListObjectsRequest.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3Request.h"

@interface KS3ListObjectsRequest : KS3Request

@property(strong, nonatomic, nullable) NSString *prefix;
@property(strong, nonatomic, nullable) NSString *marker;
@property(nonatomic) int32_t maxKeys;
@property(nonatomic, retain) NSString *delimiter;
@property(strong, nonatomic, nullable) NSString *encodingType;

- (instancetype _Nullable)initWithName:(NSString * _Nullable)bucketName;

@end
