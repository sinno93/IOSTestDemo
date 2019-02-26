//
//  SFHomeController.m
//  MetroUIDemo
//
//  Created by 郑庆登(King Zheng)-企业内部系统研发中心 on 2018/7/18.
//  Copyright © 2018年 sinno. All rights reserved.
//

#import "SFHomeController.h"
#import "SFMetroCellBaseModel.h"
#import "SFMetroTypicalCell.h"
#import "ViewController.h"
#import "UIViewController+SFIM.h"

static NSString* const cellId = @"cellId";
@interface SFHomeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@property(nonatomic,strong)NSArray<SFMetroCellBaseModel*>* dataArray;
@end

@implementation SFHomeController
-(UICollectionView*)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:self.flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}
-(UICollectionViewFlowLayout*)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
    }
    return _flowLayout;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%s",__FUNCTION__);
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"%s",__FUNCTION__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通信";
    UIPanGestureRecognizer *panGest = [[UIPanGestureRecognizer alloc]init];
    [self.view addGestureRecognizer:panGest];
    panGest.delegate = self;
    UINib* nib = [UINib nibWithNibName:NSStringFromClass(SFMetroTypicalCell.class) bundle:nil];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:cellId];
    self.flowLayout.itemSize = CGSizeMake(100, 100);
    CGFloat space = 5;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, space, 0, space);
    self.flowLayout.minimumInteritemSpacing = space;
    self.flowLayout.minimumLineSpacing = space;
    NSMutableArray* array = [NSMutableArray array];
    NSArray* imgNameArray = @[@"Subject_dataManager",
                              @"Suject_target",
                              @"Subject_book",
                              @"Subject_chat",
                              @"Subject_stamp",
                              @"Subject_me",
                              @"Subject_me",
                              @"Subject_earth",
                              @"Subject_cakePic",
                              @"Subject_4Square"];
    
    NSArray* colorArray = @[@(0x6189DF),
                            @(0x623CBE),
                            @(0xA0D400),
                            @(0x1487C7),
                            @(0x0FB2DE),
                            @(0x00368E),
                            @(0xCD4400),
                            @(0x8C94AB),
                            @(0xC38B00),
                            @(0xC38B00)];
    for (int i = 0; i<20; i++) {
        SFMetroCellBaseModel* model = [SFMetroCellBaseModel new];
        if (i == 3 || i ==7 || i== 8 ) {
            model.widthType = SFMetroCellWidthTypeMedium;
        }else if (i == 5){
            model.widthType = SFMetroCellWidthTypeFull;
        }else{
            model.widthType = SFMetroCellWidthTypeMinor;
        }
        if(i < imgNameArray.count){
            model.subjectImg = imgNameArray[i];
        }
        if(i<colorArray.count){
            NSNumber* color = colorArray[i];
            
            model.backgroundColor = UIColorFromRGBA([color integerValue], 0.7);
        }else{
            model.backgroundColor = UIColorFromRGBA(0x0FB2DE, 0.7);
        }
        [array addObject:model];
    }
    self.dataArray = [array copy];
    // Do any additional setup after loading the view.
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //获取Main.storyboard中的第2个视图
    SFHomeController *controller = [mainStory instantiateViewControllerWithIdentifier:@"HomeSID"];
    SFMetroCellBaseModel* model = self.dataArray[indexPath.item];
//    获取一个随机整数范围在：[0,100)包括0，不包括100
    controller.SFIM_NavigationHidden = (arc4random() % 100)>50;
    if (self.navigationController.viewControllers.count>200) {
        UIActivityViewController *actContr = [[UIActivityViewController alloc] initWithActivityItems:@[@"nihao1"]  applicationActivities:nil];
        [self presentViewController:actContr animated:YES completion:nil];
        return;
    }
    [self.navigationController pushViewController:controller animated:YES];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SFMetroTypicalCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    SFMetroCellBaseModel* model = self.dataArray[indexPath.item];
    [cell refreshWithModel:model];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat space = 5;
    CGFloat minWidth = (collectionView.bounds.size.width - 4*space)/3.0;
    minWidth = floor(minWidth);
    CGFloat mediumWidth = (collectionView.bounds.size.width - 3*space) - minWidth;
    CGFloat largeWidth = collectionView.bounds.size.width - 2*space;
    SFMetroCellBaseModel* model = self.dataArray[indexPath.item];
    CGFloat targetWidth = 0;
    switch (model.widthType) {
        case SFMetroCellWidthTypeMinor:
            targetWidth = minWidth;
            break;
        case SFMetroCellWidthTypeMedium:
            targetWidth = mediumWidth;
            break;
        default:
            targetWidth = largeWidth;
            break;
    }
    return CGSizeMake(targetWidth, minWidth);
}

#pragma mark -
-(void)willMoveToParentViewController:(UIViewController *)parent{
    [super willMoveToParentViewController:parent];
    NSLog(@"%s",__FUNCTION__);
}
-(void)didMoveToParentViewController:(UIViewController *)parent{
    [super didMoveToParentViewController:parent];
    NSLog(@"%s",__FUNCTION__);
}
-(void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}
@end
