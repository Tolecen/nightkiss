

#import <UIKit/UIKit.h>

@interface XLFlipView : UIView

- (id) initWithPrimaryView: (UIView *) view1 andSecondaryView: (UIView *) view2 inFrame: (CGRect) frame;

@property (nonatomic, retain) UIView *primaryView;
@property (nonatomic, retain) UIView *secondaryView;
@property float spinTime;

-(void) flipTouched:(id)sender;

@end
