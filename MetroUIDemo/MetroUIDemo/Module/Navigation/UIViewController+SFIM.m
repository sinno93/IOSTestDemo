//
//  UIViewController+SFIM.m
//  MetroUIDemo
//
//  Created by 郑庆登(King Zheng)-企业内部系统研发中心 on 2018/7/18.
//  Copyright © 2018年 sinno. All rights reserved.
//

#import "UIViewController+SFIM.h"
#import <objc/runtime.h>
static NSString *nameWithSetterGetterKey = @"nameWithSetterGetterKey";

@implementation UIViewController (SFIM)
-(void)setSFIM_NavigationHidden:(BOOL)hidden{
    NSNumber *number = [NSNumber numberWithBool:hidden];
    objc_setAssociatedObject(self, &nameWithSetterGetterKey, number, OBJC_ASSOCIATION_RETAIN);
}
-(BOOL)SFIM_NavigationHidden{
    NSNumber* number = objc_getAssociatedObject(self, &nameWithSetterGetterKey);
    return [number boolValue];
}
@end
