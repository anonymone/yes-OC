//
//  dataImageStore.m
//  
//
//  Created by ShichenPeng on 2020/10/13.
//

#import "dataImageStore.h"
#import "dataImageItem.h"

@interface dataImageStore ()
@property (nonatomic, strong) NSMutableDictionary *gallery;
@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation dataImageStore

+ (instancetype) sharedStore{
    static dataImageStore *gallery = nil;
    if(!gallery){
        gallery = [[self alloc] initPrivate];
    }
    return gallery;
}

- (instancetype) init{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"USE + [dataImageStore sharedStore]" userInfo:nil];
    return nil;
}

- (instancetype) initPrivate{
    self = [super init];
    if(self){
        _gallery = [[NSMutableDictionary alloc] init];
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) setImage:(UIImage *)image forKey:(NSString *)key{
    [_gallery setObject:image forKey:key];
}

- (UIImage *) imageForKey:(NSString *)key{
    return [_gallery objectForKey:key];
}

- (void) deleteImageForKey:(NSString *)key{
    if(!key){
        return;
    }
    [_gallery removeObjectForKey:key];
}

- (NSArray *) allItems
{
    return self.privateItems;
}

- (dataImageItem *)creatItem:(NSString *) name valueInDollars:(NSInteger) value serialNumber:(NSString *) sNumber
{
    dataImageItem *item = [[dataImageItem alloc] initWithName:name valueInDollars:value serialNumber:sNumber];
    [_privateItems addObject:item];
    return item;
}

- (void) removeItem:(dataImageItem *) item
{
    NSString *key = item.imageIdentification;
    [[dataImageStore sharedStore] deleteImageForKey:key];
    [_privateItems removeObjectIdenticalTo:item];
}

- (void) moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    if(fromIndex == toIndex){
        return;
    }
    dataImageItem *item = _privateItems[fromIndex];
    [_privateItems removeObjectAtIndex:fromIndex];
    [_privateItems insertObject:item atIndex:toIndex];
}

- (NSInteger) countOfAllItems{
    return _privateItems.count;
}
@end
