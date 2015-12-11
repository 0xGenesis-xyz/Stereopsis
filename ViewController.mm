//
//  ViewController.m
//  Stereopsis
//
//  Created by 张函祎 on 15/12/7.
//  Copyright © 2015年 Sylvanus. All rights reserved.
//

#import "ViewController.h"
#import "HardwareController.h"

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *imageArray;
@property (assign, nonatomic) NSInteger selectedModel;
@end

@implementation ViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showModel"]) {
        HardwareController *hardwareController = (HardwareController *)segue.destinationViewController;
        hardwareController.selectedModel = self.selectedModel;
    }
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedModel = row;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UIImageView *imageView = [self.imageArray objectAtIndex:row];
    return [[UIImageView alloc] initWithImage:[imageView image]];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    UIImageView *view = [self.imageArray objectAtIndex:self.selectedModel];
    return view.frame.size.height;
}

//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    
//}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.imageArray count];
}

#pragma mark - Initialization

- (void)setupImageArray {
    UIImage *image1 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_target_1" ofType:@"jpg"]];
    UIImage *image2 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_target_2" ofType:@"jpg"]];
    UIImage *image3 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pointcloud-logo" ofType:@"png"]];
    UIImage *image4 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pointcloud-logo" ofType:@"png"]];
    UIImage *image5 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pointcloud-logo" ofType:@"png"]];
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:image1];
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:image2];
    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:image3];
    UIImageView *imageView4 = [[UIImageView alloc] initWithImage:image3];
    UIImageView *imageView5 = [[UIImageView alloc] initWithImage:image3];
    imageView1.contentMode = UIViewContentModeScaleAspectFit;
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
    imageView3.contentMode = UIViewContentModeScaleAspectFit;
    imageView4.contentMode = UIViewContentModeScaleAspectFit;
    imageView5.contentMode = UIViewContentModeScaleAspectFit;
    self.imageArray = [[NSArray alloc] initWithObjects:imageView1, imageView2, imageView3, imageView4, imageView5, nil];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    // geometry
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    UIImage *backgroudImage = [UIImage imageNamed:@"back"];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroudImage];
    
    [self setupImageArray];
    self.selectedModel = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
