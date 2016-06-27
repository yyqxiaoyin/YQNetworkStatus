//
//  ViewController.m
//  NetWorkStatus
//
//  Created by Mopon on 16/6/24.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "ViewController.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "Reachability.h"
#import "YQNetworkStatus.h"
#import "Viewcontroller1.h"

@interface ViewController ()
@end

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
    Viewcontroller1 *vc = [[Viewcontroller1 alloc]init];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)viewDidLoad {

    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
