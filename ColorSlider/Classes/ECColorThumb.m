//
//  ECColorThumb.m
//  Pods
//
//  Created by Eleven Chen on 16/9/28.
//
//

#import "ECColorThumb.h"

@interface ECColorThumb()

@property (nonatomic, strong) UIFont* font;
@property (nonatomic, strong) UIColor* color;
@property (nonatomic, strong) NSAttributedString* attributedString;
@end


@implementation ECColorThumb

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
    self.font = [UIFont boldSystemFontOfSize:11];
    self.text = @"0";
    self.color = [UIColor colorWithRed:204.0f/255.0f green:197.0f/255.0f blue:185.0f/255.0f alpha:1];
}

- (void) setText:(NSString *)text
{
    _text = text;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSDictionary* attrs = @{NSFontAttributeName: self.font, NSForegroundColorAttributeName: self.color};
    self.attributedString = [[NSAttributedString alloc] initWithString:self.text attributes:attrs];
    

    CGSize size = [self.text sizeWithAttributes:attrs];
    [self.attributedString drawAtPoint:CGPointMake(rect.size.width/2 - size.width/2, rect.size.height/2 - size.height/2)];
//    [self.attributedString drawInRect:rect];
}


@end
