//
//  MYBasicNavigationController.h
//  MYFreedomLive
//
//  Created by ifly on 2017/3/20.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYBasicNavigationController : UINavigationController


/**
 
 */
@property (nonatomic, strong) NSMutableArray *arrayScreenshot;

/**
 平移手势
 */
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;


@end
