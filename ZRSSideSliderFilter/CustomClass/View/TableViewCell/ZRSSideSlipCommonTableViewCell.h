//
//  ZRSSideSlipCommonTableViewCell.h
//  ZRSSideSliderFilter
//
//  Created by 赵瑞生 on 2016/12/5.
//  Copyright © 2016年 ZRS. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ZRSSideSlipBaseTableViewCell.h"


typedef NS_ENUM(NSInteger, ZRSSideSlipCommonTableViewCellSelectionType) {
    BrandTableViewCellSelectionTypeSingle = 0,                  //单选
    BrandTableViewCellSelectionTypeMultiple = 1,                //双选
};
/**
 数据源model customDict中可配置的key_value
 */
#define REGION_SELECTION_TYPE @"REGION_SELECTION_TYPE"


@interface ZRSSideSlipCommonTableViewCell : ZRSSideSlipBaseTableViewCell <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end
