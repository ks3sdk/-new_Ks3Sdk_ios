//
//  KingSoftAuthUtils.m
//  KS3SDK
//
//  Created by JackWong on 12/9/14.
//  Copyright (c) 2014 kingsoft. All rights reserved.
//

#import "KS3AuthUtils.h"
#import "KS3Constants.h"
#import "KS3MD5Util.h"
#import "KS3ServiceRequest.h"

@implementation KS3AuthUtils

+ (NSString *)strAuthorizationWithHTTPVerb:(NSString *)accessKey
                                 secretKey:(NSString *)secretKey
                                  httpVerb:(KSS3_HTTPVerbType)httpVerb
                                contentMd5:(NSString *)strContentMd5
                               contentType:(NSString *)strContentType
                                      date:(NSDate *)date
                    canonicalizedKssHeader:(NSString *)strHeaders
                     canonicalizedResource:(NSString *)strResource {
    NSString *strAuthorization = @"KSS ";
    strAuthorization = [strAuthorization stringByAppendingString:accessKey];
    strAuthorization = [strAuthorization stringByAppendingString:@":"];
    NSString *strSignature = [self strSignatureWithHTTPVerb:secretKey
                                                   httpVerb:httpVerb
                                                 contentMd5:strContentMd5
                                                contentType:strContentType
                                                       date:date
                                     canonicalizedKssHeader:strHeaders
                                      canonicalizedResource:strResource];
    strAuthorization = [strAuthorization stringByAppendingString:strSignature];
    return strAuthorization;
}

+ (NSString *)strSignatureWithHTTPVerb:(NSString *)secretKey
                              httpVerb:(KSS3_HTTPVerbType)httpVerb
                            contentMd5:(NSString *)strContentMd5
                           contentType:(NSString *)strContentType
                                  date:(NSDate *)date
                canonicalizedKssHeader:(NSString *)strHeaders
                 canonicalizedResource:(NSString *)strResource {
    // **** Http verb
    NSString *strHttpVerb = @"GET";
    switch (httpVerb) {
        case KSS3_HTTPVerbGet:
            strHttpVerb = @"GET";
            break;
        case KSS3_HTTPVerbPost:
            strHttpVerb = @"POST";
            break;
        case KSS3_HTTPVerbPut:
            strHttpVerb = @"PUT";
            break;
        case KSS3_HTTPVerbDelete:
            strHttpVerb = @"DELETE";
            break;
        default:
            break;
    }
    strHttpVerb = [strHttpVerb stringByAppendingString:@"\n"];

    // **** Content md5
    strContentMd5 = [strContentMd5 stringByAppendingString:@"\n"];

    // **** Content type
    strContentType = [strContentType stringByAppendingString:@"\n"];

    // **** Date
    NSString *strDate = [self strDateWithDate:date andType:@"GMT"];
    strDate = [strDate stringByAppendingString:@"\n"];

    // **** Header & Resource
    //    strHeaders = [strHeaders stringByAppendingString:@"\n"];

    // **** Signature
    NSString *strToSig = [strHttpVerb stringByAppendingString:strContentMd5];
    strToSig = [strToSig stringByAppendingString:strContentType];
    strToSig = [strToSig stringByAppendingString:strDate];
    strToSig = [strToSig stringByAppendingString:strHeaders];
    strToSig = [strToSig stringByAppendingString:strResource];
    strToSig = [KS3MD5Util hexEncode:secretKey text:strToSig];
    return strToSig;
}

+ (NSString *)strDateWithDate:(NSDate *)date andType:(NSString *)strType {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateFormatter setDateFormat:@"EEE, d MMM yyyy HH:mm:ss"];
    NSString *str = [dateFormatter stringFromDate:date];
    NSString *strTime = [str stringByAppendingFormat:@" %@", strType];
    return strTime;
}

+ (NSString *)KSYSignatureWithSecretKey:(NSString *)secretKey
                               httpVerb:(NSString *)httpVerb
                             contentMd5:(NSString *)strContentMd5
                            contentType:(NSString *)strContentType
                                   date:(NSDate *)date
                 canonicalizedKssHeader:(NSString *)strHeaders
                  canonicalizedResource:(NSString *)strResource {
    return [KS3AuthUtils KSYSignatureWithSecretKey:secretKey
                                          httpVerb:httpVerb
                                        contentMd5:strContentMd5
                                       contentType:strContentType
                                           strDate:[self strDateWithDate:date andType:@"GMT"]
                            canonicalizedKssHeader:strHeaders
                             canonicalizedResource:strResource];
}

+ (NSString *)KSYSignatureWithSecretKey:(NSString *)secretKey
                               httpVerb:(NSString *)httpVerb
                             contentMd5:(NSString *)strContentMd5
                            contentType:(NSString *)strContentType
                                strDate:(NSString *)strDate
                 canonicalizedKssHeader:(NSString *)strHeaders
                  canonicalizedResource:(NSString *)strResource {
    // **** Signature
    NSString *strToSig = httpVerb;
    strToSig = [strToSig stringByAppendingString:@"\n"];

    if(strContentMd5) {
        strToSig = [strToSig stringByAppendingString:strContentMd5];
    }
    strToSig = [strToSig stringByAppendingString:@"\n"];

    if(strContentType) {
        strToSig = [strToSig stringByAppendingString:strContentType];
    }
    strToSig = [strToSig stringByAppendingString:@"\n"];

    strToSig = [strToSig stringByAppendingString:strDate];
    strToSig = [strToSig stringByAppendingString:@"\n"];

    if ([strHeaders stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0) {
        strToSig = [strToSig stringByAppendingString:strHeaders];
        strToSig = [strToSig stringByAppendingString:@"\n"];
    }

    strToSig = [strToSig stringByAppendingString:strResource];

    NSLog(@"StringToSign: %@", strToSig);

    strToSig = [KS3MD5Util hexEncode:secretKey text:strToSig];
    return strToSig;
}

+ (NSString *)KSYAuthorizationWithAccessKey:(NSString *)accessKey
                                  secretKey:(NSString *)secretKey
                               httpVerbType:(KSS3_HTTPVerbType)httpVerb
                                 contentMd5:(NSString *)strContentMd5
                                contentType:(NSString *)strContentType
                                       date:(NSDate *)date
                     canonicalizedKssHeader:(NSString *)strHeaders
                      canonicalizedResource:(NSString *)strResource {
    NSString *strHttpVerb = @"GET";
    switch (httpVerb) {
        case KSS3_HTTPVerbGet:
            strHttpVerb = @"GET";
            break;
        case KSS3_HTTPVerbPost:
            strHttpVerb = @"POST";
            break;
        case KSS3_HTTPVerbPut:
            strHttpVerb = @"PUT";
            break;
        case KSS3_HTTPVerbDelete:
            strHttpVerb = @"DELETE";
            break;
        default:
            break;
    }

    return [self KSYAuthorizationWithAccessKey:accessKey
                                     secretKey:secretKey
                                      httpVerb:strHttpVerb
                                    contentMd5:strContentMd5
                                   contentType:strContentType
                                          date:date
                        canonicalizedKssHeader:strHeaders
                         canonicalizedResource:strResource];
}

+ (NSString *)KSYAuthorizationWithAccessKey:(NSString *)accessKey
                                  secretKey:(NSString *)secretKey
                                   httpVerb:(NSString *)httpVerb
                                 contentMd5:(NSString *)strContentMd5
                                contentType:(NSString *)strContentType
                                       date:(NSDate *)date
                     canonicalizedKssHeader:(NSString *)strHeaders
                      canonicalizedResource:(NSString *)strResource {
    NSString *strAuthorization = @"KSS ";
    strAuthorization = [strAuthorization stringByAppendingString:accessKey];
    strAuthorization = [strAuthorization stringByAppendingString:@":"];
    NSString *strSignature = [self KSYSignatureWithSecretKey:secretKey
                                                    httpVerb:httpVerb
                                                  contentMd5:strContentMd5
                                                 contentType:strContentType
                                                        date:date
                                      canonicalizedKssHeader:strHeaders
                                       canonicalizedResource:strResource];
    strAuthorization = [strAuthorization stringByAppendingString:strSignature];
    return strAuthorization;
}

+ (NSString *)KSYAuthorizationWithAccessKey:(NSString *)accessKey
                                  secretKey:(NSString *)secretKey
                                   httpVerb:(NSString *)httpVerb
                                 contentMd5:(NSString *)strContentMd5
                                contentType:(NSString *)strContentType
                                    strDate:(NSString *)strDate
                     canonicalizedKssHeader:(NSString *)strHeaders
                      canonicalizedResource:(NSString *)strResource {
    NSString *strAuthorization = @"KSS ";
    strAuthorization = [strAuthorization stringByAppendingString:accessKey];
    strAuthorization = [strAuthorization stringByAppendingString:@":"];
    NSString *strSignature = [self KSYSignatureWithSecretKey:secretKey
                                                    httpVerb:httpVerb
                                                  contentMd5:strContentMd5
                                                 contentType:strContentType
                                                     strDate:strDate
                                      canonicalizedKssHeader:strHeaders
                                       canonicalizedResource:strResource];
    strAuthorization = [strAuthorization stringByAppendingString:strSignature];
    return strAuthorization;
}

+ (void)signRequestV4:(KS3ServiceRequest *)serviceRequest
           urlRequest:(KS3URLRequest *)urlRequest
              headers:(NSMutableDictionary *)headers
              payload:(NSString *)payload
          credentials:(KS3Credentials *)credentials {
    [urlRequest setValue:serviceRequest.strDate forHTTPHeaderField:@"Date"];
    NSString *strAuthorization = @"";
    if (credentials.accessKey != nil && credentials.secretKey != nil) {
        strAuthorization = [KS3AuthUtils
                            KSYAuthorizationWithAccessKey:serviceRequest.credentials.accessKey
                            secretKey:serviceRequest.credentials.secretKey
                            httpVerb:serviceRequest.httpMethod
                            contentMd5:serviceRequest.contentMd5
                            contentType:serviceRequest.contentType
                            date:serviceRequest.requestDate
                            canonicalizedKssHeader:serviceRequest.kSYHeader
                            canonicalizedResource:serviceRequest.kSYResource];
    }
    [urlRequest setValue:strAuthorization forHTTPHeaderField:@"Authorization"];
    [urlRequest setURL:[NSURL URLWithString:serviceRequest.host]];
    [urlRequest setHTTPMethod:serviceRequest.httpMethod];
}

@end
