//
//  ViewController.m
//  OYRStarViewDemo
//
//  Created by 欧阳荣 on 2021/3/26.
//

#import "ViewController.h"
#import "OYRStarView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat space_Y = 30 + 30;
    
    OYRStarView *starView1 = [[OYRStarView alloc] initWithFrame:CGRectMake(0, 100, 300, 30) starSize:CGSizeZero withStyle:OYRStarTypeInteger starNum:5];
    [self.view addSubview:starView1];
    starView1.star = 4;
    starView1.starBlock = ^(NSString * _Nonnull value) {
        NSLog(@"%@",value);
    };
    starView1.isTouch = YES;
    
    OYRStarView *starView2 = [[OYRStarView alloc] initWithFrame:CGRectMake(0, 100 + space_Y, 300, 30) starSize:CGSizeZero withStyle:OYRStarTypeInteger starNum:8];
    [self.view addSubview:starView2];
    starView2.star = 4;
    starView2.starBlock = ^(NSString * _Nonnull value) {
        NSLog(@"%@",value);
    };
    starView2.isTouch = YES;

    OYRStarView *starView3 = [[OYRStarView alloc] initWithFrame:CGRectMake(0, 100 + 2 * space_Y, 300, 30) starSize:CGSizeZero withStyle:OYRStarTypeFloat starNum:6];
    [self.view addSubview:starView3];
    starView3.star = 4;
    starView3.starBlock = ^(NSString * _Nonnull value) {
        NSLog(@"%@",value);
    };
    starView3.isTouch = YES;

    OYRStarView *starView4 = [[OYRStarView alloc] initWithFrame:CGRectMake(0, 100 + 3 * space_Y, 300, 30) starSize:CGSizeZero withStyle:OYRStarTypeFloat starNum:10];
    [self.view addSubview:starView4];
    starView4.star = 4;
    starView4.starBlock = ^(NSString * _Nonnull value) {
        NSLog(@"%@",value);
    };
    starView4.isTouch = YES;

    
}


@end
