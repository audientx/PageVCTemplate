//
//  PVTTabViewController.h
//  PageVCTemplate
//
//  Created by Audient Xie on 2017/4/4.
//  Copyright © 2017年 abyss. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PVTHeaderView;

@interface PVTTabViewController : UIViewController


@property (weak, nonatomic) IBOutlet PVTHeaderView *headerView;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@end
