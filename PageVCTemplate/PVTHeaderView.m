//
//  PVTHeaderView.m
//  PageVCTemplate
//
//  Created by Audient Xie on 2017/4/4.
//  Copyright © 2017年 abyss. All rights reserved.
//

#import "PVTHeaderView.h"

#define UI_SCREEN_HEIGHT    ([[UIScreen mainScreen] bounds].size.height)
#define UI_SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)

#define HeaderViewHeight 36.f
#define RightSelectBtnWidth 0.f
#define HeaderViewGridFontSize 14.f

#define ScrollWidth (UI_SCREEN_WIDTH - RightSelectBtnWidth)

@interface PVTHeaderView () <UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *viewScroll;
@end

@implementation PVTHeaderView

- (void) awakeFromNib {
    [super awakeFromNib];
    [self setupScroll];
}

-(void) setupScroll {
    UIScrollView *view = [UIScrollView new];
    [view setFrame:CGRectMake(0, 0, ScrollWidth, HeaderViewHeight)];
    view.showsVerticalScrollIndicator = NO;
    view.showsHorizontalScrollIndicator = NO;
    view.backgroundColor = [UIColor whiteColor];
    view.delegate = self;
    self.viewScroll = view;
    [self addSubview:view];
}

-(void) setupHeaders:(NSArray*) arr {
    self.btns = [@[] mutableCopy];
    NSInteger i = 0;
    
    CGFloat posOffset = 0.f;
    for(NSString *str in arr) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat width = str.length * HeaderViewGridFontSize + 20;
        btn.frame = CGRectMake(posOffset, 0, width, HeaderViewHeight);
        posOffset += width;
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn.titleLabel.font = [UIFont systemFontOfSize:HeaderViewGridFontSize];
        [btn setTitle:str forState:UIControlStateNormal];
        [btn setTitleColor:(i==0?[UIColor redColor]:[UIColor blackColor]) forState:UIControlStateNormal];
        [self.btns addObject:btn];
        [self.viewScroll addSubview:btn];
        
        i++;
    }
    [self.viewScroll setContentSize:CGSizeMake(posOffset, HeaderViewHeight)];
}


- (void) slideToIndex:(NSInteger) nextIndex {
    NSInteger i = 0;
    UIButton *nextBtn =  nil;
    for ( UIButton *btn in self.btns ) {
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if( i == nextIndex) {
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            nextBtn = btn;
        }
        i++;
    }
    
    CGRect rect = nextBtn.frame;
    rect.origin.x = rect.origin.x - ScrollWidth/2 + nextBtn.frame.size.width/2;
    rect.size.width = ScrollWidth;
    
    [self.viewScroll scrollRectToVisible:rect animated:YES];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView setContentOffset: CGPointMake(scrollView.contentOffset.x, 0)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
