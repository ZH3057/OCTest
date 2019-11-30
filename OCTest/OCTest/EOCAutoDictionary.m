//
//  EOCAutoDictionary.m
//  OCTest
//
//  Created by Jun Zhou on 2019/11/30.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import "EOCAutoDictionary.h"
#import <objc/runtime.h>

@interface EOCAutoDictionary ()

@property (strong, nonatomic) NSMutableDictionary *backingStore;

@end

@implementation EOCAutoDictionary

@dynamic string, number, date, opaqueObject;

id autoDictionaryGetter(id self, SEL _cmd);
void autoDictionarySetter(id self, SEL _cmd, id value);

- (instancetype)init {
    if (self = [super init]) {
        _backingStore = NSMutableDictionary.new;
    }
    return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    if (/* selector from dynamic property */) {
        NSString *selectorString = NSStringFromSelector(sel);
        if ([selectorString hasPrefix:@"set"]) {
            class_addMethod(self, sel, (IMP)autoDictionarySetter, "v@:@");
        } else  {
            class_addMethod(self, sel, (IMP)autoDictionaryGetter, "@@:");
        }
        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
}

id autoDictionaryGetter(id self, SEL _cmd) {
    // Get the backing store from the object
    EOCAutoDictionary *typeSelf = (EOCAutoDictionary *)self;
    NSMutableDictionary *backingStore = typeSelf.backingStore;
    
    // The key is simply the selector name
    NSString *key = NSStringFromSelector(_cmd);
    
    // Return the value
    return [backingStore objectForKey:key];
}

void autoDictionarySetter(id self, SEL _cmd, id value) {
    // Get the backing store from the object
    EOCAutoDictionary *typeSelf = (EOCAutoDictionary *)self;
    NSMutableDictionary *backingStore = typeSelf.backingStore;
    
    NSString *selectorString = NSStringFromSelector(_cmd);
    NSMutableString *key = selectorString.mutableCopy;
    
    // Remove the ":" at the end
    [key deleteCharactersInRange:NSMakeRange(key.length - 1, 1)];
    
    // Remove the 'set' prefix
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    
    // Lowercase the first character
    NSString *lowercaseFirstChar = [key substringToIndex:1].lowercaseString;
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowercaseFirstChar];
    
    if (value) {
        [backingStore setObject:value forKey:key];
    } else {
        [backingStore removeObjectForKey:key];
    }
}

@end
