//
//  CopyrightViewController.m
//  Stereopsis
//
//  Created by 张函祎 on 15/12/11.
//  Copyright © 2015年 Sylvanus. All rights reserved.
//

#import "CopyrightViewController.h"

@interface CopyrightViewController ()
@end

@implementation CopyrightViewController

- (IBAction)done {
    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
