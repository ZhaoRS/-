//
//  ViewController.m
//  ZRSSideSliderFilter
//
//  Created by 赵瑞生 on 2016/12/2.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "ViewController.h"
#import "ZRSSideSlipFilterController.h"
#import "ZRSSideSlipFilterRegionModel.h"
#import "ZRSSideFilterCommenItemModel.h"
#import "ZRSSideSlipCommonTableViewCell.h"

@interface ViewController ()

@property (nonatomic, strong) ZRSSideSlipFilterController *filterController;
@property (weak, nonatomic) IBOutlet UIButton *showFilterButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.filterController = [[ZRSSideSlipFilterController alloc] initWithSponsor:self resetBlock:^(NSArray *dataList) {

        for (ZRSSideSlipFilterRegionModel *model in dataList) {
                                                                             //selectedStatus
            
            for (ZRSSideFilterCommenItemModel *itemModel in model.itemList) {
                
                [itemModel setSelected:NO];
                
            }
                                                                             //selectedItem
            
            model.selectedItemList = nil;
            
        }
        
    } commitBlock:^(NSArray *dataList) {
        
        //Common Region
        
        NSMutableString *commonRegionString = [NSMutableString string];
        
        for (int i = 0; i < dataList.count; i ++) {
            
            ZRSSideSlipFilterRegionModel *commonRegionModel = dataList[i];
            
            [commonRegionString appendFormat:@"\n%@:", commonRegionModel.regionTitle];
            
            NSMutableArray *commonItemSelectedArray = [NSMutableArray array];
            
            for (ZRSSideFilterCommenItemModel *itemModel in commonRegionModel.itemList) {
            
                if (itemModel.selected) {
                
                    [commonItemSelectedArray addObject:[NSString stringWithFormat:@"%@-%@", itemModel.itemId, itemModel.itemName]];
                    
                }
                
            }
            
            [commonRegionString appendString:[commonItemSelectedArray componentsJoinedByString:@", "]];
            
        }
        
        NSLog(@"%@", commonRegionString);
                                                                         
        
    }];
    _filterController.animationDuration = .3f;
    _filterController.sideSlipLeading = 0.15*[UIScreen mainScreen].bounds.size.width;
    _filterController.dataList = [self packageDataList];
    
}
- (IBAction)clickFilterButton:(UIButton *)sender {
    
    [_filterController show];
}

#pragma mark - 模拟数据源
- (NSArray *)packageDataList {
    NSMutableArray *dataArray = [NSMutableArray array];
    
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"品牌" selectionType:BrandTableViewCellSelectionTypeMultiple]];
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"种类" selectionType:BrandTableViewCellSelectionTypeSingle]];
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"特性" selectionType:BrandTableViewCellSelectionTypeMultiple]];
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"适用场景" selectionType:BrandTableViewCellSelectionTypeMultiple]];
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"重量" selectionType:BrandTableViewCellSelectionTypeMultiple]];
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"包装" selectionType:BrandTableViewCellSelectionTypeMultiple]];
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"存储方式" selectionType:BrandTableViewCellSelectionTypeMultiple]];
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"货仓" selectionType:BrandTableViewCellSelectionTypeMultiple]];
    return [dataArray mutableCopy];
}

- (ZRSSideSlipFilterRegionModel *)commonFilterRegionModelWithKeyword:(NSString *)keyword selectionType:(ZRSSideSlipCommonTableViewCellSelectionType)selectionType {
    ZRSSideSlipFilterRegionModel *model = [[ZRSSideSlipFilterRegionModel alloc] init];
    model.containerCellClass = @"ZRSSideSlipCommonTableViewCell";
    model.regionTitle = keyword;
    model.customDict = @{REGION_SELECTION_TYPE:@(selectionType)};
    model.itemList = @[[self createItemModelWithTitle:[NSString stringWithFormat:@"%@一", keyword] itemId:@"0000" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@二", keyword] itemId:@"0001" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@三", keyword] itemId:@"0002" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@四", keyword] itemId:@"0003" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@五", keyword] itemId:@"0004" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@六", keyword] itemId:@"0005" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@七", keyword] itemId:@"0006" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@八", keyword] itemId:@"0007" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@九", keyword] itemId:@"0008" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@十", keyword] itemId:@"0009" selected:NO]
                       ];
    return model;
}


- (ZRSSideFilterCommenItemModel *)createItemModelWithTitle:(NSString *)itemTitle
                                       itemId:(NSString *)itemId
                                     selected:(BOOL)selected {
    ZRSSideFilterCommenItemModel *model = [[ZRSSideFilterCommenItemModel alloc] init];
    model.itemId = itemId;
    model.itemName = itemTitle;
    model.selected = selected;
    return model;
}


- (void)configureShowFilterButton {
    _showFilterButton.layer.shadowOffset = CGSizeMake(1, 1);
    _showFilterButton.layer.shadowOpacity = 0.6f;
    _showFilterButton.layer.shadowColor = [UIColor grayColor].CGColor;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
