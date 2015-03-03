//
//  ViewController.m
//  SWUIKit
//
//  Created by Bacem on 16/02/2015.
//  Copyright (c) 2015 FR. All rights reserved.
//

#import "ViewController.h"
#import "BFGridMenuView.h"

@interface ViewController () <BFGridMenuViewDelegate>
@property (nonatomic,strong) BFGridMenuView * gridView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    _gridView = [[BFGridMenuView alloc] init];
    _gridView.spacingBetweenViews = 2;
    _gridView.translatesAutoresizingMaskIntoConstraints = NO;
    _gridView.delegate = self;
    [self.view addSubview:_gridView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_gridView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_gridView.superview
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_gridView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_gridView.superview
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_gridView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_gridView.superview
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_gridView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_gridView.superview
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0
                                                           constant:0]];
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark BFGridMenuViewDelegate

-(NSInteger)numberOfColones{
    return 5;
}
-(NSInteger)numberOfViews{
    return 30;
}

-(UIView*)gridMenuView:(BFGridMenuView *)gridMenuView viewAtIndex:(NSInteger)viewIndex{
    UILabel * label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"%ld",(long)viewIndex];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:14.0];
    return label;
    
}
-(void)gridMenuView:(BFGridMenuView *)gridMenuView didSelecteViewAtIndex:(NSInteger)viewIndex{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
