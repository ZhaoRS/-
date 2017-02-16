//
//  ZRSSideSlipFilterRegionModel.h
//  ZRSSideSliderFilter
//
//  Created by 赵瑞生 on 2016/12/2.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRSSideSlipFilterRegionModel : NSObject

@property (nonatomic, copy) NSString *containerCellClass;
@property (nonatomic, copy) NSString *regionTitle;
@property (nonatomic, strong) NSArray *itemList;
@property (nonatomic, assign) BOOL isShowAll;
@property (nonatomic, strong) NSArray *selectedItemList;
@property (nonatomic, strong) NSDictionary *customDict;

@end
