//
//  KSS3ListPartsRequest.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3ListPartsRequest.h"
#import "KS3Client.h"
#import "KS3Constants.h"

@implementation KS3ListPartsRequest

- (instancetype _Nonnull)initWithMultipartUpload:(KS3MultipartUpload * _Nonnull)multipartUpload {
  if (self = [self init]) {
    self.bucket = [self URLEncodedString:multipartUpload.bucket];
    self.key = [self URLEncodedString:multipartUpload.key];
    self.uploadId = multipartUpload.uploadId;
    self.contentMd5 = @"";
    self.contentType = @"";
    self.maxParts = 1000; // **** default value
    self.httpMethod = kHttpMethodGet;
    self.kSYResource = [NSString stringWithFormat:@"/%@", self.bucket];
    //
    self.kSYResource =
        [NSString stringWithFormat:@"%@/%@?uploadId=%@", self.kSYResource,
                                   self.key, self.uploadId];
  }
  return self;
}

- (NSMutableURLRequest * _Nonnull)configureURLRequest {
  KS3Client *ks3Client = [KS3Client initialize];
  NSString *customBucketDomain = [ks3Client getCustomBucketDomain];
  if (customBucketDomain != nil) {
    self.host =
        [NSString stringWithFormat:@"%@://%@/%@?uploadId=%@",
                                   [[KS3Client initialize] requestProtocol],
                                   customBucketDomain, self.key, self.uploadId];
  } else {
    self.host = [NSString
        stringWithFormat:@"%@://%@.%@/%@?uploadId=%@",
                         [[KS3Client initialize] requestProtocol], self.bucket,
                         [[KS3Client initialize] getBucketDomain], self.key,
                         self.uploadId];
  }

  NSMutableString *subresource = [NSMutableString stringWithCapacity:512];
  if (self.maxParts != 1000) { // **** default is 1000
    [subresource appendFormat:@"&%@=%d", kKS3QueryParamMaxParts, self.maxParts];
  }
  if (self.partNumberMarker != 0) {
    [subresource appendFormat:@"&%@=%d", kKS3QueryParamPartNumberMarker,
                              self.partNumberMarker];
  }
  if (nil != _encodingType) {
    if (subresource.length > 0) {
      [subresource appendString:@"&"];
    }
    [subresource
        appendFormat:@"%@=%@", kKS3QueryParamEncodingType, _encodingType];
  }
  if (subresource.length > 0) {
    self.host = [NSString stringWithFormat:@"%@%@", self.host, subresource];
  }
  [super configureURLRequest];
  [self.urlRequest setHTTPMethod:kHttpMethodGet];
  return self.urlRequest;
}

@end
