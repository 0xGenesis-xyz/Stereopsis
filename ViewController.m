//
//  ViewController.m
//  Stereopsis
//
//  Created by 张函祎 on 15/12/7.
//  Copyright © 2015年 Sylvanus. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *imageArray;
@property (assign, nonatomic) NSInteger selectedIndex;
@end

@implementation ViewController

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedIndex = row;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UIImageView *imageView = [self.imageArray objectAtIndex:row];
    return [[UIImageView alloc] initWithImage:[imageView image]];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return self.view.frame.size.height/2;
}

//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    
//}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 2;
}

#pragma mark - Initialization

- (void)setupImageArray {
    UIImage *image1 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_target_1" ofType:@"jpg"]];
    UIImage *image2 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_target_2" ofType:@"jpg"]];
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:image1];
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:image2];
    self.imageArray = [[NSArray alloc] initWithObjects:imageView1, imageView2, nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupImageArray];
    self.selectedIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
