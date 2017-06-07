//
//  ViewController.m
//  LYZ_Ivar_Property_Demo
//
//  Created by artios on 2017/6/7.
//  Copyright © 2017年 artios. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "MM_Model.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self lyz_ivar];
    
}

/** 成员变量 */
- (void)lyz_ivar{
    unsigned int outCount = 0;
    Ivar * ivars = class_copyIvarList([MM_Model class], &outCount);
    for (unsigned int i = 0; i < outCount; i ++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        const char * type = ivar_getTypeEncoding(ivar);
        NSLog(@"类型为 %s 的 %s ",type, name);
    }
    free(ivars);
    
}

/** 属性列表 */
- (void)lyz_propery{
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList([MM_Model class], &outCount);
    for (unsigned int i = 0; i < outCount; i ++) {
        objc_property_t property = properties[i];
        //属性名
        const char * name = property_getName(property);
        //属性描述
        const char * propertyAttr = property_getAttributes(property);
        NSLog(@"属性描述为 %s 的 %s ", propertyAttr, name);
        
        //属性的特性
        unsigned int attrCount = 0;
        objc_property_attribute_t * attrs = property_copyAttributeList(property, &attrCount);
        for (unsigned int j = 0; j < attrCount; j ++) {
            objc_property_attribute_t attr = attrs[j];
            const char * name = attr.name;
            const char * value = attr.value;
            NSLog(@"属性的描述：%s 值：%s", name, value);
        }
        free(attrs);
        NSLog(@"\n");
    }
    free(properties);
}

/** 私有方法 */
- (void)lyz_private{
    unsigned int count = 0;
    Method *memberFuncs = class_copyMethodList([MM_Model class], &count);//所有在.m文件显式实现的方法都会被找到
    for (int i = 0; i < count; i++) {
        SEL name = method_getName(memberFuncs[i]);
        NSString *methodName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        NSLog(@"member method:%@", methodName);
    }
}


- (void)lyz_printModel{
    
    MM_Model *model = [[MM_Model alloc] init];
    
    model.age = 24;
    model.score = 100;
    model.isAdult = YES;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
