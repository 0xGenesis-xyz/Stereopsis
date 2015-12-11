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
@property (strong, nonatomic) NSArray *imageViewArray;
@property (assign, nonatomic) NSInteger selectedModel;
@property (assign, nonatomic) CGFloat deviceFrame;
@property (assign, nonatomic) CGRect viewSize;
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
    UIImageView *imageView = [self.imageViewArray objectAtIndex:row];
    return [[UIImageView alloc] initWithImage:[imageView image]];
//    return [self.imageViewArray objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return self.deviceFrame*0.8;
}

//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    
//}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.imageViewArray count];
}

#pragma mark - Initialization

- (UIImage *)scaleImage:(UIImage *)image {
    float scaleSize = self.deviceFrame*0.8/MIN(image.size.width, image.size.height);
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize, image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width*scaleSize, image.size.height*scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (NSArray *)loadGIF:(NSString *)fileName picNum:(int)num {
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:num];
    for (int i = 1; i<=num; i++) {
        NSString *path = [NSString stringWithFormat:@"%@%d", fileName, i];
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:@"png"]];
        assert(image);
        [imageArray addObject:[self scaleImage:image]];
    }
    return imageArray;
}

- (void)setupImageArray {
    UIImageView *imageView1 = [[UIImageView alloc] init];
    UIImageView *imageView2 = [[UIImageView alloc] init];
    UIImageView *imageView3 = [[UIImageView alloc] init];
    UIImageView *imageView4 = [[UIImageView alloc] init];
    UIImageView *imageView5 = [[UIImageView alloc] init];
    
    NSArray *imageArray = [NSArray array];
    imageArray = [self loadGIF:@"bird" picNum:16];
    [imageView1 setAnimationImages:imageArray];
    [imageView1 setContentMode:UIViewContentModeScaleAspectFill];
    [imageView1 setAnimationDuration:1.0];
    [imageView1 startAnimating];
    imageArray = [self loadGIF:@"bird" picNum:16];
    [imageView2 setAnimationImages:imageArray];
    [imageView2 setContentMode:UIViewContentModeScaleAspectFill];
    [imageView2 setAnimationDuration:3.0];
    [imageView2 startAnimating];
    imageArray = [self loadGIF:@"bird" picNum:16];
    [imageView3 setAnimationImages:imageArray];
    [imageView3 setContentMode:UIViewContentModeScaleAspectFill];
    [imageView3 setAnimationDuration:1.0];
    [imageView3 startAnimating];
    imageArray = [self loadGIF:@"bird" picNum:16];
    [imageView4 setAnimationImages:imageArray];
    [imageView4 setContentMode:UIViewContentModeScaleAspectFill];
    [imageView4 setAnimationDuration:1.0];
    [imageView4 startAnimating];
    imageArray = [self loadGIF:@"bird" picNum:16];
    imageView5.image = [imageArray objectAtIndex:1];
    
    self.imageViewArray = [[NSArray alloc] initWithObjects:imageView1, imageView2, imageView3, imageView4, imageView5, nil];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    // geometry
    NSLog(@"layout: %f, %f", self.view.frame.size.width, self.view.frame.size.height);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    UIImage *backgroudImage = [UIImage imageNamed:@"back"];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroudImage];
    NSLog(@"load: %f, %f", self.view.frame.size.width, self.view.frame.size.height);
    self.deviceFrame = MIN(self.view.frame.size.width, self.view.frame.size.height);
    self.viewSize = CGRectMake(0, 0, self.deviceFrame*0.8, self.deviceFrame*0.8);
    [self setupImageArray];
    self.selectedModel = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
