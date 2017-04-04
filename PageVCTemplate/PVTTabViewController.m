//
//  PVTTabViewController.m
//  PageVCTemplate
//
//  Created by Audient Xie on 2017/4/4.
//  Copyright © 2017年 abyss. All rights reserved.
//

#import "PVTTabViewController.h"
#import "PVTHeaderView.h"
#import "PVTViewController.h"

@interface PVTTabViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property (strong, nonatomic) NSArray *vcNames;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSMutableDictionary *dicVCs;

@property (nonatomic, assign) NSInteger tabSelectedIndex;
@property (nonatomic, assign) BOOL isSwitchAnimationPlaying;

@end

@implementation PVTTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self buildTabVCs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)buildTabVCs {
    self.vcNames = @[@"安哥拉",@"贝宁",@"博茨瓦纳",@"英属印度洋领地",@"布基纳法索",@"布隆迪",@"喀麦隆",@"佛得角",@"中非共和国"];
    self.dicVCs = [@{} mutableCopy];
    [self buildVCOfIndex:0];

    UIPageViewController *pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController = pageViewController;
    self.pageViewController.view.frame = self.contentView.bounds;
    [self.contentView addSubview:self.pageViewController.view];
    self.pageViewController.view.backgroundColor = [UIColor clearColor];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    [self addChildViewController:self.pageViewController];
    [self.pageViewController setViewControllers:@[self.dicVCs[self.vcNames[0]]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    
    [self.headerView setupHeaders:self.vcNames];
    for( UIButton *btn in self.headerView.btns ) {
        [btn addTarget:self action:@selector(headerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void) headerBtnPressed:(id)sender {
    NSInteger index = [self.headerView.btns indexOfObject:sender];
    if( index != self.tabSelectedIndex ) {
        [self pageToVCWithIndex:index];
    }
}

- (void)pageToVCWithIndex:(NSInteger)nextIndex {
    UIViewController *currentViewController = [self buildVCOfIndex:nextIndex];
    UIPageViewControllerNavigationDirection direction = (nextIndex < self.tabSelectedIndex) ? UIPageViewControllerNavigationDirectionReverse : UIPageViewControllerNavigationDirectionForward;
    self.tabSelectedIndex = nextIndex;
    __weak typeof(self) weakSelf = self;
    [weakSelf.pageViewController setViewControllers:@[currentViewController] direction:direction animated:YES completion:^(BOOL finished) {
        if (finished) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if(strongSelf.isSwitchAnimationPlaying ) {
                strongSelf.isSwitchAnimationPlaying = NO;
            }
            [strongSelf.headerView slideToIndex:nextIndex];
        }
    }];
}

#pragma mark - util func

- (NSInteger)indexOfContentVC:(UIViewController*)vc {
    if( [vc isKindOfClass:[PVTViewController class]] ) {
        PVTViewController *vcNext = (PVTViewController*)vc;
        NSInteger index = [self.vcNames indexOfObject:vcNext.categoryName];
        return index;
    }
    return -1;
}

- (PVTViewController*)buildVCOfIndex:(NSInteger)index {
    if ( index<0 || index>=self.vcNames.count )
        return nil;
    
    PVTViewController *vc = self.dicVCs[self.vcNames[index]];
    if(!vc) {
        vc = [PVTViewController new];
        vc.categoryName = self.vcNames[index];
        self.dicVCs[vc.categoryName] = vc;
    }
    return vc;
}


#pragma mark - UIPageViewControllerDataSource

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger nextIndex = viewController?[self indexOfContentVC:viewController]-1:self.vcNames.count-1;
    if (nextIndex < self.vcNames.count && nextIndex >= 0) {
        return [self buildVCOfIndex:nextIndex];
    }
    return nil;
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger nextIndex = viewController?[self indexOfContentVC:viewController]+1:0;
    if (nextIndex < self.vcNames.count && nextIndex >= 0) {
        return [self buildVCOfIndex:nextIndex];
    }
    return nil;
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    if (completed) {   //左右划动真正换页结束
        NSUInteger currentVCIndex = [self indexOfContentVC:[pageViewController.viewControllers firstObject]];
        
        self.tabSelectedIndex = currentVCIndex;
        [self.headerView slideToIndex:self.tabSelectedIndex];
    }
    if (finished) {
        //左右划动动画结束 可能没有换页
    }
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
