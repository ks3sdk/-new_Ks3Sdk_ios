//
//  KSS3InitiateMultipartUploadResponse.h
//  KS3SDK
//
//  Created by JackWong on 12/15/14.
//  Copyright (c) 2014 kingsoft. All rights reserved.
//

#import "KS3MultipartUpload.h"
#import "KS3Response.h"
NS_ASSUME_NONNULL_BEGIN
@interface KS3InitiateMultipartUploadResponse : KS3Response
@property(nonatomic, strong) KS3MultipartUpload *multipartUpload;
@end
NS_ASSUME_NONNULL_END
