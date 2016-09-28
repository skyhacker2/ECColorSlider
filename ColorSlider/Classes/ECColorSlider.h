//
//  ECColorSlider.h
//  Pods
//
//  Created by Eleven Chen on 16/9/26.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ECColorSliderType)
{
    H,
    S,
    V
};

@interface ECColorSlider : UIControl
@property (assign, nonatomic) ECColorSliderType type;
@property (strong, nonatomic) UIColor* color;
@property (assign, nonatomic) float value;
@property (assign, nonatomic) float maxValue;
@property (assign, nonatomic) float minValue;
@end
