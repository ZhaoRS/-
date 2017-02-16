//
//  ZRSSideSlipBaseTableViewCell.h
//  ZRSSideSliderFilter
//
//  Created by 赵瑞生 on 2016/12/5.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRSSideSlipFilterRegionModel.h"

@protocol ZRSSideSlipBaseTableViewCellDelegate <NSObject>

@optional

- (void)sideSlipTableViewCellNeedsReload:(NSIndexPath *)indexPath;
- (void)sideSlipTableViewCellNeedsPushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)sideSlipTableViewCellNeedsScrollToCell:(UITableViewCell *)cell atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;

@end

@interface ZRSSideSlipBaseTableViewCell : UITableViewCell


@property (nonatomic, weak) id <ZRSSideSlipBaseTableViewCellDelegate> delegate;
+ (NSString *)cellReuseIdentifier;
+ (CGFloat)cellHeight;
+ (instancetype)createCellWithIndexPath:(NSIndexPath *)indexPath;
- (void)updateCellWithModel:(ZRSSideSlipFilterRegionModel **)model indexPath:(NSIndexPath *)indexPath;
- (void)resetData;


@end
