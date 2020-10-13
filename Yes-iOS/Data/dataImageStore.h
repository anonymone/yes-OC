//
//  dataImageStore.h
//  
//
//  Created by ShichenPeng on 2020/10/13.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class dataImageItem;
NS_ASSUME_NONNULL_BEGIN

@interface dataImageStore : NSObject

+ (instancetype) sharedStore;

- (void) setImage:(UIImage *) image forKey:(NSString *) key;

- (UIImage *) imageForKey:(NSString *) key;

- (void) deleteImageForKey:(NSString *) key;

- (NSArray *) allItems;

- (dataImageItem *)creatItem:(NSString *) name valueInDollars:(NSInteger) value serialNumber:(NSString *) sNumber;

- (void) removeItem:(dataImageItem *) item;

- (void) moveItemAtIndex:(NSUInteger) fromIndex toIndex:(NSUInteger) toIndex;

- (NSInteger) countOfAllItems;

@end

NS_ASSUME_NONNULL_END
