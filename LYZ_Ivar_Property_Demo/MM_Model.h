//
//  MM_Model.h
//  runtimeDemo
//
//  Created by artios on 2017/6/7.
//  Copyright © 2017年 artios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MM_Model : NSObject
{
    NSString *_name;
}

@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) BOOL      isAdult;

@end
