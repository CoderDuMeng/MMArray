

#import <Foundation/Foundation.h>
@interface MMArray : NSObject
@property (assign , nonatomic)  BOOL isSequence; // default is  YES  Positive sequence
- (int)count;   // get total count
- (void)addObject:(id)obj; // add object
- (id)objectFormIndex:(int)index; // get index object
- (void)removeAll:(void(^)())block;  //remove objects
- (void)enumerateObjectsBlock:(void(^)(int index, id obj ,BOOL *stop))block; // enumerate objes
- (NSString *)description; // No data is returned < NULL >  Otherwise print elements
@end
