//
//  ViewController.m
//  MetroUIDemo
//
//  Created by 郑庆登(King Zheng)-企业内部系统研发中心 on 2018/7/18.
//  Copyright © 2018年 sinno. All rights reserved.
//

#import "ViewController.h"
#import "SFHomeController.h"
#import "SFNavigationController.h"
@interface ViewController ()
@property(nonatomic,strong)NSMutableArray* array;
@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [NSMutableArray array];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //获取Main.storyboard中的第2个视图
    SFHomeController *controller = [mainStory instantiateViewControllerWithIdentifier:@"HomeSID"];
    [self addChildViewController:controller];
    controller.view.frame = CGRectMake(0, 0, 200, 300);
    
    SFHomeController* controller2 = [mainStory instantiateViewControllerWithIdentifier:@"HomeSID"];
    SFNavigationController* nav = [[SFNavigationController alloc]initWithRootViewController:controller2];
    [self addChildViewController:nav];
    nav.view.frame = CGRectMake(0, 320, 200, 300);
    [self.view addSubview:nav.view];
    nav.view.clipsToBounds = YES;
    [self.view addSubview:controller.view];
    [self.array addObject:controller];
    [self.array addObject:controller2];
//    [controller didMoveToParentViewController:self];
//    [self transitionFromViewController:self toViewController:controller duration:0 options:0 animations:nil completion:^(BOOL finished) {
////        [controller didMoveToParentViewController:self];
//    }];
    self.view.backgroundColor = self.view.backgroundColor;
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
