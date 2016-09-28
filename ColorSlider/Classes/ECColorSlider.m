//
//  ECColorSlider.m
//  Pods
//
//  Created by Eleven Chen on 16/9/26.
//
//

#import "ECColorSlider.h"
#import "ECColorThumb.h"

@interface ECColorSlider()

@property (strong, nonatomic) CAGradientLayer* gradientLayer;
@property (strong, nonatomic) ECColorThumb *thumb;
@property (strong, nonatomic) CALayer* borderLayer;
@property (strong, nonatomic) UILabel* label;
@end

@implementation ECColorSlider
@synthesize color=_color;
- (instancetype) init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup
{
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
    _gradientLayer = [[CAGradientLayer alloc] init];
//    _gradientLayer.masksToBounds = YES;
    _gradientLayer.startPoint = CGPointMake(0, 0.5);
    _gradientLayer.endPoint = CGPointMake(1, 0.5);
    
    self.type = H;
    _color = [UIColor redColor];

    _thumb = [[ECColorThumb alloc] init];
    
    _thumb.backgroundColor = [UIColor whiteColor];
    _thumb.layer.masksToBounds = YES;
    _thumb.userInteractionEnabled = NO;
    
    _minValue = 0;
    _maxValue = 100;
    _value = 0;
    
    _label = [[UITextView alloc] init];
    _label.userInteractionEnabled = NO;
    
}

- (void) setType:(ECColorSliderType)type
{
    _type = type;
    [self updateGradientLayer];
}

- (void) updateGradientLayer
{
    float startPercent = 0.0f;
    if (self.thumb != nil && self.bounds.size.width > 0) {
        startPercent = self.thumb.frame.size.width/2 / self.bounds.size.width;
    }
    if (_type == H) {
        int locationsNumber = 12;
        float delta = (1.0f - startPercent*2) / (locationsNumber-2);
        NSMutableArray* locations = [[NSMutableArray alloc] init];
        [locations addObject:@(0.0f)];
        for (int i = 0; i < (locationsNumber-2); i++) {
            [locations addObject:@(delta * i + startPercent)];
        }
        [locations addObject:@(1.0f)];

        _gradientLayer.locations = [locations copy];
        NSMutableArray* colors = [[NSMutableArray alloc] init];
        [colors addObject:[UIColor redColor].CGColor];
        for (int i = 0; i < locationsNumber-2; i++) {
            UIColor* color = [UIColor colorWithHue:0.1f * i saturation:1.0f brightness:1.0f alpha:1.0f];

            [colors addObject:(__bridge id)color.CGColor];
        }
        [colors addObject:[UIColor redColor].CGColor];
        _gradientLayer.colors = colors;
    } else if (_type == S) {
        NSArray* locations = @[@(0.0f), @(startPercent), @(1.0f-startPercent), @(1.0f)];
        _gradientLayer.locations = locations;
        NSArray* colors = @[(__bridge id)[UIColor whiteColor].CGColor,
                            (__bridge id)[UIColor whiteColor].CGColor,
                            (__bridge id)_color.CGColor,
                            (__bridge id)_color.CGColor];
        _gradientLayer.colors = colors;
    } else if (_type == V) {
        NSArray* locations = @[@(0.0f), @(startPercent), @(1.0f-startPercent), @(1.0f)];
        _gradientLayer.locations = locations;
        NSArray* colors = @[(__bridge id)[UIColor blackColor].CGColor,
                            (__bridge id)[UIColor blackColor].CGColor,
                            (__bridge id)_color.CGColor,
                            (__bridge id)_color.CGColor];
        _gradientLayer.colors = colors;
    }
}

- (void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.layer.cornerRadius = self.bounds.size.height/2;
    if (_gradientLayer.superlayer == nil){
        [self.layer addSublayer:_gradientLayer];
    }
    CGRect gradientLayerRect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    if (!CGRectEqualToRect(_gradientLayer.bounds, gradientLayerRect)) {
        _gradientLayer.frame = gradientLayerRect;
        _gradientLayer.cornerRadius = self.bounds.size.height / 2.0f;
        [self updateGradientLayer];
    }
    
    if (_borderLayer == nil) {
        _borderLayer = [[CALayer alloc] init];
        [self.layer addSublayer:_borderLayer];
        _borderLayer.frame = CGRectMake(-1, -2, self.bounds.size.width+2, self.bounds.size.height + 2);
        _borderLayer.cornerRadius = _borderLayer.frame.size.height/2;
        _borderLayer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.8].CGColor;
        _borderLayer.borderWidth = 1;
        //        _borderLayer.backgroundColor = [UIColor whiteColor].CGColor;
    }
    
    if (_thumb.superview == nil) {
        [self addSubview:_thumb];
    }
//    if (_label.superview == nil) {
//        [_thumb addSubview:_label];
//    }
    if (!CGRectEqualToRect(_thumb.bounds, CGRectMake(0, 0, self.bounds.size.height-2, self.bounds.size.height-2))) {
        _thumb.bounds = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
        _thumb.layer.cornerRadius = _thumb.bounds.size.height/2;
        _thumb.layer.shadowColor = [UIColor blackColor].CGColor;
        _thumb.layer.shadowRadius = 1;
        _thumb.layer.shadowOffset = CGSizeMake(0, 1);
        _thumb.layer.shadowOpacity = 0.5;
        UIBezierPath* shadowPath = [UIBezierPath bezierPathWithOvalInRect:_thumb.bounds];
        _thumb.layer.shadowPath = shadowPath.CGPath;
        [self updateGradientLayer];
        
        
        
        
//        _label.frame = _thumb.bounds;
//        _label.textAlignment = NSTextAlignmentCenter;
//        _label.textColor = [UIColor grayColor];
//        _label.backgroundColor = [UIColor redColor];
////        _label.layer.cornerRadius = _label.frame.size.height/2;
//        _label.layer.masksToBounds = YES;
//        _label.font = [UIFont boldSystemFontOfSize:8];
//        
//        UIFont* font = [UIFont boldSystemFontOfSize:8];

        
//        _label.numberOfLines = 1;
    }
    
    float percent = _value / (_minValue + _maxValue);
    float distance = (self.bounds.size.width - self.bounds.size.height) * percent;
    _thumb.center = CGPointMake(_thumb.bounds.size.width/2 + distance, self.bounds.size.height/2);
    
    

}

- (void) setValue:(float)value
{
    if (value < self.minValue) {
        value = self.minValue;
    }
    if (value > self.maxValue) {
        value = self.maxValue;
    }
    _value = value;
//    self.label.text = [NSString stringWithFormat:@"%d", (int)_value];
    self.thumb.text = [NSString stringWithFormat:@"%d", (int)_value];
    [self setNeedsDisplay];
}

- (void) setMaxValue:(float)maxValue
{
    _maxValue = maxValue;
    [self setNeedsDisplay];
}

- (void) setMinValue:(float)minValue
{
    _minValue = minValue;
    [self setNeedsDisplay];
}

- (void) setColor:(UIColor *)color
{
    _color = color;
    [self updateGradientLayer];
}

- (UIColor*) color
{
    float percent = self.value / (self.maxValue- self.minValue);
    
    if (self.type == H) {
        NSLog(@"percent %f", percent);
        UIColor* c = [UIColor colorWithHue:percent saturation:1 brightness:1 alpha:1];
        CGFloat h;
        [c getHue:&h saturation:NULL brightness:NULL alpha:NULL];
        NSLog(@"%f", h);
        
        return c;
    } else if (self.type == S){
        CGFloat h;
        [_color getHue:&h saturation:NULL brightness:NULL alpha:NULL];
        NSLog(@"%f", h);
        return [UIColor colorWithHue:h saturation:percent brightness:1 alpha:1];
    } else if (self.type == V) {
        CGFloat h;
        [_color getHue:&h saturation:NULL brightness:NULL alpha:NULL];
        return [UIColor colorWithHue:h saturation:1 brightness:percent alpha:1];
    }
    return _color;
}

- (CGSize) intrinsicContentSize
{
    return CGSizeMake(0, 30);
}

- (BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [touch locationInView:self];
    if (CGRectContainsPoint(self.thumb.frame, location)) {
        [self continueTrackingWithTouch:touch withEvent:event];
        [self sendActionsForControlEvents:UIControlEventValueChanged];
        return YES;
    }
    return NO;
}

- (BOOL) continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [touch locationInView:self];
    if (location.x < self.bounds.size.height/2) {
        location.x = self.bounds.size.height/2;
    }
    if (location.x > self.bounds.size.width - self.bounds.size.height/2) {
        location.x = self.bounds.size.width - self.bounds.size.height/2;
    }
    float percent = (location.x - self.bounds.size.height/2) / (self.bounds.size.width - self.bounds.size.height);
    float value = percent * (self.maxValue - self.minValue);
    self.value = value;
    NSLog(@"value = %f", value);
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return YES;
}

- (void) endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self beginTrackingWithTouch:touch withEvent:event];
}


@end
