

#import "XLFlipView.h"


@interface XLFlipView (){
    bool displayingPrimary;
}
@end

@implementation XLFlipView

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
//    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//    [self.primaryView setFrame: frame];
//    [self roundView: self.primaryView];
    self.primaryView.userInteractionEnabled = YES;
    [self addSubview: self.primaryView];
    
//    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipTouched:)];
//    gesture.numberOfTapsRequired = 1;
//    [self.primaryView addGestureRecognizer:gesture];
//    [self roundView:self];
}

- (void) setSecondaryView:(UIView *)secondaryView{
    _secondaryView = secondaryView;
    _secondaryView.hidden = YES;
//    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//    [self.secondaryView setFrame: frame];
//    [self roundView: self.secondaryView];
    self.secondaryView.userInteractionEnabled = YES;
    [self addSubview: self.secondaryView];
    [self sendSubviewToBack:self.secondaryView];
    
//    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipTouched:)];
//    gesture.numberOfTapsRequired = 1;
//    [self.secondaryView addGestureRecognizer:gesture];
//    [self roundView:self];
}

//- (void) roundView: (UIView *) view{
//    [view.layer setCornerRadius: (self.frame.size.height/2)];
//    [view.layer setMasksToBounds:YES];
//}

-(void) flipTouched:(id)sender{
    displayingPrimary?(self.secondaryView.hidden = NO):(self.primaryView.hidden = NO);
    [UIView transitionFromView:(displayingPrimary ? self.primaryView : self.secondaryView)
                        toView:(displayingPrimary ? self.secondaryView : self.primaryView)
                      duration: spinTime
                       options: UIViewAnimationOptionTransitionFlipFromLeft+UIViewAnimationOptionCurveEaseInOut
                    completion:^(BOOL finished) {
                        if (finished) {
                            //UIView *view = (displayingPrimary ? view1 : view2);
                            
                            displayingPrimary = !displayingPrimary;
                            displayingPrimary?(self.secondaryView.hidden = YES):(self.primaryView.hidden = YES);
                        }
                    }
     ];
}

@end
