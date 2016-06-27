//
//  Viewcontroller1.m
//  NetWorkStatus
//
//  Created by 尹永奇 on 16/6/27.
//  Copyright © 2016年 尹永奇. All rights reserved.
//

#import "Viewcontroller1.h"
#import "YQNetworkStatus.h"

@implementation Viewcontroller1

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

   
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

-(void)viewDidLoad{

    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    NSLog(@"%@",[YQNetworkStatus currentNetworkStatusString]);
    
    [YQNetworkStatus beginListeningInObject:self handle:^(NSString *statusString, YQNetworkStatusType type) {
       
        NSLog(@"%@  %lu",statusString,type);
        
    }];
    
}

@end
