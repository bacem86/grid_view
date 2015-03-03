//
//  GridMenuView.h
//  SmartMSBusiness
//
//  Created by Bacem on 02/03/2015.
//  Copyright (c) 2015 streamwide. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BFGridMenuViewDelegate;
@interface BFGridMenuView : UIView

@property (nonatomic,weak) id <BFGridMenuViewDelegate> delegate;
@property (nonatomic,assign) CGFloat spacingBetweenViews;

@end

@protocol  BFGridMenuViewDelegate <NSObject>

-(NSInteger)numberOfViews;
-(NSInteger)numberOfColones;
-(UIView * )gridMenuView:(BFGridMenuView*)gridMenuView viewAtIndex:(NSInteger)viewIndex;
-(void)gridMenuView:(BFGridMenuView*)gridMenuView didSelecteViewAtIndex:(NSInteger)viewIndex;

@end
