//
//  ImageSectionController.m
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/21.
//

#import "ImageSectionController.h"
#import "ImageDisplayCollectionViewCell.h"

@implementation ImageItem

- (instancetype) init:(UIColor *)color itemSize:(CGSize *)size webURL:(NSString *) URL{
    self = [super init];
    if(self){
        _color = color;
        _URL = URL;
        _size = size;
    }
    return self;
}

- (id<NSObject>) diffIdentifier{
    return self;
}

- (BOOL) isEqualToDiffableObject:(id<IGListDiffable>)object{
    return self == object?YES:[self isEqual:object];
}

@end

@implementation ImageSectionController

- (instancetype) init{
    self = [super init];
    if(self){
        //self.columnNum = 2;
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        //self.inset = UIEdgeInsetsMake(1, 1, 1, 1);
        self.workingRangeDelegate = self;
    }
    return self;
}

#pragma mark IGListSctionType

- (NSInteger) numberOfItems{
    return 1;
}

- (CGSize ) sizeForItemAtIndex:(NSInteger)index{
    return CGSizeMake(_object.size->width,_object.size->height);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    ImageDisplayCollectionViewCell *cell = [self.collectionContext dequeueReusableCellOfClass:[ImageDisplayCollectionViewCell class] forSectionController:self atIndex:index];
    [cell setImage:self.image];
    return cell;
}

- (void) didUpdateToObject:(id)object{
    _object = object;
}

- (void)listAdapter:(IGListAdapter *)listAdapter sectionControllerDidExitWorkingRange:(IGListSectionController *)sectionController{
    
}

- (void) listAdapter:(IGListAdapter *)listAdapter sectionControllerWillEnterWorkingRange:(IGListSectionController *)sectionController{
    if(_image!=nil || _task != nil){
        return;
    }
    
    NSString *urlString = self.object.URL;
    
    NSURL *url = [NSURL URLWithString:urlString];
    _task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        if(error){
            NSLog(@"Load %@ Error with ERROR %@.", urlString, error.localizedDescription);
        }
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^(){
            self.image = image;
            [(ImageDisplayCollectionViewCell *)[self.collectionContext cellForItemAtIndex:0 sectionController:self] setImage:self.image];
        });
    }];
    [_task resume];
}

@end
