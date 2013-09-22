//
//  PetClass.h
//  pigeon
//
//  Created by 遠藤 豪 on 13/09/22.
//  Copyright (c) 2013年 endo.tuyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PetClass : NSObject

- (void)setPetImage:(NSString *)imageStr;

- (NSString *)getPetImage:(int)arNo;

- (int)getPetImageSum;


@end
