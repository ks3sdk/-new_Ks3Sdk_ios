//
//  KingSoftAuthUtils.h
//  KS3SDK
//
//  Created by JackWong on 12/9/14.
//  Copyright (c) 2014 kingsoft. All rights reserved.
//

#import "KS3AuthUtils.h"
#import <Foundation/Foundation.h>
typedef enum {
    KSS3_HTTPVerbGet,
    KSS3_HTTPVerbPost,
    KSS3_HTTPVerbPut,
    KSS3_HTTPVerbDelete,
    KSS3_HTTPVerbHead,
} KSS3_HTTPVerbType;

@class KS3ServiceRequest;
@class KS3Credentials;
@class KS3URLRequest;

@interface KS3AuthUtils : NSObject

+ (NSString *)KSYSignatureWithSecretKey:(NSString *)secretKey
                               httpVerb:(NSString *)httpVerb
                             contentMd5:(NSString *)strContentMd5
                            contentType:(NSString *)strContentType
                                   date:(NSDate *)date
                 canonicalizedKssHeader:(NSString *)strHeaders
                  canonicalizedResource:(NSString *)strResource;

+ (NSString *)KSYSignatureWithSecretKey:(NSString *)secretKey
                               httpVerb:(NSString *)httpVerb
                             contentMd5:(NSString *)strContentMd5
                            contentType:(NSString *)strContentType
                                strDate:(NSString *)strDate
                 canonicalizedKssHeader:(NSString *)strHeaders
                  canonicalizedResource:(NSString *)strResource;

+ (NSString *)KSYAuthorizationWithAccessKey:(NSString *)accessKey
                                  secretKey:(NSString *)secretKey
                               httpVerbType:(KSS3_HTTPVerbType)httpVerb
                                 contentMd5:(NSString *)strContentMd5
                                contentType:(NSString *)strContentType
                                       date:(NSDate *)date
                     canonicalizedKssHeader:(NSString *)strHeaders
                      canonicalizedResource:(NSString *)strResource;

+ (NSString *)strDateWithDate:(NSDate *)date andType:(NSString *)strType;

+ (void)signRequestV4:(KS3ServiceRequest *)serviceRequest
           urlRequest:(KS3URLRequest *)urlRequest
              headers:(NSMutableDictionary *)headers
              payload:(NSString *)payload
          credentials:(KS3Credentials *)credentials;

+ (NSString *)KSYAuthorizationWithAccessKey:(NSString *)accessKey
                                  secretKey:(NSString *)secretKey
                                   httpVerb:(NSString *)httpVerb
                                 contentMd5:(NSString *)strContentMd5
                                contentType:(NSString *)strContentType
                                       date:(NSDate *)date
                     canonicalizedKssHeader:(NSString *)strHeaders
                      canonicalizedResource:(NSString *)strResource;

+ (NSString *)KSYAuthorizationWithAccessKey:(NSString *)accessKey
                                  secretKey:(NSString *)secretKey
                                   httpVerb:(NSString *)httpVerb
                                 contentMd5:(NSString *)strContentMd5
                                contentType:(NSString *)strContentType
                                    strDate:(NSString *)strDate
                     canonicalizedKssHeader:(NSString *)strHeaders
                      canonicalizedResource:(NSString *)strResource;

@end
