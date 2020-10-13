//
//  dataImageItem.m
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/13.
//

#import "dataImageItem.h"

@interface dataImageItem ()
@property (nonatomic, strong, readonly) NSDate *dataCreated;
@property (nonatomic, copy) NSString *serialNumber;

@end

@implementation dataImageItem

- (instancetype) initWithName:(NSString *)name valueInDollars:(NSInteger) value serialNumber:(NSString *) sNumber
{
    self = [super init];
    if(self){
        _itemName = name;
        _serialNumber = sNumber;
        _value = value;
        _dataCreated = [[NSDate alloc] init];
        
        NSUUID *uuid = [[NSUUID alloc] init];
        NSString *key = [uuid UUIDString];
        _imageIdentification = key;
    }
    return self;
}

@end
