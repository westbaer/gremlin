#import "GRTaskQueue.h"
#import "GRResource.h"

#ifdef HAVE_BUGSENSE
#import <BugSense/BugSenseCrashController.h>
#endif

@implementation GRTaskQueue
@synthesize resources;

+ (GRTaskQueue*)sharedQueue
{
    static dispatch_once_t once;
    static GRTaskQueue* sharedQueue;
    dispatch_once(&once, ^{ 
            sharedQueue = [[self alloc] init]; 
    });
    return sharedQueue;
}

- (oneway void)release {}
- (NSUInteger)retainCount { return NSUIntegerMax; }
- (id)retain { return self; }
- (id)autorelease { return self; }

- (id)init
{
    self = [super init];
    if (self != nil) {
        self.maxConcurrentOperationCount = 5;
        self.resources = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addTask:(GRTask*)task 
       importer:(Class<GRImporter>)Importer
      resources:(NSArray*)requiredResources
completionBlock:(GRImportCompletionBlock)complete
{
    NSDictionary* taskInfo = [task dictionaryRepresentation];
    GRImportCompletionBlock done = [complete copy];

    [self addOperationWithBlock:^{
        GRImportOperationBlock import = nil;
        NSError* error = nil;

        @try {
            // ask plugin to generate an import block for this task
            import = [Importer newImportBlock];

            // acquire resource locks
            [GRResource acquireResources:requiredResources];

            // execute import block generated by plugin
            BOOL status = import(taskInfo, &error);

            // unlock resources
            [GRResource relinquishResources:requiredResources];

            // execute the completion block
            done(status, error);
        }
        @catch (NSException* exc) {
            NSLog(@"Import plugin '%@' crashed", NSStringFromClass(Importer));
            done(NO, error);

#ifdef HAVE_BUGSENSE
            BUGSENSE_LOG(exc, NSStringFromClass(Importer));
#endif
        }
        @finally {
            // clean up
            [done release];
            [import release];
        }
    }];
}

@end