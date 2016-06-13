//
//  Test.h
//  blockMRC
//
//  Created by 张继东 on 16/5/26.
//  Copyright © 2016年 idanielz. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^block)();

@interface Test : NSObject
@property (nonatomic, copy)block b;
- (void)ok;
- (void)notOk;
@end
