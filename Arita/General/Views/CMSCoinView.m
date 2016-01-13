//
//  CMSCoinView.m
//  FlipViewTest
//
//  Created by Rebekah Claypool on 10/1/13.
//  Copyright (c) 2013 Coffee Bean Studios. All rights reserved.
//

#import "CMSCoinView.h"


@interface CMSCoinView (){
    bool displayingPrimary;
}
@end

@implementation CMSCoinView

@synthesize primaryView=_primaryView, secondaryView=_secondaryView, spinTime;

- (id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        displayingPrimary = YES;
        spinTime = 1.0;
    }
    return self;
}

- (id) initWithPrimaryView: (UIView *) primaryView andSecondaryView: (UIView *) secondaryView inFrame: (CGRect) frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.primaryView = primaryView;
        self.secondaryView = secondaryView;
        
        displayingPrimary = YES;
        spinTime = 1.0;
    }
    return self;
}

- (void) setPrimaryView:(UIView *)primaryView{
    _primaryView = primaryView;
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.primaryView setFrame: frame];
    [self addSubview: self.primaryView];
}

- (void) setSecondaryView:(UIView *)secondaryView{
    _secondaryView = secondaryView;
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.secondaryView setFrame: frame];
    [self addSubview: self.secondaryView];
    [self sendSubviewToBack:self.secondaryView];
}

-(void) flip {
    [UIView transitionFromView:(displayingPrimary ? self.primaryView : self.secondaryView)
                        toView:(displayingPrimary ? self.secondaryView : self.primaryView)
                      duration: spinTime
                       options: UIViewAnimationOptionTransitionFlipFromLeft+UIViewAnimationOptionCurveEaseInOut
                    completion:^(BOOL finished) {
                        if (finished) {
                            displayingPrimary = !displayingPrimary;
                            [self flip];
                        }
                    }
     ];
}

@end
