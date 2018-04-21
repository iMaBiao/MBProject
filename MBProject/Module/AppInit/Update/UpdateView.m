//
//  UpdateView.m
//  MBProject
//
//  Created by MaBiao on 2018/4/21.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#import "UpdateView.h"

@interface UpdateView()



@property (nonatomic, strong) UIButton *updateBtn;
@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation UpdateView

- (instancetype)init
{
    if(self = [super init]){
        [self addSubview:self.updateBtn];
        [self addSubview:self.closeBtn];
        
//        self.updateBtn.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//        self.closeBtn.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    }
    return self;
}

#pragma mark - setter
- (void)setVersionModel:(AppVersionModel *)versionModel
{
    _versionModel = versionModel;
    
}


#pragma mark - action
///跳转到一个AppStore更新
- (void)jumpAppStoreAction
{
    NSString *version = [UIDevice currentDevice].systemVersion;
    
    if (version.doubleValue >= 10.0){
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.appStoreUrl] options:nil completionHandler:nil];
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.appStoreUrl]];
    }
}

- (void)closeAction
{
    [self removeFromSuperview];
}

#pragma mark - lazy

- (UIButton *)updateBtn
{
    if(_updateBtn == nil){
        _updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_updateBtn setTitle:@"立即更新" forState:UIControlStateNormal];
        [_updateBtn addTarget:self action:@selector(jumpAppStoreAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _updateBtn;
}

- (UIButton *)closeBtn
{
    if(_closeBtn == nil){
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"Update_Close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}




@end
