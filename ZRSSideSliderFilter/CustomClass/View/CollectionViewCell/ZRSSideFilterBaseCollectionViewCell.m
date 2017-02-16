//
//  ZRSSideFilterBaseCollectionViewCell.m
//  ZRSSideSliderFilter
//
//  Created by 赵瑞生 on 2016/12/5.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "ZRSSideFilterBaseCollectionViewCell.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation ZRSSideFilterBaseCollectionViewCell
#pragma clang diagnostic pop

+ (NSString *)cellReuseIdentifier {
    NSAssert(NO, @"\nERROR: Must realize this function in subClass %s", __func__);
    return @"";
}
@end
