#import "Combinator.h"

@implementation Combinator
- (NSNumber*)chechChooseFromArray:(NSArray <NSNumber*>*)array {
    long m = [array[0] longValue];
    long n = [array[1] longValue];
    long factN = [self factorial:n];
    
    for (long i = 1; i < n; i++) {
        if (factN / ([self factorial:i] * [self factorial:(n - i)]) == m ) {
            return [[NSNumber alloc] initWithLong:i];
        }
    }
    
    return nil;
}

- (long)factorial:(long)n {
    if (n == 0) {
        return 1;
    }
    
    return n * [self factorial:n - 1];
}
@end
