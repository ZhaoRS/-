//
//  ZRSSideSlipCommonTableViewCell.m
//  ZRSSideSliderFilter
//
//  Created by 赵瑞生 on 2016/12/5.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "ZRSSideSlipCommonTableViewCell.h"
#import "ZRSSideFilterCommenItemModel.h"
#import "UIView+Utils.h"
#import "UIColor+hexColor.h"
#import "ZRSSideFilterCommonCollectionViewCell.h"
#import "ZRSSideSlipFilterConfig.h"
#import "ZRSSideSlipFilterController.h"


#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define FILTER_LEADING ((ZRSSideSlipFilterController *)self.delegate).sideSlipLeading
#define CELL_WIDTH SCREEN_WIDTH - FILTER_LEADING

#define LINE_SPACE_COLLECTION_ITEM 8
#define GAP_COLLECTION_ITEM 8
#define NUM_OF_ITEM_ONCE_ROW 3.f
#define ITEM_WIDTH ((CELL_WIDTH - (NUM_OF_ITEM_ONCE_ROW+1)*GAP_COLLECTION_ITEM)/NUM_OF_ITEM_ONCE_ROW)
#define ITEM_WIDTH_HEIGHT_RATIO 4.f
#define ITEM_HEIGHT ceil(ITEM_WIDTH/ITEM_WIDTH_HEIGHT_RATIO)

const int BRIEF_ROW = 2;

@interface ZRSSideSlipCommonTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *controlIcon;
@property (weak, nonatomic) IBOutlet UILabel *controlLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *mainCollectionView;
@property (strong, nonatomic) NSArray *dataList;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;
@property (strong, nonatomic) ZRSSideSlipFilterRegionModel *regionModel;
@property (assign, nonatomic) ZRSSideSlipCommonTableViewCellSelectionType selectionType;
@property (strong, nonatomic) NSMutableArray *selectedItemList;
@property (copy, nonatomic) NSString *selectedItemString;
@end


@implementation ZRSSideSlipCommonTableViewCell
+ (NSString *)cellReuseIdentifier {
    return @"ZRSSideSlipCommonTableViewCell";
}

+ (instancetype)createCellWithIndexPath:(NSIndexPath *)indexPath {
    ZRSSideSlipCommonTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZRSSideSlipCommonTableViewCell" owner:nil options:nil][0];
    cell.indexPath = indexPath;
    [cell configureCell];
    return cell;
}

- (void)configureCell {
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
    _mainCollectionView.contentInset = UIEdgeInsetsMake(0, GAP_COLLECTION_ITEM, 0, GAP_COLLECTION_ITEM);
    [_mainCollectionView registerClass:[ZRSSideFilterCommonCollectionViewCell class] forCellWithReuseIdentifier:[ZRSSideFilterCommonCollectionViewCell cellReuseIdentifier]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)updateCellWithModel:(ZRSSideSlipFilterRegionModel **)model
                  indexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    self.regionModel = *model;
    //title
    [self.titleLabel setText:_regionModel.regionTitle];
    //content
    self.dataList = _regionModel.itemList;
    //icon
    if (_regionModel.isShowAll) {
        [_controlIcon setImage:[UIImage imageNamed:@"icon_up"]];
    } else {
        [_controlIcon setImage:[UIImage imageNamed:@"icon_down"]];
    }
    //controlLabel
    self.selectedItemList = [NSMutableArray arrayWithArray:_regionModel.selectedItemList];
    [self generateControlLabelText];
    //selectionType
    NSNumber *selectionType = _regionModel.customDict[REGION_SELECTION_TYPE];
    if (selectionType) {
        self.selectionType = [selectionType unsignedIntegerValue];
    }
    //UI
    [_mainCollectionView reloadData];
    [self fitCollectonViewHeight];
}

//根据数据源个数决定collectionView高度
- (void)fitCollectonViewHeight {
    CGFloat displayNumOfRow;
    if (_regionModel.isShowAll) {
        displayNumOfRow = ceil(_dataList.count/NUM_OF_ITEM_ONCE_ROW);
    } else {
        displayNumOfRow = BRIEF_ROW;
    }
    CGFloat collectionViewHeight = displayNumOfRow*ITEM_HEIGHT + (displayNumOfRow - 1)*LINE_SPACE_COLLECTION_ITEM;
    _collectionViewHeightConstraint.constant = collectionViewHeight;
    [_mainCollectionView updateHeight:collectionViewHeight];
}

- (void)tap2SelectItem:(NSIndexPath *)indexPath {
    switch (_selectionType) {
        case BrandTableViewCellSelectionTypeSingle:
        {
            NSArray *itemArray = _regionModel.itemList;
            ZRSSideFilterCommenItemModel *model = [itemArray objectAtIndex:indexPath.row];
            if (!model.selected) {
                for (ZRSSideFilterCommenItemModel *item in itemArray) {
                    item.selected = NO;
                }
                [self.selectedItemList removeAllObjects];
                [self.selectedItemList addObject:model];
            } else {
                [self.selectedItemList removeObject:model];
            }
            model.selected = !model.selected;
        }
            break;
        case BrandTableViewCellSelectionTypeMultiple:
        {
            NSArray *itemArray = _regionModel.itemList;
            ZRSSideFilterCommenItemModel *model = [itemArray objectAtIndex:indexPath.row];
            model.selected = !model.selected;
            if (model.selected) {
                [self.selectedItemList addObject:model];
            } else {
                [self.selectedItemList removeObject:model];
            }
        }
            break;
        default:
            break;
    }
    _regionModel.selectedItemList = _selectedItemList;
    [self generateControlLabelText];
}

- (NSString *)packageSelectedNameString {
    NSMutableArray *mutArray = [NSMutableArray array];
    for (ZRSSideFilterCommenItemModel *model in _selectedItemList) {
        [mutArray addObject:model.itemName];
    }
    return [mutArray componentsJoinedByString:@","];
}

- (void)generateControlLabelText {
    self.selectedItemString = [self packageSelectedNameString];
    UIColor *textColor;
    NSString *labelContent;
    if (_selectedItemString.length > 0) {
        labelContent = _selectedItemString;
        textColor = [UIColor hexColor:FILTER_RED_STRING];
    } else {
        labelContent = @"全部";
        textColor = [UIColor hexColor:@"999999"];
    }
    [_controlLabel setText:labelContent];
    [_controlLabel setTextColor:textColor];
}

#pragma mark - DataSource Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZRSSideFilterCommonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZRSSideFilterCommonCollectionViewCell cellReuseIdentifier] forIndexPath:indexPath];
    ZRSSideFilterCommenItemModel *model = [_dataList objectAtIndex:indexPath.row];
    [cell updateCellWithModel:model];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return LINE_SPACE_COLLECTION_ITEM;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.5*GAP_COLLECTION_ITEM;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    [self tap2SelectItem:indexPath];
    [_mainCollectionView reloadData];
}

- (IBAction)clickShowMoreButton:(id)sender {
    _regionModel.isShowAll = !_regionModel.isShowAll;
    [self fitCollectonViewHeight];
    //reload
    if ([self.delegate respondsToSelector:@selector(sideSlipTableViewCellNeedsReload:)]) {
        [self.delegate sideSlipTableViewCellNeedsReload:_indexPath];
    }
    //scroll
    if (_regionModel.isShowAll && [self.delegate respondsToSelector:@selector(sideSlipTableViewCellNeedsScrollToCell:atScrollPosition:animated:)]) {
        [self.delegate sideSlipTableViewCellNeedsScrollToCell:self atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (NSMutableArray *)selectedItemList {
    if (!_selectedItemList) {
        _selectedItemList = [NSMutableArray array];
    }
    return _selectedItemList;
}

@end
