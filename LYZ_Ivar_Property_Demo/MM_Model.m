//
//  MM_Model.m
//  runtimeDemo
//
//  Created by artios on 2017/6/7.
//  Copyright © 2017年 artios. All rights reserved.
//

#import "MM_Model.h"
#import <objc/runtime.h>
#import <objc/message.h>


@interface MM_Model ()

@property (nonatomic, assign) NSInteger number;

@end


@implementation MM_Model


- (void)sing{
    NSLog(@">>>>>sing");
}

- (void)say{
    NSLog(@">>>>>>>>say");
}


- (NSString *)description{
    unsigned int count;
    const char *clasName    = object_getClassName(self);
    NSMutableString *string = [NSMutableString stringWithFormat:@"<%s: %p>:[ \n",clasName, self];
    Class clas              = NSClassFromString([NSString stringWithCString:clasName encoding:NSUTF8StringEncoding]);
    Ivar *ivars             = class_copyIvarList(clas, &count);
    
    for (int i = 0; i < count; i++) {
        
        @autoreleasepool {
            
            Ivar       ivar  = ivars[i];
            const char *name = ivar_getName(ivar);
            
            //得到类型
            NSString *type   = [NSString stringWithCString:ivar_getTypeEncoding(ivar) encoding:NSUTF8StringEncoding];
            NSString *key    = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            id       value   = [self valueForKey:key];
            
            //确保BOOL值输出的是YES 或 NO
            if ([type isEqualToString:@"B"]) {
                value = (value == 0 ? @"NO" : @"YES");
            }
            
            [string appendFormat:@"\t%@: %@\n",[self deleteUnderLine:key], value];
        }
    }
    
    [string appendFormat:@"]"];
    
    return string;
}

/// 去掉下划线
- (NSString *)deleteUnderLine:(NSString *)string{
    
    if ([string hasPrefix:@"_"]) {
        return [string substringFromIndex:1];
    }
    return string;
}



@end
