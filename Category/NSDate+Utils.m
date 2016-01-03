//
//  NSDate+Utils.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/8/6.
//  Copyright (c) 2015年 Uniview. All rights reserved.
//

#import "NSDate+Utils.h"

@implementation NSDate (Utils)

- (NSString*)uv_stringByFmt:(NSString*)fmt_
{
    return [self uv_stringByFmt:fmt_ timeZone:nil];
}

- (NSString*)uv_stringByFmt:(NSString *)fmt_ timeZone:(NSString*)time_
{
    /**
     input:
     [dateFormatter setDateFormat:@"'公元前/后:'G  '年份:'u'='yyyy'='yy '季度:'q'='qqq'='qqqq '月份:'M'='MMM'='MMMM '今天是今年第几周:'w '今天是本月第几周:'W  '今天是今天第几天:'D '今天是本月第几天:'d '星期:'c'='ccc'='cccc '上午/下午:'a '小时:'h'='H '分钟:'m '秒:'s '毫秒:'SSS  '这一天已过多少毫秒:'A  '时区名称:'zzzz'='vvvv '时区编号:'Z "];
     NSLog(@"%@", [dateFormatter stringFromDate:[NSDate date]]);
     
     output 美国:
     公元前/后:AD  年份:2013=2013=13 季度:3=Q3=3rd quarter 月份:8=Aug=August 今天是今年第几周:32 今天是本月第几周:2  今天是今天第几天:219 今天是本月第几天:7 星期:4=Wed=Wednesday 上午/下午:AM 小时:1=1 分钟:24 秒:32 毫秒:463  这一天已过多少毫秒:5072463  时区名称:China Standard Time=China Standard Time 时区编号:+0800
     
     output 中国：
     公元前/后:公元  年份:2013=2013=13 季度:3=三季度=第三季度 月份:8=8月=8月 今天是今年第几周:32 今天是本月第几周:2  今天是今天第几天:219 今天是本月第几天:7 星期:4=周三=星期三 上午/下午:上午 小时:1=1 分钟:44 秒:30 毫秒:360  这一天已过多少毫秒:6270360  时区名称:中国标准时间=中国标准时间 时区编号:+0800
     
     desc:
     a:  AM/PM
     A:  0~86399999 (Millisecond of Day)
     
     c/cc:   1~7 (Day of Week)
     ccc:    Sun/Mon/Tue/Wed/Thu/Fri/Sat
     cccc: Sunday/Monday/Tuesday/Wednesday/Thursday/Friday/Saturday
     
     d:  1~31 (0 padded Day of Month)
     D:  1~366 (0 padded Day of Year)
     
     e:  1~7 (0 padded Day of Week)
     E~EEE:  Sun/Mon/Tue/Wed/Thu/Fri/Sat
     EEEE: Sunday/Monday/Tuesday/Wednesday/Thursday/Friday/Saturday
     
     F:  1~5 (0 padded Week of Month, first day of week = Monday)
     
     g:  Julian Day Number (number of days since 4713 BC January 1)
     G~GGG:  BC/AD (Era Designator Abbreviated)
     GGGG:   Before Christ/Anno Domini
     
     h:  1~12 (0 padded Hour (12hr))
     H:  0~23 (0 padded Hour (24hr))
     
     k:  1~24 (0 padded Hour (24hr)
     K:  0~11 (0 padded Hour (12hr))
     
     L/LL:   1~12 (0 padded Month)
     LLL:    Jan/Feb/Mar/Apr/May/Jun/Jul/Aug/Sep/Oct/Nov/Dec
     LLLL: January/February/March/April/May/June/July/August/September/October/November/December
     
     m:  0~59 (0 padded Minute)
     M/MM:   1~12 (0 padded Month)
     MMM:    Jan/Feb/Mar/Apr/May/Jun/Jul/Aug/Sep/Oct/Nov/Dec
     MMMM: January/February/March/April/May/June/July/August/September/October/November/December
     
     q/qq:   1~4 (0 padded Quarter)
     qqq:    Q1/Q2/Q3/Q4
     qqqq:   1st quarter/2nd quarter/3rd quarter/4th quarter
     Q/QQ:   1~4 (0 padded Quarter)
     QQQ:    Q1/Q2/Q3/Q4
     QQQQ:   1st quarter/2nd quarter/3rd quarter/4th quarter
     
     s:  0~59 (0 padded Second)
     S:  (rounded Sub-Second)
     
     u:  (0 padded Year)
     
     v~vvv:  (General GMT Timezone Abbreviation)
     vvvv:   (General GMT Timezone Name)
     
     w:  1~53 (0 padded Week of Year, 1st day of week = Sunday, NB: 1st week of year starts from the last Sunday of last year)
     W:  1~5 (0 padded Week of Month, 1st day of week = Sunday)
     
     y/yyyy: (Full Year)
     yy/yyy: (2 Digits Year)
     Y/YYYY: (Full Year, starting from the Sunday of the 1st week of year)
     YY/YYY: (2 Digits Year, starting from the Sunday of the 1st week of year)
     
     z~zzz:  (Specific GMT Timezone Abbreviation)
     zzzz:   (Specific GMT Timezone Name)
     Z:  +0000 (RFC 822 Timezone)
     */
    if(fmt_ == nil)
    {
        fmt_ = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:fmt_];
    if(time_)
    {
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:time_];
        [formatter setTimeZone:timeZone];
    }
    return [formatter stringFromDate:self];
}

@end
