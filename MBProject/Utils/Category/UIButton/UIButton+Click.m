//
//  UIButton+Click.m
//  MBProject
//
//  Created by MaBiao on 2018/4/13.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#import "UIButton+Click.h"
#import <objc/runtime.h>

static const void *associatedKey = "associatedKey";

@implementation UIButton (Click)

#pragma mark - 将addTarget改为block
//Category中的属性，只会生成setter和getter方法，不会生成成员变量
- (void)setClick:(clickBlock)click{
    
    objc_setAssociatedObject(self, associatedKey, click, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self removeTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    if (click) {
        [self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
- (clickBlock)click{
    return objc_getAssociatedObject(self, associatedKey);
}
- (void)buttonClick{
    if (self.click) {
        self.click();
    }
}

#pragma mark - 拦截重复点击
// 因category不能添加属性，只能通过关联对象的方式。
static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";

- (NSTimeInterval)acceptEventInterval {
    return  [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setAcceptEventInterval:(NSTimeInterval)acceptEventInterval {
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";

- (NSTimeInterval)acceptEventTime {
    return  [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

- (void)setAcceptEventTime:(NSTimeInterval)acceptEventTime {
    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


// 在load时执行hook
+ (void)load {
    Method before   = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method after    = class_getInstanceMethod(self, @selector(mb_sendAction:to:forEvent:));
    method_exchangeImplementations(before, after);
}

- (void)mb_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if ([NSDate date].timeIntervalSince1970 - self.acceptEventTime < self.acceptEventInterval) {
        return;
    }
    
    if (self.acceptEventInterval > 0) {
        self.acceptEventTime = [NSDate date].timeIntervalSince1970;
    }
    
    [self mb_sendAction:action to:target forEvent:event];
}


@end
