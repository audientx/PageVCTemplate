//
//  PVTViewController.h
//  PageVCTemplate
//
//  Created by Audient Xie on 2017/4/4.
//  Copyright © 2017年 abyss. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PVTHeaderView;

@interface PVTViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *labelInfo;
@property (copy, nonatomic) NSString* categoryName;
@end
