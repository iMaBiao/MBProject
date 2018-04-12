//
//  NSDate+Extend.m
//  MBProject
//
//  Created by MaBiao on 2018/4/12.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#import "NSDate+Extend.h"

@implementation NSDate (Extend)

/**  是否为今天 */
- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}

/**  是否为昨天 */
- (BOOL)isYesterday
{
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    
    NSDate *selfDate = [self dateWithYMD];
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}

- (NSDate *)dateWithYMD{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}

/**  是否为今年 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}

///年
+ (NSInteger)getYear
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear fromDate:date];
    NSInteger year = [comps year];
    return year;
}

///月
+ (NSInteger)getMonth
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitMonth fromDate:date];
    NSInteger month = [comps month];
    return month;
}

///日
+ (NSInteger)getDay
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitDay fromDate:date];
    NSInteger day = [comps day];
    return day;
}

///判断改日期是否为当月第一天
+ (BOOL)isTheMonthFirstDay:(NSDate *)date
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd"];
    NSString *currentDay=[formatter stringFromDate:date];
    //判断是否是01
    if ([currentDay isEqualToString:@"01"]) {
        return YES;
    }else{
        return NO;
    }
}

///判断改日期是否为当季度第一天
+ (BOOL)isTheQuarterFirstDay:(NSDate *)date
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM"];
    NSString *currentMonth=[formatter stringFromDate:date];
    [formatter setDateFormat:@"dd"];
    NSString *currentDay=[formatter stringFromDate:date];
    //判断是否是01-01  04-01  07-01  10-01
    if ([currentMonth isEqualToString:@"01"] || [currentMonth isEqualToString:@"04"]||[currentMonth isEqualToString:@"07"]||[currentMonth isEqualToString:@"10"]) {
        if ([currentDay isEqualToString:@"01"]) {
            return YES;
        }
    }
    return NO;
}

///判断改日期是否为当年第一天
+ (BOOL)isTheYearFirstDay:(NSDate *)date
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    //    [formatter setDateFormat:@"yyyy"];
    //    NSString *currentYear=[formatter stringFromDate:date];
    [formatter setDateFormat:@"MM"];
    NSString *currentMonth=[formatter stringFromDate:date];
    [formatter setDateFormat:@"dd"];
    NSString *currentDay=[formatter stringFromDate:date];
    //判断是否是01-01
    if ([currentMonth isEqualToString:@"01"] && [currentDay isEqualToString:@"01"]) {
        return YES;
    }else{
        return NO;
    }
}

///获取当前月的第一天和最后一天
+ (NSArray *)getMonthFirstAndLastDayWith:(NSDate *)date
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateStr = [format stringFromDate:date];
    
    NSDate *newDate=[format dateFromString:dateStr];
    
    double interval = 0;
    NSDate *firstDate = nil;
    NSDate *lastDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate];
    
    if (OK) {
        lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
    }else {
        return @[@"",@""];
    }
    
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *firstString = [myDateFormatter stringFromDate: firstDate];
    NSString *lastString = [myDateFormatter stringFromDate: lastDate];
    return @[firstString, lastString];
}
@end
