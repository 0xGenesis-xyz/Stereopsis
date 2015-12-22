//
//  ViewController.m
//  Stereopsis
//
//  Created by 张函祎 on 15/12/7.
//  Copyright © 2015年 Sylvanus. All rights reserved.
//

#import "ViewController.h"
#import "HardwareController.h"

#define RATIO 2

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *imageViewArray;
@property (assign, nonatomic) NSInteger selectedModel;
//@property (strong, nonatomic) CADisplayLink *displayLink;
//@property (assign, nonatomic) NSInteger counter;
@property (assign, nonatomic) CGSize deviceFrame;
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
    return self.deviceFrame.height/RATIO;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.deviceFrame.width*0.8;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.imageViewArray count];
}

#pragma mark - Initialization

//- (void)tick:(CADisplayLink *)displayLink{
//    self.counter = (self.counter+1)%16;
//}
//
//- (void)startAnimation {
//    if (self.displayLink == nil) {
//        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
//        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//    }
//}
//
//- (void)completeAnimation{
//    [self.displayLink invalidate];
//    self.displayLink = nil;
//}

- (UIImage *)scaleImage:(UIImage *)image withScale:(CGFloat)scaleSize {
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize, image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width*scaleSize, image.size.height*scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)clipImage:(UIImage *)image frame:(CGSize)frame {
    CGRect rect = CGRectMake((image.size.width-frame.width)/2, (image.size.height-frame.height)/2, frame.width, frame.height);
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}

//- (NSArray *)loadGIF:(NSString *)fileName picNum:(int)num {
//    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:num];
//    for (int i = 1; i<=num; i++) {
//        NSString *path = [NSString stringWithFormat:@"%@%d", fileName, i];
//        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:@"png"]];
//        assert(image);
//        [imageArray addObject:[self scaleImage:image frame:self.deviceFrame]];
//    }
//    return imageArray;
//}

- (void)setupImageArray {
    UIImageView *imageView1 = [[UIImageView alloc] init];
    UIImageView *imageView2 = [[UIImageView alloc] init];
    UIImageView *imageView3 = [[UIImageView alloc] init];
    UIImageView *imageView4 = [[UIImageView alloc] init];
    UIImageView *imageView5 = [[UIImageView alloc] init];
    
//    NSArray *imageArray = [NSArray array];
//    imageArray = [self loadGIF:@"bird" picNum:16];
//    [imageView1 setAnimationImages:imageArray];
//    [imageView1 setContentMode:UIViewContentModeScaleAspectFill];
//    [imageView1 setAnimationDuration:1.0];
//    [imageView1 startAnimating];
//    imageArray = [self loadGIF:@"bird" picNum:16];
//    [imageView2 setAnimationImages:imageArray];
//    [imageView2 setContentMode:UIViewContentModeScaleAspectFill];
//    [imageView2 setAnimationDuration:3.0];
//    [imageView2 startAnimating];
//    imageArray = [self loadGIF:@"bird" picNum:16];
//    [imageView3 setAnimationImages:imageArray];
//    [imageView3 setContentMode:UIViewContentModeScaleAspectFill];
//    [imageView3 setAnimationDuration:1.0];
//    [imageView3 startAnimating];
//    imageArray = [self loadGIF:@"bird" picNum:16];
//    [imageView4 setAnimationImages:imageArray];
//    [imageView4 setContentMode:UIViewContentModeScaleAspectFill];
//    [imageView4 setAnimationDuration:1.0];
//    [imageView4 startAnimating];
//    imageArray = [self loadGIF:@"bird" picNum:16];
    UIImage *image = [[UIImage alloc] init];
    CGFloat scale;
    image = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"Priest" ofType:@"png"]];
    scale = MIN(self.deviceFrame.width/image.size.width, self.deviceFrame.height/(RATIO*image.size.height));
    imageView1.image = [self scaleImage:image withScale:scale];
    [imageView1 setContentMode:UIViewContentModeScaleAspectFill];
    
    image = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"Robot1" ofType:@"png"]];
    scale = MIN(self.deviceFrame.width/image.size.width, self.deviceFrame.height/(RATIO*image.size.height));
    imageView2.image = [self scaleImage:image withScale:scale];
    [imageView2 setContentMode:UIViewContentModeScaleAspectFit];
    
    image = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"Robot2" ofType:@"png"]];
    scale = MIN(self.deviceFrame.width/image.size.width, self.deviceFrame.height/(RATIO*image.size.height));
    imageView3.image = [self scaleImage:image withScale:scale];
    [imageView3 setContentMode:UIViewContentModeScaleAspectFill];
    
    image = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"Bird" ofType:@"png"]];
    scale = MIN(self.deviceFrame.width/image.size.width, self.deviceFrame.height/(RATIO*image.size.height));
    imageView4.image = [self scaleImage:image withScale:scale];
    [imageView4 setContentMode:UIViewContentModeScaleAspectFit];
   /*
    image = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"Bird" ofType:@"png"]];
    scale = MIN(self.deviceFrame.width/image.size.width, self.deviceFrame.height/(RATIO*image.size.height));
    imageView5.image = [self scaleImage:image withScale:scale];
    [imageView5 setContentMode:UIViewContentModeCenter];
    */
    self.imageViewArray = [[NSArray alloc] initWithObjects:imageView1, imageView2, imageView3, imageView4, nil];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    // geometry
    NSLog(@"layout: %f, %f", self.view.frame.size.width, self.view.frame.size.height);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"load: %f, %f", self.view.frame.size.width, self.view.frame.size.height);
    self.deviceFrame = self.view.frame.size;
    UIImage *backgroudImage = [UIImage imageNamed:@"back.png"];
    CGFloat scale = MAX(self.deviceFrame.width/backgroudImage.size.width, self.deviceFrame.height/backgroudImage.size.height);
    self.view.backgroundColor = [UIColor colorWithPatternImage:[self clipImage:[self scaleImage:backgroudImage withScale:scale] frame:self.deviceFrame]];
    [self setupImageArray];
//    self.counter = 0;
//    [self startAnimation];
    self.selectedModel = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
