//
//  dataContainer.m
//  Yes-iOS
//
//  Created by Severus Peng on 2020/10/11.
//

#import "dataContainer.h"
#import "dataItem.h"

@interface dataContainer ()
@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation dataContainer

+ (instancetype) sharedContainer
{
    static dataContainer *sharedContainer = nil;
    if (!sharedContainer){
        sharedContainer = [[self alloc] initPrivate];
    }
    return sharedContainer;
}

- (instancetype) init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [dataContainer sharedContainer]" userInfo:nil];
    return nil;
}

- (instancetype) initPrivate
{
    self = [super init];
    if(self){
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *) allItems
{
    return self.privateItems;
}

- (dataItem *)creatItem:(Class)withClass
{
    dataItem *item = [[dataItem alloc] initWithClass:withClass];
    [_privateItems addObject:item];
    return item;
}

- (NSInteger) countOfAllItems{
    return _privateItems.count;
}

@end
