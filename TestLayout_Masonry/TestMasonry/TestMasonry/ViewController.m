//
//  ViewController.m
//  TestMasonry
//
//  Created by Sinno on 2018/7/15.
//  Copyright © 2018年 sinno. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
@interface ViewController ()
@property(nonatomic,strong)UIView* viewA;
@end

@implementation ViewController
- (IBAction)changeButtonClick:(id)sender {
    static BOOL mark = YES;
    mark = !mark;
    self.viewA.layoutMargins = mark?UIEdgeInsetsMake(20, 20, 20, 20):UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    return;
    self.viewA = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:self.viewA];
//    viewA.preservesSuperviewLayoutMargins
    self.viewA.backgroundColor = [UIColor greenColor];
    NSInteger version = __IPHONE_OS_VERSION_MIN_REQUIRED;
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, -10, -10);
    if (@available(iOS 11.0, *)) {
        [self.viewA mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.view).inset(100);
//            make.top.equalTo(self.topLayoutGuide);
            make.height.width.equalTo(@100);
            make.left.right.equalTo(@88);
            return;
            make.width.equalTo(@100).priorityLow();
            
//            make.height.equalTo(@100);
//            make.centerX.equalTo(self.view);
            
//            make.edges.equalTo(self.view.mas_safeAreaLayoutGuide).inset(10);
//            make.right.equalTo(self.view.mas_right);
//            make.left.equalTo(@10);
            make.left.equalTo(@10);
            make.height.equalTo(@200);
        }];
    } else {
        // iOS11之前不支持安全区范围
    }
    return;
    UIView* viewB = [UIView new];
    viewB.backgroundColor = [UIColor redColor];
    [self.view addSubview:viewB];
    [viewB mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.viewA.mas_leftMargin);
        make.right.equalTo(self.viewA.mas_rightMargin);
        make.top.equalTo(self.viewA.mas_topMargin);
        make.bottom.equalTo(self.viewA.mas_bottomMargin);
//        make.edges.equalTo(self.viewA.mas_safeAreaLayoutGuide).insets(self.viewA.layoutMargins);
    }];
    return;
}

-(void)viewDidLayoutSubviews{
    NSLog(@"safeGUide%@,%f",self.view.safeAreaLayoutGuide,self.topLayoutGuide.length);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
