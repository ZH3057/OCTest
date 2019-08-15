//
//  DGOrderedDictionary.m
//  Debugo
//
//  GitHub https://github.com/ripperhe/Debugo
//  Created by ripper on 2018/9/1.
//  Copyright © 2018年 ripper. All rights reserved.
//

#import "DGOrderedDictionary.h"

NSString *DescriptionForObject(NSObject *object, id locale, NSUInteger indent)
{
    NSString *objectString;
    if ([object isKindOfClass:[NSString class]]) {
        objectString = (NSString *)object.copy;
    } else if ([object respondsToSelector:@selector(descriptionWithLocale:indent:)]) {
        objectString = [(NSDictionary *)object descriptionWithLocale:locale indent:indent];
    } else if ([object respondsToSelector:@selector(descriptionWithLocale:)]) {
        objectString = [(NSSet *)object descriptionWithLocale:locale];
    } else {
        objectString = [object description];
    }
    return objectString;
}

@interface DGOrderedDictionary ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;
@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation DGOrderedDictionary

+ (instancetype)dictionary
{
    return [[self alloc] initWithCapacity:0];
}

+ (instancetype)dictionaryWithCapacity:(NSUInteger)numItems
{
    return [[self alloc] initWithCapacity:numItems];
}

- (instancetype)init
{
    return [self initWithCapacity:0];
}

- (instancetype)initWithCapacity:(NSUInteger)numItems
{
    self = [super init];
    if (self) {
        self.dictionary = [NSMutableDictionary dictionaryWithCapacity:numItems];
        self.array = [NSMutableArray arrayWithCapacity:numItems];
    }
    return self;
}

- (instancetype)initWithSortedKeys:(NSArray *)sortedKeys keysAndObjects:(NSDictionary *)keysAndObjects
{
    if (sortedKeys.count != keysAndObjects.allKeys.count) {
        NSAssert(0, @"DGOrderedDictionary: sortKeys 元素值必须和 dictionary 的 key 值一一对应!");
        return nil;
    }
    
    self = [super init];
    if (self) {
        self.dictionary = [NSMutableDictionary dictionaryWithDictionary:keysAndObjects];
        self.array = [NSMutableArray arrayWithArray:sortedKeys];
    }
    return self;
}


- (id)mutableCopyWithZone:(NSZone *)zone
{
    DGOrderedDictionary * copy = [[[self class] alloc] init];
    if (copy) {
        // 单层深拷贝
        copy.dictionary = [self.dictionary mutableCopy];
        copy.array = [self.array mutableCopy];
        copy.moveToLastWhenUpdateValue = self.moveToLastWhenUpdateValue;
    }
    return copy;
}

- (id)copy
{
    NSString *reason = [NSString stringWithFormat:@"-[%@ %@] not supported, please use mutableCopy!", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
    NSLog(@"%@", reason);
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:reason
                                 userInfo:nil];
}

#pragma mark -

- (void)setObject:(id)anObject forKey:(id)aKey
{
    NSAssert(self.array.count == self.dictionary.count, @"DGOrderedDictionary: 内部 dictionary 和 array 值数量不一致");
    if (![self.dictionary objectForKey:aKey]) {
        [self.array addObject:aKey];
    }else {
        if (self.moveToLastWhenUpdateValue) {
            // 移动到最后
            [self.array removeObject:aKey];
            [self.array addObject:aKey];
        }
    }
    
    [self.dictionary setObject:anObject forKey:aKey];
}

- (void)setObject:(id)anObject atIndex:(NSUInteger)anIndex
{
    NSAssert(self.array.count == self.dictionary.count, @"DGOrderedDictionary: 内部 dictionary 和 array 值数量不一致");
    id key = [self.array objectAtIndex:anIndex];
    [self.dictionary setObject:anObject forKey:key];
}

- (void)insertObject:(id)anObject forKey:(id)aKey atIndex:(NSUInteger)anIndex
{
    NSAssert(self.array.count == self.dictionary.count, @"DGOrderedDictionary: 内部 dictionary 和 array 值数量不一致");
    if ([self.dictionary objectForKey:aKey]) {
        [self removeObjectForKey:aKey];
    }
    
    [self.array insertObject:aKey atIndex:anIndex];
    [self.dictionary setObject:anObject forKey:aKey];
}

- (void)removeObjectAtIndex:(NSUInteger)anIndex
{
    id key = [self.array objectAtIndex:anIndex];
    [self.array removeObjectAtIndex:anIndex];
    [self.dictionary removeObjectForKey:key];
}

- (void)removeObjectForKey:(id)aKey
{
    [self.array removeObject:aKey];
    [self.dictionary removeObjectForKey:aKey];
}

- (void)removeAllObjects
{
    [self.array removeAllObjects];
    [self.dictionary removeAllObjects];
}

- (NSUInteger)count
{
    return self.array.count;
}

- (NSDictionary *)keysAndObjects
{
    return self.dictionary.copy;
}

- (id)keyAtIndex:(NSUInteger)anIndex
{
    return [self.array objectAtIndex:anIndex];
}

- (id)objectForKey:(id)aKey
{
    return [self.dictionary objectForKey:aKey];
}

- (id)objectAtIndex:(NSUInteger)anIndex
{
    id key = [self keyAtIndex:anIndex];
    return [self.dictionary objectForKey:key];
}

- (NSArray *)allKeys
{
    return self.dictionary.allKeys;
}

- (NSArray *)allValues
{
    return self.dictionary.allValues;
}

- (NSArray *)sortedKeys
{
    return self.array.copy;
}

- (NSArray *)reverseSortedKeys
{
    NSMutableArray *reverseKeys = [NSMutableArray arrayWithCapacity:self.array.count];
    [self.array enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [reverseKeys addObject:obj];
    }];
    return reverseKeys;
}

- (NSArray *)sortedValues
{
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:self.array.count];
    [self.array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id value = [self.dictionary objectForKey:obj];
        [values addObject:value];
    }];
    return values;
}

- (NSArray *)reverseSortedValues
{
    NSMutableArray *reverseValues = [NSMutableArray arrayWithCapacity:self.array.count];
    [self.array enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id value = [self.dictionary objectForKey:obj];
        [reverseValues addObject:value];
    }];
    return reverseValues;
}

- (NSEnumerator *)keyEnumerator
{
    return [self.array objectEnumerator];
}

- (NSEnumerator *)reverseKeyEnumerator
{
    return [self.array reverseObjectEnumerator];
}

- (void)enumerateKeysAndObjectsUsingBlock:(void (NS_NOESCAPE ^)(id key, id obj, NSUInteger idx, BOOL *stop))block
{
    [self.array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id value = [self.dictionary objectForKey:obj];
        block(obj, value, idx, stop);
    }];
}

- (void)reverseEnumerateKeysAndObjectsUsingBlock:(void (NS_NOESCAPE ^)(id key, id obj, NSUInteger idx, BOOL *stop))block
{
    [self.array enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id value = [self.dictionary objectForKey:obj];
        block(obj, value, idx, stop);
    }];
}

// Xocde console -> po
- (NSString *)description
{
    return [self descriptionWithLocale:nil];
}

// NSLog、Print
- (NSString *)descriptionWithLocale:(nullable id)locale
{
    return [self descriptionWithLocale:locale indent:0];
}

// Nested use DGOrderedDictionary
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    NSMutableString *indentString = [NSMutableString string];
    NSUInteger i, count = level;
    for (i = 0; i < count; i++)
    {
        [indentString appendFormat:@"\t"];
    }
    
    NSMutableString *description = [NSMutableString string];
    [description appendFormat:@"%@{\n", indentString];
    [self.array enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        [description appendFormat:@"%@\t[%zd] %@ = %@;\n",
         indentString,
         idx,
         DescriptionForObject(key, locale, level + 1),
         DescriptionForObject([self.dictionary objectForKey:key], locale, level + 1)];
    }];
    [description appendFormat:@"%@}", indentString];    
    return description;
}

@end
