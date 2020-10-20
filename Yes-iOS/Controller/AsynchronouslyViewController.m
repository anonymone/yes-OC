//
//  AsynchronouslyViewController.m
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/20.
//

#import "AsynchronouslyViewController.h"

@interface AsynchronouslyViewController ()
@property (nonatomic, strong) UITextView *console;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation AsynchronouslyViewController

- (instancetype) init{
    self = [super init];
    if(self){
        [self setTitle:@"Asychronously Demo"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _operationQueue = [[NSOperationQueue alloc] init];
    [_operationQueue addOperationWithBlock:^(){
        NSLog(@"OperationQueue initialized.");
    }];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //[_operationQueue setSuspended:YES];
    for(int i =0; i<3; i++){
        NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
        NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];
        NSInvocationOperation *op3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task3) object:nil];
        NSInvocationOperation *op4 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task4) object:nil];
        
        [op4 setQueuePriority:NSOperationQueuePriorityHigh];
        
        [_operationQueue addOperation:op1];
        [_operationQueue addOperation:op2];
        [_operationQueue addOperation:op3];
        [_operationQueue addOperation:op4];
    }
    //[_operationQueue setSuspended:NO];
}

- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //[self dispatchSerialDemo];
    //[self dispatchConcurrentDemo];
    //[self dispatchSemaphoreDemo];
    [self nsoperationQueueDemo];
}

#pragma  mark DispatchDemo

- (void) nsoperationQueueDemo{
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(largeTask) object:nil];
    [_operationQueue addOperation:op1];
        
    // runs synchronously
    //[op1 main];
    //[op1 start];
}

- (void) dispatchSemaphoreDemo{
    dispatch_queue_t myConcurrentDispatchQueue = dispatch_queue_create("yes.ios.concurrent.dispatch.normal.semaphore", DISPATCH_QUEUE_CONCURRENT);
    NSString *str = @"Semaphore DisPatch";
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
//    for(int i=0; i<100000; i++){
//        dispatch_async(myConcurrentDispatchQueue, ^(){
//            [array addObject:[NSNumber numberWithInt:i]];
//        });
//    }
//  The method above could be crashed by memory ERROR.
    
    //dispatch_time(DISPATCH_TIME_NOW, 1ull*NSEC_PER_SEC);
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_async(myConcurrentDispatchQueue, ^(){
        for(long i=1; i<=20000000; i++){
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            [array addObject:[NSNumber numberWithInt:(int)i]];
            dispatch_semaphore_signal(semaphore);
            if(i%100000==0){
                NSLog(@"%@ load Data %i 1e5.", str, (int)i/100000);
            }
        }
    });
}

- (void) dispatchBarrierAsyncDemo:(dispatch_queue_t)queue{
    NSString *str = @"Barrier Async";
    dispatch_barrier_async(queue, ^(){
        NSLog(@"%@ %@", str, [self task1]);
    });
    dispatch_barrier_async(queue, ^(){
        NSLog(@"%@ %@", str, [self task2]);
    });
    dispatch_barrier_async(queue, ^(){
        NSLog(@"%@ %@", str, [self task3]);
    });
    dispatch_barrier_async(queue, ^(){
        NSLog(@"%@ %@", str, [self task4]);
    });
}

- (void) dispatchConcurrentDemo{
    dispatch_queue_t myConcurrentDispatchQueue = dispatch_queue_create("yes.ios.concurrent.dispatch.normal", DISPATCH_QUEUE_CONCURRENT);
    
    NSString *str = [NSString stringWithFormat:@"Concurrent Queue."];
    
    dispatch_apply(40, myConcurrentDispatchQueue, ^(size_t index){
        if(index == 0){
            [self dispatchBarrierAsyncDemo:myConcurrentDispatchQueue];
        }
        NSLog(@"%@ %zu", str, index);
    });
}

- (void) dispatchSerialDemo{
    dispatch_queue_t mySerialDispatchQueue = dispatch_queue_create("yes.ios.serial.dispatch", NULL);
    
//    dispatch_queue_t mainDispatch = dispatch_get_main_queue();
//    dispatch_queue_t globalDispatch = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0); // the second parameter is reserverd for future use.
    NSString *str = @"Serial Queue";
    NSLog(str);
    dispatch_async(mySerialDispatchQueue, ^(){
        NSLog(@"%@ %@", str, [self task1]);
    });
    dispatch_async(mySerialDispatchQueue, ^(){
        NSLog(@"%@ %@", str, [self task2]);
    });
    dispatch_async(mySerialDispatchQueue, ^(){
        NSLog(@"%@ %@", str, [self task3]);
    });
    dispatch_async(mySerialDispatchQueue, ^(){
        NSLog(@"%@ %@", str, [self task4]);
    });
    dispatch_async(mySerialDispatchQueue, ^(){
        NSLog(@"%@ %@", str, [self task5]);
    });
    dispatch_async(mySerialDispatchQueue, ^(){
        NSLog(@"%@ %@", str, [self task6]);
    });
    dispatch_async(mySerialDispatchQueue, ^(){
        NSLog(@"%@ %@", str, [self task7]);
    });
    dispatch_async(mySerialDispatchQueue, ^(){
        NSLog(@"%@ %@", str, [self task8]);
    });
    dispatch_async(mySerialDispatchQueue, ^(){
        NSLog(@"%@ %@", str, [self task9]);
    });
    dispatch_async(mySerialDispatchQueue, ^(){
        NSLog(@"%@ %@", str, [self task10]);
    });
}

#pragma mark Tasks

- (void) largeTask{
    NSString *str = @"Large Task.";
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for(long i =0; i<20000000; i++){
        [array addObject:[NSNumber numberWithLong:i]];
        if(i%100000==0){
            NSLog(@"%@ load Data %i 1e5.", str, (int)i/100000);
        }
    }
}

- (NSString *) task1{
    return @"Task 1";
}

- (NSString *) task2{
    return @"Task 2";
}

- (NSString *) task3{
    return @"Task 3";
}

- (NSString *) task4{
    return @"Task 4";
}

- (NSString *) task5{
    return @"Task 5";
}

- (NSString *) task6{
    return @"Task 6";
}

- (NSString *) task7{
    return @"Task 7";
}

- (NSString *) task8{
    return @"Task 8";
}

- (NSString *) task9{
    return @"Task 9";
}

- (NSString *) task10{
    return @"Task 10";
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
