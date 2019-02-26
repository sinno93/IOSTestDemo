//
//  SFNavigationController.m
//  MetroUIDemo
//
//  Created by 郑庆登(King Zheng)-企业内部系统研发中心 on 2018/7/18.
//  Copyright © 2018年 sinno. All rights reserved.
//

#import "SFNavigationController.h"
#import "UIViewController+SFIM.h"

@interface SFNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property(weak,nonatomic)UIGestureRecognizer *gest;

@end

@implementation SFNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    // 设置全屏滑动返回
    id target = self.interactivePopGestureRecognizer.delegate;
    UIScreenEdgePanGestureRecognizer * gesture = self.interactivePopGestureRecognizer;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    SEL selector = @selector(handleNavigationTransition:);
#pragma clang diagnostic pop
    // 如果支持全屏返回就使用全屏返回
    if ([target respondsToSelector:selector]) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:selector];
        [self.view addGestureRecognizer:pan];
        self.interactivePopGestureRecognizer.enabled = NO;
        pan.delegate=self;
        self.gest = pan;
    }else{
        self.gest = self.interactivePopGestureRecognizer;
        self.gest.delegate = self;
    }
    
    // Do any additional setup after loading the view.
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    viewController.hidesBottomBarWhenPushed = YES;
    // 处理返回
    if (self.viewControllers.count>0) {
        UIBarButtonItem* spaceItem = [self spaceItemWithSpace:-20];
        UIBarButtonItem* backItem = [self backButtonItem];
        viewController.navigationItem.leftBarButtonItems = @[spaceItem,backItem];
        viewController.navigationItem.titleView = [UIView new];
    }
    [super pushViewController:viewController animated:animated];
}
#pragma mark -
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL navigationHidden = viewController.SFIM_NavigationHidden;
    
    [self setNavigationBarHidden:navigationHidden animated:YES];
}



// 解决手势问题
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer == self.gest) {
        if (self.viewControllers.count>1) {
            CGPoint velocity = [(UIPanGestureRecognizer*)gestureRecognizer velocityInView:gestureRecognizer.view];
            BOOL isHorizontalSwipe = fabs(velocity.x) > fabs(velocity.y);
            
            return isHorizontalSwipe && velocity.x >0;
        }else{
            return NO;
        }
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
-(UIBarButtonItem*)backButtonItem{
    UIButton* button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    button.backgroundColor = [UIColor redColor];
    [button setImage:[UIImage imageNamed:@"btn_back_white_normal"] forState:UIControlStateNormal];
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithCustomView:button];
    return item;
}
-(UIBarButtonItem*)spaceItemWithSpace:(CGFloat)space{
    UIBarButtonItem*  negativeSpacer=  [[UIBarButtonItem alloc]
                                        initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                        target:nil action:nil];
    negativeSpacer.width = space;
    return negativeSpacer;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
