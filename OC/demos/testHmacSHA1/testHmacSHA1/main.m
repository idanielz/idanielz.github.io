//
//  main.m
//  testHmacSHA1
//
//  Created by 张继东 on 16/4/15.
//  Copyright © 2016年 idanielz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHA1.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
//        NSLog(@"Hello, World!");
        NSString *url = @"http://api.vienx.iqiyi.com/v1/partner/ppcinfo.json?app_key=qiyi_live_ios&nonce=57&partner_code=H3p4xIeutxNC72Eg&platform=2_22_221&star_num=5&timestamp=1460717581.880359&user_num=5&version=7.4";
//        NSString *content = @"'GET'.'api.vienx.iqiyi.com/v1/partner/ppcinfo.json'.'?'.'app_key=qiyi_live_ios&nonce=57&partner_code=H3p4xIeutxNC72Eg&platform=2_22_221&star_num=5&timestamp=1460717581.880359&user_num=5&version=7.4'";
        NSString *content = @"GETapi.vienx.iqiyi.com/v1/partner/ppcinfo.json?app_key=qiyi_live_ios&nonce=19&partner_code=LnfGrJpRVhVseUHZ&platform=2_22_221&star_num=5&timestamp=1460724976.916799&user_num=5&version=7.4";
        NSString *key = @"ikJ7PsW8Z&DG!*$2Tp$h";
        NSString *result = [SHA1 hmacSha1:key text:content];
        NSLog(@"%@\n%@",result, [url stringByAppendingFormat:@"&sign=%@",[result substringWithRange:NSMakeRange(5, 16)]]);
        
    }
    return 0;
}
