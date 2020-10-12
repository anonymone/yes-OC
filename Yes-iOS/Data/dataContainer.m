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

//+ (instancetype) sharedContainer
//{
//    dataContainer *sharedContainer = nil;
////    if (!sharedContainer){
////        sharedContainer = [[self alloc] initPrivate];
////    }
//    return sharedContainer;
//}

- (instancetype) init
{
//    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [dataContainer sharedContainer]" userInfo:nil];
//    return nil;
    self = [super init];
    if(self){
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
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

- (void) removeItem:(dataItem *) item
{
    [_privateItems removeObjectIdenticalTo:item];
}

- (void) moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    if(fromIndex == toIndex){
        return;
    }
    dataItem *item = _privateItems[fromIndex];
    [_privateItems removeObjectAtIndex:fromIndex];
    [_privateItems insertObject:item atIndex:toIndex];
}

- (NSInteger) countOfAllItems{
    return _privateItems.count;
}

@end
