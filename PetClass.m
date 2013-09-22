//
//  PetClass.m
//  pigeon
//
//  Created by 遠藤 豪 on 13/09/22.
//  Copyright (c) 2013年 endo.tuyo. All rights reserved.
//

#import "PetClass.h"

@implementation PetClass

int age;
NSMutableArray *imageAr;

- (id)init{
    imageAr = [[NSMutableArray alloc]init];
    
    return self;
}

- (void)setAge:(int)_age{
    age = _age;
}

- (int)getAge{
    return age;
}


- (void)setPetImage:(NSString *)imageStr{
    //引数のイメージファイル(名称)をインスタンスフィールドに格納する
    [imageAr addObject:imageStr];
}

- (NSString *)getPetImage:(int)arNo{
    
    return [imageAr objectAtIndex:arNo];
}

- (int)getPetImageSum{
    return [imageAr count];
}

@end
