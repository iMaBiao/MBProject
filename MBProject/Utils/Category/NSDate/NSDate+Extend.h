//
//  NSDate+Extend.h
//  MBProject
//
//  Created by MaBiao on 2018/4/12.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extend)

- (BOOL)isToday;
- (BOOL)isYesterday;
- (BOOL)isThisYear;

/**  年月日获得 */
+ (NSInteger)getYear;
+ (NSInteger)getMonth;
+ (NSInteger)getDay;

///判断改日期是否为当月第一天
+ (BOOL)isTheMonthFirstDay:(NSDate *)date;
///判断改日期是否为当季度第一天
+ (BOOL)isTheQuarterFirstDay:(NSDate *)date;
///判断改日期是否为当年第一天
+ (BOOL)isTheYearFirstDay:(NSDate *)date;

/**
 获取当前月的第一天和最后一天
 @param date 日期  yyyy-MM-dd
 @return 数组【第一天，最后一天】
 */
+ (NSArray *)getMonthFirstAndLastDayWith:(NSDate *)date;


/** 获得NSDate对应的小时数  */
- (NSUInteger)hour;

/** 获得NSDate对应的分钟数 */
- (NSUInteger)minute;

/** 获得NSDate对应的秒数 */
- (NSUInteger)second;

/** 获得NSDate对应的星期 */
- (NSUInteger)weekday;

/** 获取当天是当年的第几周 */
- (NSUInteger)weekOfDayInYear;

/** 今天星期几来着？ */
- (NSString *)whatDayTheWeek;
@end
