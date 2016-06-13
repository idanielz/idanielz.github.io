//
//  main.m
//  whoKeepsFish
//
//  Created by 张继东 on 16/3/31.
//  Copyright © 2016年 idanielz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (nonatomic, assign)int animal;
@property (nonatomic, assign)int drink;
@property (nonatomic, assign)int color;
@property (nonatomic, assign)int order;
@property (nonatomic, assign)int cig;
@end

@implementation Model



@end

@interface Answer : NSObject
@property (nonatomic, strong) Model * Germany;
@property (nonatomic, strong) Model * Danmai;
@property (nonatomic, strong) Model * British;
@property (nonatomic, strong) Model * Ruidian;
@property (nonatomic, strong) Model * Nuowei;

- (BOOL)isGreenLeftWhite;
- (BOOL)isGreenCoffee;
- (BOOL)isPallBird;
- (BOOL)isYellowDunhill;
- (BOOL)isMiddleMilk;
- (BOOL)isNuoweiFirst;
- (BOOL)isHunheBesideCat;
- (BOOL)isHorseBesideDunhill;
- (BOOL)isBlueBill;
- (BOOL)isGermanyPrince;
- (BOOL)isNuoweiBesideBlue;
- (BOOL)isHunheBesideWater;

+(NSString *)color:(int)c;

+(NSString *)drink:(int)c;

+(NSString *)animal:(int)c;

+(NSString *)cig:(int)c;

@end

@implementation Answer

- (instancetype)init
{
    self = [super init];
    if (self) {
        _Germany = [[Model alloc]init];
        _Danmai = [[Model alloc]init];
        _British = [[Model alloc]init];
        _Ruidian = [[Model alloc]init];
        _Nuowei = [[Model alloc]init];
    }
    return self;
}

- (BOOL)isGreenLeftWhite
{
    Model *tmp1 = nil;
    Model *tmp2 = nil;
    tmp1 = (_Germany.color == 4)?_Germany: (_Danmai.color == 4)?_Danmai:(_British.color == 4)?_British:(_Ruidian.color == 4)?_Ruidian:(_Nuowei.color == 4)?_Nuowei:nil;
    tmp2 = (_Germany.color == 5)?_Germany: (_Danmai.color == 5)?_Danmai:(_British.color == 5)?_British:(_Ruidian.color == 5)?_Ruidian:(_Nuowei.color == 5)?_Nuowei:nil;
    if (tmp1 && tmp2) {
        if (tmp1.order < tmp2.order) {
            return YES;
        }
        return NO;
    }
    else
    {
        return NO;
    }
}

- (BOOL)isGreenCoffee
{
    Model *tmp1 = nil;
    tmp1 = (_Germany.color == 4)?_Germany: (_Danmai.color == 4)?_Danmai:(_British.color == 4)?_British:(_Ruidian.color == 4)?_Ruidian:(_Nuowei.color == 4)?_Nuowei:nil;
    if (tmp1.drink == 1) {
        return YES;
    }
    return NO;
}

- (BOOL)isPallBird
{
    Model *tmp1 = nil;
    tmp1 = (_Germany.cig == 1)?_Germany: (_Danmai.cig == 1)?_Danmai:(_British.cig == 1)?_British:(_Ruidian.cig == 1)?_Ruidian:(_Nuowei.cig == 1)?_Nuowei:nil;
    if (tmp1.animal == 3) {
        return YES;
    }
    return NO;
}

- (BOOL)isYellowDunhill
{
    Model *tmp1 = nil;
    tmp1 = (_Germany.color == 2)?_Germany: (_Danmai.color == 2)?_Danmai:(_British.color == 2)?_British:(_Ruidian.color == 2)?_Ruidian:(_Nuowei.color == 2)?_Nuowei:nil;
    if (tmp1.cig == 2) {
        return YES;
    }
    return NO;
}

- (BOOL)isMiddleMilk
{
    Model *tmp1 = nil;
    tmp1 = (_Germany.order == 3)?_Germany: (_Danmai.order == 3)?_Danmai:(_British.order == 3)?_British:(_Ruidian.order == 3)?_Ruidian:(_Nuowei.order == 3)?_Nuowei:nil;
    if (tmp1.drink == 5) {
        return YES;
    }
    return NO;
}
- (BOOL)isNuoweiFirst
{
    if (_Nuowei.order == 1) {
        return YES;
    }
    return NO;
}
- (BOOL)isHunheBesideCat
{
    Model *tmp1 = nil;
    Model *tmp2 = nil;
    tmp1 = (_Germany.cig == 4)?_Germany: (_Danmai.cig == 4)?_Danmai:(_British.cig == 4)?_British:(_Ruidian.cig == 4)?_Ruidian:(_Nuowei.cig == 4)?_Nuowei:nil;
    tmp2 = (_Germany.animal == 4)?_Germany: (_Danmai.animal == 4)?_Danmai:(_British.animal == 4)?_British:(_Ruidian.animal == 4)?_Ruidian:(_Nuowei.animal == 4)?_Nuowei:nil;
    if ( abs(tmp1.order - tmp2.order) == 1 ) {
        return YES;
    }
    return NO;
}
- (BOOL)isHorseBesideDunhill
{
    Model *tmp1 = nil;
    Model *tmp2 = nil;
    tmp1 = (_Germany.cig == 2)?_Germany: (_Danmai.cig == 2)?_Danmai:(_British.cig == 2)?_British:(_Ruidian.cig == 2)?_Ruidian:(_Nuowei.cig == 2)?_Nuowei:nil;
    tmp2 = (_Germany.animal == 2)?_Germany: (_Danmai.animal == 2)?_Danmai:(_British.animal == 2)?_British:(_Ruidian.animal == 2)?_Ruidian:(_Nuowei.animal == 2)?_Nuowei:nil;
    if ( abs(tmp1.order - tmp2.order) == 1 ) {
        return YES;
    }
    return NO;
}
- (BOOL)isBlueBill
{
    Model *tmp1 = nil;
    tmp1 = (_Germany.cig == 3)?_Germany: (_Danmai.cig == 3)?_Danmai:(_British.cig == 3)?_British:(_Ruidian.cig == 3)?_Ruidian:(_Nuowei.cig == 3)?_Nuowei:nil;
    if (tmp1.drink == 4) {
        return YES;
    }
    return NO;
}
- (BOOL)isGermanyPrince
{
    if (_Germany.cig == 5) {
        return YES;
    }
    return NO;
}
- (BOOL)isNuoweiBesideBlue
{
    Model *tmp1 = nil;
    tmp1 = (_Germany.color == 3)?_Germany: (_Danmai.color == 3)?_Danmai:(_British.color == 3)?_British:(_Ruidian.color == 3)?_Ruidian:(_Nuowei.color == 3)?_Nuowei:nil;
    if (abs(tmp1.order - _Nuowei.order) == 1) {
        return YES;
    }
    return NO;
}
- (BOOL)isHunheBesideWater
{
    Model *tmp1 = nil;
    Model *tmp2 = nil;
    tmp1 = (_Germany.cig == 4)?_Germany: (_Danmai.cig == 4)?_Danmai:(_British.cig == 4)?_British:(_Ruidian.cig == 4)?_Ruidian:(_Nuowei.cig == 4)?_Nuowei:nil;
    tmp2 = (_Germany.drink == 2)?_Germany: (_Danmai.drink == 2)?_Danmai:(_British.drink == 2)?_British:(_Ruidian.drink == 2)?_Ruidian:(_Nuowei.drink == 2)?_Nuowei:nil;
    if ( abs(tmp1.order - tmp2.order) == 1 ) {
        return YES;
    }
    return NO;
}

+ (NSArray *)getArray
{
    NSMutableArray * a = [NSMutableArray array];
    for (int i = 1; i < 6; i++) {
        for (int j = 1; j < 6; j++){
            for (int k = 1; k < 6; k++){
                for (int n = 1; n < 6; n++){
                    for (int m = 1; m < 6; m++){
                        if (i != j && k != i && k != j && n != i && n != j && n != k && m != i && m != j && m != k && m != n) {
//                            NSLog(@"%d %d %d %d %d", i, j, k, n, m);
                            [a addObject:[NSArray arrayWithObjects:@(i),@(j),@(k),@(n),@(m), nil]];
                        }
                        
                    }
                }
            }
        }
    }
    return a;
}

+(NSString *)color:(int)c
{
    switch (c) {
        case 1:
            return @"红";
        case 2:
            return @"黄";
        case 3:
            return @"蓝";
        case 4:
            return @"绿";
        case 5:
            return @"白";
        default:
            return nil;
    }
}

+(NSString *)drink:(int)c
{
    switch (c) {
        case 1:
            return @"咖";
        case 2:
            return @"水";
        case 3:
            return @"茶";
        case 4:
            return @"酒";
        case 5:
            return @"奶";
        default:
            return nil;
    }
}

+(NSString *)animal:(int)c
{
    switch (c) {
        case 1:
            return @"狗";
        case 2:
            return @"马";
        case 3:
            return @"鸟";
        case 4:
            return @"猫";
        case 5:
            return @"鱼";
        default:
            return nil;
    }
}

+(NSString *)cig:(int)c
{
    switch (c) {
        case 1:
            return @"pall";
        case 2:
            return @"dunhill";
        case 3:
            return @"blue";
        case 4:
            return @"混合";
        case 5:
            return @"prince";
        default:
            return nil;
    }
}
@end
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        NSArray *a = [Answer getArray];
        
        for (int i = 0; i < a.count; i++) {     //animal
            for (int j = 0; j <  a.count; j++){ //drink
                for (int k = 0; k <  a.count; k++){//color
                    if ([a[i][3] intValue] == 1 && [a[j][1] intValue] == 3 && [a[k][2] intValue] == 1) {
                        Answer *answer = [[Answer alloc]init];
                        answer.Germany.animal = [a[i][0] intValue];
                        answer.Danmai.animal = [a[i][1] intValue];
                        answer.British.animal = [a[i][2] intValue];     
                        answer.Ruidian.animal = [a[i][3] intValue];   //狗
                        answer.Nuowei.animal = [a[i][4] intValue];
                        
                        answer.Germany.drink = [a[j][0] intValue];
                        answer.Danmai.drink = [a[j][1] intValue];     //茶
                        answer.British.drink = [a[j][2] intValue];
                        answer.Ruidian.drink = [a[j][3] intValue];
                        answer.Nuowei.drink = [a[j][4] intValue];
                        
                        answer.Germany.color = [a[k][0] intValue];
                        answer.Danmai.color = [a[k][1] intValue];
                        answer.British.color = [a[k][2] intValue];   //红
                        answer.Ruidian.color = [a[k][3] intValue];
                        answer.Nuowei.color = [a[k][4] intValue];
                        if ([answer isGreenCoffee]) {
                            for (int n = 0; n <  a.count; n++){ //order
                                if ([a[n][4] intValue] == 1) {
                                    answer.Germany.order = [a[n][0] intValue];
                                    answer.Danmai.order = [a[n][1] intValue];
                                    answer.British.order = [a[n][2] intValue];
                                    answer.Ruidian.order = [a[n][3] intValue];
                                    answer.Nuowei.order = [a[n][4] intValue];       //第一
                                    if ([answer isMiddleMilk] && [answer isGreenLeftWhite] && [answer isNuoweiBesideBlue]) {
                                        for (int m = 0; m < a.count; m++){
                                            if ([a[m][0] intValue] == 5) {
                                                answer.Germany.cig = [a[m][0] intValue];   //prince
                                                answer.Danmai.cig = [a[m][1] intValue];
                                                answer.British.cig = [a[m][2] intValue];
                                                answer.Ruidian.cig = [a[m][3] intValue];
                                                answer.Nuowei.cig = [a[m][4] intValue];
                                                if ([answer isPallBird] && [answer isHunheBesideCat] && [answer isYellowDunhill] && [answer isHorseBesideDunhill] && [answer isHunheBesideWater] && [answer isBlueBill]) {
                                                    NSLog(@"%@ %d %@ %@ %@ %@", @"德", answer.Germany.order, [Answer color:answer.Germany.color],[Answer animal:answer.Germany.animal],[Answer drink:answer.Germany.drink],[Answer cig:answer.Germany.cig] );
                                                    NSLog(@"%@ %d %@ %@ %@ %@", @"丹", answer.Danmai.order, [Answer color:answer.Danmai.color],[Answer animal:answer.Danmai.animal],[Answer drink:answer.Danmai.drink],[Answer cig:answer.Danmai.cig] );
                                                    NSLog(@"%@ %d %@ %@ %@ %@", @"英", answer.British.order, [Answer color:answer.British.color],[Answer animal:answer.British.animal],[Answer drink:answer.British.drink],[Answer cig:answer.British.cig] );
                                                    NSLog(@"%@ %d %@ %@ %@ %@", @"瑞", answer.Ruidian.order, [Answer color:answer.Ruidian.color],[Answer animal:answer.Ruidian.animal],[Answer drink:answer.Ruidian.drink],[Answer cig:answer.Ruidian.cig] );
                                                    NSLog(@"%@ %d %@ %@ %@ %@\n\n", @"挪", answer.Nuowei.order, [Answer color:answer.Nuowei.color],[Answer animal:answer.Nuowei.animal],[Answer drink:answer.Nuowei.drink],[Answer cig:answer.Nuowei.cig] );
                                                    
                                                }
                                            }
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                }
            }
        }
    }
//        1  2  3 4  5
//        红 黄 蓝 绿 白
//        狗 马 鸟 猫 鱼
//        咖 水 茶 酒 奶
//        pall dunhill blue 混合 prince

    return 0;
}

/*
 绿房子：挪威人----咖啡----PALL MALL烟----鸟
 蓝房子：德国人---矿泉水-----PRINCE烟 ---猫
 红房子：英国人----牛奶-----混合烟------马
 黄房子：丹麦人---茶-----DUNHILL烟------鱼
 白房子：瑞典人---啤酒----BLUE MASTER烟---狗
 */