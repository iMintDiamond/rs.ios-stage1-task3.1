#import "PolynomialConverter.h"

@implementation PolynomialConverter
- (NSString*)convertToStringFrom:(NSArray <NSNumber*>*)numbers {
    long count = [numbers count];
    if (count == 0) {
        return nil;
    }
    
    NSMutableString *result = [NSMutableString new];
    long power = count -1;
    bool isFirstAdded = false;
    for (NSNumber *number in numbers) {
        long value = [number longValue];
        if (value == 0) {
            power--;
            continue;
        }
        
        NSMutableString *subresult = [NSMutableString new];
        
        // sign setup
        if (!isFirstAdded) {
            isFirstAdded = true;
            if (value < 0) {
                [subresult appendString:@"- "];
            }
        } else {
            [subresult appendString:value > 0 ? @" + " : @" - "];
        }
        
        value = labs(value);
        
        // value setup
        if (value > 1) {
            [subresult appendString:[[NSString alloc] initWithFormat:@"%ld", value]];
        }
        
        // X setup
        if (power > 0) {
            [subresult appendString:@"x"];
        }
        
        // power setup
        if (power > 1) {
            [subresult appendString:[[NSString alloc] initWithFormat:@"^%ld", power]];
        }

        [result appendString:subresult];
        power--;
    }
    
    return result;
}
@end
