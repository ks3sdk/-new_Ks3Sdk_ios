//
//  KSS3InitiateMultipartUploadResult.h
//  KS3SDK
//
//  Created by JackWong on 12/15/14.
//  Copyright (c) 2014 kingsoft. All rights reserved.
//

#import "KS3MultipartUpload.h"
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface KS3InitiateMultipartUploadResult : NSObject
@property(strong, nonatomic) KS3MultipartUpload *multipartUpload;
@end
NS_ASSUME_NONNULL_END
