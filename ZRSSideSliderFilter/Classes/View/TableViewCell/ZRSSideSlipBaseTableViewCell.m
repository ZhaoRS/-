//
//  ZRSSideSlipBaseTableViewCell.m
//  ZRSSideSliderFilter
//
//  Created by 赵瑞生 on 2016/12/5.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "ZRSSideSlipBaseTableViewCell.h"
#import "ZRSSideSlipFilterConfig.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"


@implementation ZRSSideSlipBaseTableViewCell

#pragma clang diagnostic pop

+ (NSString *)cellReuseIdentifier {
    NSAssert(NO, @"\nERROR: Must realize this function in subClass %s", __func__);
    return nil;
}

+ (instancetype)createCellWithIndexPath:(NSIndexPath *)indexPath {
    NSAssert(NO, @"\nERROR: Must realize this function in subClass %s", __func__);
    return nil;
}

- (void)updateCellWithModel:(ZRSSideSlipFilterRegionModel *__autoreleasing *)model
                  indexPath:(NSIndexPath *)indexPath {
    NSAssert(NO, @"\nERROR: Must realize this function in subClass %s", __func__);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self registerNotification];
}

- (void)dealloc {
    [self resignNotification];
}

- (void)resetData {
    
}

- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetData) name:FILTER_NOTIFICATION_NAME_DID_RESET_DATA object:nil];
}

- (void)resignNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
