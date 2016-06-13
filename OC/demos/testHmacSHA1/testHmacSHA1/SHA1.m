//
//  SHA1.m
//  testHmacSHA1
//
//  Created by 张继东 on 16/4/15.
//  Copyright © 2016年 idanielz. All rights reserved.
//

#import "SHA1.h"
#import <CommonCrypto/CommonHMAC.h>
//#import <base>
@implementation SHA1

+ (NSString *) hmacSha1:(NSString*)key text:(NSString*)text
{
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [text cStringUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];


    
    return [HMAC base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
@end
