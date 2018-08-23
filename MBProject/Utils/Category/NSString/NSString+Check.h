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

/** 获取UUID */
+ (NSString *)UUID;

/** 是否ASCII码 */
- (BOOL)isASCII;

/** 是否中文 */
- (BOOL)isChinese;

/** 是否包含对应字符 */
- (BOOL)containStr:(NSString *)subString;

/** 拼上字符串 */
- (NSString *)addStr:(NSString *)string;

/** 拼上int字符串 */
- (NSString *)addInt:(int)string;


/** 转为 Data */
@property (nonatomic, copy, readonly) NSData *data;

/** 转为 base64string后的Data */
@property (nonatomic, copy, readonly) NSData *base64Data;

/** 转为 base64String */
@property (nonatomic, copy, readonly) NSString *base64Str;

/** 解 base64str 为 Str 解不了就返回原始的数值 */
@property (nonatomic, copy, readonly) NSString *decodeBase64;

/** 32位MD5加密 */
@property (nonatomic, copy, readonly) NSString *MD5;
/** SHA1加密 */
@property (nonatomic, copy, readonly) NSString *SHA1;

#pragma mark - function
/** 适合的高度 默认 font 宽  */
- (CGFloat)heightWithFont:(NSInteger)font w:(CGFloat)w;

/** 适合的宽度 默认 font 高  */
- (CGFloat)widthWithFont:(NSInteger)font h:(CGFloat)h;

/** 根据字体大小与最大宽度 返回对应的size*/
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
/** 计算富(有间距)文本的NSString高度 */
- (CGFloat)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW lineSpacing:(NSInteger)lineSpacing;
/** 根据字体大小 返回对应的size*/
- (CGSize)sizeWithFont:(UIFont *)font;
@end
