//
//  myLabel.m
//  2048Game
//
//  Created by qianfeng on 15-1-30.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "myLabel.h"

@implementation myLabel
@synthesize number, color, delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        int i = 0;
        while (i++ < 3) {
            int n =  arc4random() %5;
            if (n == 2 || n == 4) {
                number = [NSString stringWithFormat:@"%d", n];
            }
            else
            {
                number = @"";
            }
        }
        //[self setBackgroundColor:color];
        self.text = number;
        [self setTextAlignment:NSTextAlignmentCenter];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)changeColor
{
    [delegate setColorWithNumber];
}
@end
