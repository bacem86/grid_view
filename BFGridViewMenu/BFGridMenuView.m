//
//  BFGridMenuView.m
//  SmartMSBusiness
//
//  Created by Bacem on 02/03/2015.
//  Copyright (c) 2015 streamwide. All rights reserved.
//

#import "BFGridMenuView.h"

@interface MenuIndexPath : NSObject{
    
}
@property (nonatomic,assign) NSInteger line;
@property (nonatomic,assign) NSInteger colonne;

+(MenuIndexPath*)menuIndexPathWithLine:(NSInteger)line colonne:(NSInteger)colonne;

@end
@implementation MenuIndexPath

+(MenuIndexPath*)menuIndexPathWithLine:(NSInteger)line colonne:(NSInteger)colonne{
    MenuIndexPath * indexPath = [[MenuIndexPath alloc] init];
    indexPath.line = line;
    indexPath.colonne = colonne;
    return indexPath;
}
@end
@interface BFGridMenuView ()
@property (nonatomic,strong) UIView * container;
@property (nonatomic,strong) NSMutableArray * views;
@property (nonatomic,assign) NSInteger numberOfViews;
@property (nonatomic,assign) NSInteger numberOfColones;
@property (nonatomic,assign) NSInteger numberOfLines;
@end
@implementation BFGridMenuView

-(id)initWithFrame:(CGRect)frame{
    
    if(self=[super initWithFrame:frame]){
        
        
    }
    return self;
}

-(id)init{
    
    if(self=[super init]){
        
    }
    
    return self;
}

-(void)layoutSubviews{
    if(!self.container.superview){
        [self comminInit];
    }
}
-(void)comminInit{
    
    self.backgroundColor = [UIColor clearColor];
    if([self.delegate respondsToSelector:@selector(numberOfViews)]){
        self.numberOfViews  = [self.delegate numberOfViews];
    }
    
    if(self.numberOfViews == 0){
        return;
    }
    if([self.delegate respondsToSelector:@selector(numberOfColones)]){
        self.numberOfColones  = [self.delegate numberOfColones];
    }
    
    if(![self.delegate respondsToSelector:@selector(gridMenuView:viewAtIndex:)]){
        return;
    }
    
    if(self.numberOfViews % self.numberOfColones != 0){
        self.numberOfLines = self.numberOfViews/self.numberOfColones +1;
    }else{
        self.numberOfLines = self.numberOfViews/self.numberOfColones;
    }
    
    
    
    
    self.views = [NSMutableArray arrayWithCapacity:self.numberOfViews];
    [self configureContainer];
    for(NSInteger i = 0; i<self.numberOfViews ; i++){
        UIView * view = [self.delegate gridMenuView:self viewAtIndex:i];
        [self configureview:view atIndex:i];
    }
    
    
}

-(void)configureContainer{
    self.container = [[UIView alloc] init];
    [self addSubview:self.container];
    [self.container setBackgroundColor:[UIColor clearColor]];
    self.container.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.container
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.container.superview
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.container
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.container.superview
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.container
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.container.superview
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.container
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.container.superview
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0
                                                      constant:0]];
    
    
}
-(void)configureview:(UIView*)view atIndex:(NSInteger)index{
    
    
    if(view){
        [self.views addObject:view];
        [self.container addSubview:view];
      //  UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewSelected:)];
        //[view addGestureRecognizer:tapRecognizer];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self configureConstrainstsview:view atIndex:index];
        
    }
}


-(void)configureConstrainstsview:(UIView*)view atIndex:(NSInteger)index{
    MenuIndexPath * indexPath = [self indexPathFromIndex:index];
        CGFloat red = 1.0 ;
        CGFloat blue = ((index *10+ 10.0)/255.0);
        CGFloat green = ((index*10 + 10.0)/255.0);
        view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:0.8];
    
    
  //  view.backgroundColor = [UIColor clearColor];
    if(indexPath.colonne == 0 && indexPath.line == 0){
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:view.superview
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1.0
                                                          constant:self.spacingBetweenViews/2]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:view.superview
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0
                                                          constant:self.spacingBetweenViews/2]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:view.superview
                                                         attribute:NSLayoutAttributeWidth
                                                        multiplier:1.0/self.numberOfColones
                                                          constant:-self.spacingBetweenViews]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:view.superview
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1.0/self.numberOfLines
                                                          constant:-self.spacingBetweenViews]];
        
    }else if(indexPath.colonne == 0 && indexPath.line > 0){
        
        MenuIndexPath * indexPathOfTopview = [MenuIndexPath menuIndexPathWithLine:indexPath.line-1 colonne:indexPath.colonne];
        NSInteger indexOfTopview = [self indexFromIndexPath:indexPathOfTopview];
        UIView * topview = [self.views objectAtIndex:indexOfTopview];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:view.superview
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1.0
                                                          constant:self.spacingBetweenViews/2]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:topview
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:self.spacingBetweenViews]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:view.superview
                                                         attribute:NSLayoutAttributeWidth
                                                        multiplier:1.0/self.numberOfColones
                                                          constant:-self.spacingBetweenViews]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:view.superview
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1.0/self.numberOfLines
                                                          constant:-self.spacingBetweenViews]];
        
        
    } else if(indexPath.colonne >0 && indexPath.line == 0){
        
        
        MenuIndexPath * indexPathOfLeftview = [MenuIndexPath menuIndexPathWithLine:indexPath.line colonne:indexPath.colonne-1];
        NSInteger indexOfLeftview = [self indexFromIndexPath:indexPathOfLeftview];
        UIView * leftview = [self.views objectAtIndex:indexOfLeftview];
        
        
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:leftview
                                                         attribute:NSLayoutAttributeRight
                                                        multiplier:1.0
                                                          constant:self.spacingBetweenViews]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:view.superview
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0
                                                          constant:self.spacingBetweenViews/2]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:view.superview
                                                         attribute:NSLayoutAttributeWidth
                                                        multiplier:1.0/self.numberOfColones
                                                          constant:-self.spacingBetweenViews]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:view.superview
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1.0/self.numberOfLines
                                                          constant:-self.spacingBetweenViews]];
        
        
    } else{
        
        MenuIndexPath * indexPathOfTopview = [MenuIndexPath menuIndexPathWithLine:indexPath.line-1 colonne:indexPath.colonne];
        NSInteger indexOfTopview = [self indexFromIndexPath:indexPathOfTopview];
        UIView * topview = [self.views objectAtIndex:indexOfTopview];
        
        MenuIndexPath * indexPathOfLeftview = [MenuIndexPath menuIndexPathWithLine:indexPath.line colonne:indexPath.colonne-1];
        NSInteger indexOfLeftview = [self indexFromIndexPath:indexPathOfLeftview];
        UIView * leftview = [self.views objectAtIndex:indexOfLeftview];
        
        
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:leftview
                                                         attribute:NSLayoutAttributeRight
                                                        multiplier:1.0
                                                          constant:self.spacingBetweenViews]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:topview
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:self.spacingBetweenViews]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:view.superview
                                                         attribute:NSLayoutAttributeWidth
                                                        multiplier:1.0/self.numberOfColones
                                                          constant:-self.spacingBetweenViews]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:view.superview
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1.0/self.numberOfLines
                                                          constant:-self.spacingBetweenViews]];
        
    }
}


-(void)viewSelected:(UITapGestureRecognizer *)tapRecognizer{
    if([self.delegate respondsToSelector:@selector(gridMenuView:didSelecteViewAtIndex:)]){
        NSInteger index = [self.views indexOfObject:tapRecognizer.view];
        [self.delegate gridMenuView:self didSelecteViewAtIndex:index];
    }
}
-(MenuIndexPath*)indexPathFromIndex:(NSInteger)index{
    
    NSInteger line = 0;
    
    
    line = (index / self.numberOfColones);
    
    
    NSInteger colone = (index % self.numberOfColones);
    MenuIndexPath * indexPath = [MenuIndexPath menuIndexPathWithLine:line colonne:colone];
    
    return  indexPath;
}

-(NSInteger)indexFromIndexPath:(MenuIndexPath*)indexPath{
    
    NSInteger index = indexPath.line * self.numberOfColones + indexPath.colonne;
    
    return index;
}

@end