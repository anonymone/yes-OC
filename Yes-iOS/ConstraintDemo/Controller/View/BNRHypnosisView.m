//
//  BNRHypnosisView.m
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/9.
//

#import "BNRHypnosisView.h"

@implementation BNRHypnosisView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGRect bounds = self.bounds;
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width/2.0;
    center.y = bounds.origin.y + bounds.size.height/2.0;
    float radius = (MAX(bounds.size.width, bounds.size.height)/2.0+20);
    
    // creat draw path.
    UIBezierPath *path = [[UIBezierPath alloc] init];
    for(float currentRadius = radius; currentRadius>0; currentRadius-=20){
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        [path addArcWithCenter:center radius:currentRadius startAngle:0.0 endAngle:M_PI*2.0 clockwise:YES];
    }
    
    [path setLineWidth:10];
    [[UIColor lightGrayColor] setStroke];
    // Draw the path.
    [path stroke];
    
    // load image
    UIImage *star = [UIImage imageNamed:@"star.png"];
    [star drawInRect:CGRectMake(center.x-25, center.y-25, 50, 50)];
}


@end
