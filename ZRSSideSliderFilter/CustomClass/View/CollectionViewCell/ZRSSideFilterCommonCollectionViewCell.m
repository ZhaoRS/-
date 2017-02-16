//
//  ZRSSideFilterCommonCollectionViewCell.m
//  ZRSSideSliderFilter
//
//  Created by 赵瑞生 on 2016/12/5.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "ZRSSideFilterCommonCollectionViewCell.h"
#import "ZRSSideFilterCommenItemModel.h"
#import "UIColor+hexColor.h"
#import "ZRSSideSlipFilterConfig.h"


@interface ZRSSideFilterCommonCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *nameButton;
@property (copy, nonatomic) NSString *itemId;

@end

@implementation ZRSSideFilterCommonCollectionViewCell
+ (NSString *)cellReuseIdentifier {
    return @"ZRSSideFilterCommonCollectionViewCell";
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return [[NSBundle mainBundle] loadNibNamed:@"ZRSSideFilterCommonCollectionViewCell" owner:nil options:nil][0];
}

- (void)updateCellWithModel:(ZRSSideFilterCommenItemModel *)model {
    [_nameButton setTitle:model.itemName forState:UIControlStateNormal];
    self.itemId = model.itemId;
    [self tap2SelectItem:model.selected];
}

- (void)tap2SelectItem:(BOOL)selected {
    if (selected) {
        [self setBackgroundColor:[UIColor hexColor:FILTER_COLLECTION_ITEM_COLOR_SELECTED_STRING]];
        [_nameButton setTitleColor:[UIColor hexColor:FILTER_RED_STRING] forState:UIControlStateNormal];
        self.layer.borderWidth = .5f;
        self.layer.borderColor = [UIColor hexColor:FILTER_RED_STRING].CGColor;
        [_nameButton setImage:[UIImage imageNamed:@"item_checked"] forState:UIControlStateNormal];
    } else {
        [self setBackgroundColor:[UIColor hexColor:FILTER_COLLECTION_ITEM_COLOR_NORMAL_STRING]];
        [_nameButton setTitleColor:[UIColor hexColor:FILTER_BLACK_STRING] forState:UIControlStateNormal];
        self.layer.borderWidth = 0;
        [_nameButton setImage:nil forState:UIControlStateNormal];
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
