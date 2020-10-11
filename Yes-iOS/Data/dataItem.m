//
//  dataItem.m
//  Yes-iOS
//
//  Created by Severus Peng on 2020/10/11.
//

#import "dataItem.h"

@interface dataItem ()

@end

@implementation dataItem

- (instancetype) initWithClass:(Class) withClass
{
    self = [super init];
    if(self){
        self.viewController = [[withClass alloc] init];
        _title = _viewController.title;
    }
    return self;
}

@end
