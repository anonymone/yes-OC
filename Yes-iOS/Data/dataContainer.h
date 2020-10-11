//
//  dataContainer.h
//  Yes-iOS
//
//  Created by Severus Peng on 2020/10/11.
//

#import <Foundation/Foundation.h>

@class dataItem;

NS_ASSUME_NONNULL_BEGIN

@interface dataContainer : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype) sharedContainer;

- (dataItem *)creatItem:(Class) withClass;

- (NSInteger) countOfAllItems;

@end

NS_ASSUME_NONNULL_END
