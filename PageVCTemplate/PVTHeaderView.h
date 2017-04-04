//
//  PVTHeaderView.h
//  PageVCTemplate
//
//  Created by Audient Xie on 2017/4/4.
//  Copyright © 2017年 abyss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PVTHeaderView : UIView
@property (strong, nonatomic) NSMutableArray *btns;

-(void) setupHeaders:(NSArray*) arr;

-(void) slideToIndex:(NSInteger) nextIndex;
@end
