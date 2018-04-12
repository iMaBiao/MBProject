//
//  NSString+Check.h
//  MBProject
//
//  Created by MaBiao on 2018/4/12.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Check)

///将字符串md5
+ (NSString *)md5:(NSString *)originalStr;

///字符串转拼音字符串
+ (NSString *)transformToPinyin:(NSString *)aString;

///手机号码验证
- (BOOL)isValidateMobile;

///中国邮政编码
- (BOOL)isValidatePostCode;

///邮箱格式验证
- (BOOL)isValidateEmail;

///账号格式验证
- (BOOL)isValidateAccount;

///密码格式验证
- (BOOL)isValidatePassword;

///真实姓名格式验证
- (BOOL)isValidateRealName;

///身份证格式验证
- (BOOL)validateIDCardNumber;

///台胞证
- (BOOL)validateTbNo;
///回乡证
- (BOOL)validateHxNo;

@end
