

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSWaterWaveAnimation : UIView

- (void) movePoint;

- (void) setAnimationNumber:(int)number;
- (instancetype)initWithFrame:(CGRect)frame num:(int)number;




@end

NS_ASSUME_NONNULL_END
