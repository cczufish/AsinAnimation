//
//  ViewController.m
//  Animation
//
//  Created by yu shuhui on 2019/7/29.
//  Copyright © 2019 yu shuhui. All rights reserved.
//

#import "ViewController.h"
#import "JGWaterWaveAnimation.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    JGWaterWaveAnimation *tView = [[JGWaterWaveAnimation alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 400)];
    tView.center = self.view.center;
    [self.view addSubview:tView];
    
    [tView movePoint];
    
}


@end



