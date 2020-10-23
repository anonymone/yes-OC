//
//  ImageSectionController.h
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/21.
//

#import "IGListSectionController.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageItem : NSObject <IGListDiffable>
@property (nonatomic, copy) NSString *URL;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGSize *size;

- (instancetype) init:(UIColor *)color itemSize:(CGSize *)size webURL:(NSString *) URL;

@end

@interface ImageSectionController : IGListSectionController<IGListWorkingRangeDelegate>
@property (nonatomic, strong) ImageItem *object;
@property (nonatomic, assign) NSInteger columnNum;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSURLSessionDataTask *task;

@end

NS_ASSUME_NONNULL_END
