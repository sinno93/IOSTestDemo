//
//  SFMetroBaseController.m
//  MetroUIDemo
//
//  Created by 郑庆登(King Zheng)-企业内部系统研发中心 on 2018/7/18.
//  Copyright © 2018年 sinno. All rights reserved.
//

#import "SFMetroBaseController.h"
#import "UIViewController+SFIM.h"
@interface SFMetroBaseController ()
@property(nonatomic,strong)UIImageView* backgroundImgView;
@end

@implementation SFMetroBaseController
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.SFIM_NavigationHidden = NO;
    }
    return self;
}
-(instancetype)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle{
    if (self = [super initWithNibName:nibName bundle:bundle]) {
        self.SFIM_NavigationHidden = NO;
    }
    return self;
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view insertSubview:self.backgroundImgView atIndex:0];
    if (!_bgImgName) {
        self.bgImgName = @"MetroDefaultBgImg";
    }
    // Do any additional setup after loading the view.
}

-(void)setBgImgName:(NSString *)bgImgName{
    if ([_bgImgName isEqualToString:bgImgName]) {
        return;
    }
    _bgImgName = bgImgName;
    self.backgroundImgView.image = [UIImage imageNamed:_bgImgName];
    self.backgroundImgView.clipsToBounds = YES;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _backgroundImgView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -懒加载
-(UIImageView*)backgroundImgView{
    if (!_backgroundImgView) {
        _backgroundImgView = [[UIImageView alloc]init];
        _backgroundImgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImgView;
}

@end
