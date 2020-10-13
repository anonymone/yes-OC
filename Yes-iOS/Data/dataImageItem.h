//
//  dataImageItem.h
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface dataImageItem : NSObject
@property (nonatomic, copy) NSString *imageIdentification;
@property (nonatomic, copy) NSString *itemName;
@property (nonatomic) NSInteger value;

- (instancetype) initWithName:(NSString *)name valueInDollars:(NSInteger) value serialNumber:(NSString *) sNumber;

@end

NS_ASSUME_NONNULL_END
