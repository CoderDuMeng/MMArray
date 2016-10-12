
#import "MMArray.h"

@interface MMNode : NSObject{
    @package
    id     _obj;    //value
    int   _index;   //下标
    MMNode *_next;  //下一个存储对象
}
@end
@implementation MMNode
@end
@interface MMArray(){
    @package
    MMNode *_obj;        //根节点
    MMNode *_nextObj;    //正序的临时变量
    int _count;          //数组的count
}
@end
@implementation MMArray
-(instancetype)init{
    if (self=[super init]) {
        _isSequence = YES;
    }
    return self;
}
-(int)count{
    return _count;
}
- (void)insterNode:(MMNode *)node{
    if (_obj == nil) {
        _obj = node;
    } else {
        if (_isSequence) {
            if (_obj->_next ==  nil) {
                _obj->_next = _nextObj = node;
            } else {
                _nextObj->_next = node;
                _nextObj = _nextObj->_next;
            }
        } else {
            if (_obj == node)return;
            node->_next = _obj;
            _obj = node;
        }
    }
    _count++;
}

- (void)addObject:(id)obj{
    if(obj == nil)return;
    @autoreleasepool {
        MMNode *node = [MMNode new];
        node->_obj = obj;
        node->_index = _count;
        [self insterNode:node];
    }
}
-(id)objectFormIndex:(int)index{
    __block id value;
    if (index > _count-1 || index < 0) return value;
    [self enumerateObjectsBlock:^(int ind, id obj, BOOL *stop) {
        if (index == ind) {
            value = obj;
            *stop = YES;
        }
    }];
    return value;
}
-(void)removeAll:(void (^)())block {
    if (_obj) {
        _obj = nil;
        _count = 0;
        _nextObj = nil;
        if (block)block();
    }
}
-(void)enumerateObjectsBlock:(void (^)(int, id, BOOL *))block{
    if (block == nil) return;
    if (!_obj) return;
    
    MMNode *totalNode = _obj;
    BOOL stop;
    while (YES) {
        id obj = totalNode->_obj;
        block(totalNode->_index,obj,&stop);
        if (stop) break;
        if (totalNode->_next == nil)break;
        totalNode = totalNode->_next;
    }
}

-(NSString *)description{
    if (!_obj) return [NSNull null].description;
    NSMutableString *descr = [NSMutableString string];
    [descr appendString:@"\n(\n"];
    MMNode *total = _obj;
    while (total) {
        id obj = total->_obj;
        if ([obj respondsToSelector:@selector(description)]) {
            [descr appendString:@"  "];
            [descr appendString:[obj description]];
        }
        if (total->_next) {
            [descr appendString:@", \n"];
        }
        total = total->_next;
    }
    [descr appendString:@"\n)"];
    return descr;
}
@end

