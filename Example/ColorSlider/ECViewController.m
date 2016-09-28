//
//  ECViewController.m
//  ColorSlider
//
//  Created by Eleven Chen on 09/26/2016.
//  Copyright (c) 2016 Eleven Chen. All rights reserved.
//

#import "ECViewController.h"
#import <ColorSlider/ECColorSlider.h>

@interface ECViewController ()
@property (weak, nonatomic) IBOutlet ECColorSlider *hSlider;
@property (weak, nonatomic) IBOutlet ECColorSlider *sSlider;
@property (weak, nonatomic) IBOutlet ECColorSlider *vSlider;
@property (weak, nonatomic) IBOutlet UIView* preview;
@property (weak, nonatomic) IBOutlet UIView *sliderWrapper;
@end

@implementation ECViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.sSlider.type = S;
    self.vSlider.type = V;
    
    self.hSlider.maxValue = 360;
    self.hSlider.value = 180;
    self.sSlider.value = 50;
    self.vSlider.value = 50;
    
    [_hSlider addTarget:self action:@selector(didColorSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_sSlider addTarget:self action:@selector(didColorSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_vSlider addTarget:self action:@selector(didColorSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self didColorSliderValueChanged:self.hSlider];
    [self didColorSliderValueChanged:self.sSlider];
    [self didColorSliderValueChanged:self.vSlider];
    
    self.preview.layer.cornerRadius = 10;
    self.preview.layer.masksToBounds = YES;
    
    self.sliderWrapper.layer.cornerRadius = 10;
    self.sliderWrapper.layer.masksToBounds = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) didColorSliderValueChanged:(ECColorSlider*) colorSlider
{
    if (colorSlider.type == H) {
        _sSlider.color = colorSlider.color;
    } else if (colorSlider.type == S) {
        _vSlider.color = colorSlider.color;
//        _preview.backgroundColor = colorSlider.color;
    }
    UIColor* color = [UIColor colorWithHue:_hSlider.value/360.0f saturation:_sSlider.value/100.0f brightness:_vSlider.value/100.0f alpha:1.0f];
    _preview.backgroundColor = color;
}

@end
