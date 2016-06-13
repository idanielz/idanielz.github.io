//
//  Test.m
//  blockMRC
//
//  Created by 张继东 on 16/5/26.
//  Copyright © 2016年 idanielz. All rights reserved.
//

#import "Test.h"

@implementation Test

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self notOk];
    }
    return self;
}
- (void)ok
{
    if (_b) {
        _b();
    }
}

-(void)notOk
{
    NSLog(@"notOK");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_b) {
            _b();
        }
    });
}
@end
