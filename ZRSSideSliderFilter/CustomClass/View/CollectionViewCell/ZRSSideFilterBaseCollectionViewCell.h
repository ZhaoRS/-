//
//  ZRSSideFilterBaseCollectionViewCell.h
//  ZRSSideSliderFilter
//
//  Created by 赵瑞生 on 2016/12/5.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRSSideFilterCommenItemModel.h"

@interface ZRSSideFilterBaseCollectionViewCell : UICollectionViewCell
+ (NSString *)cellReuseIdentifier;
- (void)updateCellWithModel:(ZRSSideFilterCommenItemModel *)model;
- (void)tap2SelectItem:(BOOL)selected;
@end
