//
//  ZRSSideSlipFilterController.h
//  ZRSSideSliderFilter
//
//  Created by 赵瑞生 on 2016/12/2.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SideSlipFilterCommitBlock)(NSArray *dataList);
typedef void (^SideSlipFilterResetBlock)(NSArray *dataList);

@interface ZRSSideSlipFilterController : UIViewController

@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, assign) CGFloat sideSlipLeading;
@property (nonatomic, copy) NSArray *dataList;

- (instancetype)initWithSponsor:(UIViewController *)sponsor
                     resetBlock:(SideSlipFilterResetBlock)resetBlock
                    commitBlock:(SideSlipFilterCommitBlock)commitBlock;

- (void)show;
- (void)dismiss;
- (void)reloadData;

@end
