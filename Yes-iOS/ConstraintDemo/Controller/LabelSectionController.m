//
//  LabelSectionController.m
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/21.
//

#import "LabelSectionController.h"
#import "TitleLabelCollectionViewCell.h"

@interface LabelSectionController ()
@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation LabelSectionController

- (NSInteger) numberOfItems{
    return 1;
}

- (CGSize) sizeForItemAtIndex:(NSInteger)index{
    return CGSizeMake(self.collectionContext.containerSize.width, [TitleLabelCollectionViewCell singleLineHeight]);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    TitleLabelCollectionViewCell *cell = (TitleLabelCollectionViewCell *)[self.collectionContext dequeueReusableCellOfClass:TitleLabelCollectionViewCell.class forSectionController:self atIndex:index];
    [cell.label setNumberOfLines:1];
    [cell.label setText:_object];
    return cell;
}

// pass the data item to sectionController
- (void) didUpdateToObject:(id)object{
    _object = object;
}

@end
