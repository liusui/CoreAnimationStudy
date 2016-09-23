//
//  ViewController.m
//  CoreAnimationStudy
//
//  Created by Liusui on 16/9/21.
//  Copyright © 2016年 liusui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self animation];
    [self heartAnimation];
//    [self menuAnimation];
}
#pragma mark - prgress animation
- (void)animation{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(50, 200)];
    [bezierPath addLineToPoint:CGPointMake(300, 200)];
    
    CAShapeLayer *shapelayer = [CAShapeLayer layer];
    shapelayer.strokeColor = [UIColor blueColor].CGColor;
    shapelayer.fillColor = [UIColor blueColor].CGColor;
    shapelayer.lineWidth = 40;
    shapelayer.lineCap = kCALineCapRound;
    shapelayer.path = bezierPath.CGPath;
    [self.view.layer addSublayer:shapelayer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(52, 202)];
    [path addLineToPoint:CGPointMake(296, 202)];
    
    CAShapeLayer *progresslayer = [CAShapeLayer layer];
    progresslayer.strokeColor = [UIColor orangeColor].CGColor;
    progresslayer.fillColor = [UIColor orangeColor].CGColor;
    progresslayer.lineWidth = 36;
    progresslayer.lineCap = kCALineCapRound;
    progresslayer.path = bezierPath.CGPath;
    [self.view.layer addSublayer:progresslayer];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"strokeEnd";
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.duration = 5.0f;
    animation.removedOnCompletion = NO;
    [progresslayer addAnimation:animation forKey:nil];
}
#pragma mark - red heart animation
- (void)heartAnimation{
    self.view.backgroundColor = [UIColor purpleColor];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 200, 100, 100)];
    [path addClip];
    [path stroke];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 250) radius:50 startAngle:0 endAngle:360 clockwise:YES];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.path = path.CGPath;
    [self.view.layer addSublayer:layer];

    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.path = maskPath.CGPath;
    mask.opacity = 0.8;
    mask.backgroundColor = [UIColor greenColor].CGColor;
//    mask.frame = CGRectMake(100, 200, 100, 100);
    
    [layer addSublayer:mask];
    [layer setMask:mask];
    
    CGPoint point = [self calcCircleCoordinateWithCenter:CGPointMake(150, 250) andWithAngle:300 andWithRadius:50];
    UIBezierPath *ovalpath = [UIBezierPath bezierPath];
    [ovalpath addArcWithCenter:CGPointMake(point.x + sqrtf(1500), point.y + sqrtf(1500)) radius:50 startAngle:0 endAngle:360 clockwise:YES];
    
    CAShapeLayer *ovalLayer = [CAShapeLayer layer];
    ovalLayer.path = ovalpath.CGPath;
    ovalLayer.fillColor = [UIColor grayColor].CGColor;
    [layer addSublayer:ovalLayer];
//    [self.view.layer setMask:mask];
    [ovalLayer addAnimation:[self animationWithStartPath:ovalpath endPath:path] forKey:nil];
    
    UIImageView *iamgeView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"case.png"]];
    iamgeView.frame = CGRectMake(120, 220, 60, 60);
    [self.view addSubview:iamgeView];
    
    [iamgeView.layer addAnimation:[self animationGroup] forKey:nil];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIImageView *heartImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"heart01.png"]];
        heartImgView.frame = CGRectMake(110, 210, 80, 80);
        [self.view addSubview:heartImgView];
        [ovalLayer addAnimation:[self animationWithStartPath:path endPath:ovalpath] forKey:nil];
        [heartImgView.layer addAnimation:[self heartAnimationGroup] forKey:nil];
    });
}

- (CAAnimationGroup *)animationGroup{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(0.0);
    animation.toValue = @(-M_PI / 4);
    animation.duration = 1;
    animation.beginTime = 0.2;
    
    CABasicAnimation *opacAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacAnimation.toValue = [NSNumber numberWithFloat:0.0];
    animation.duration = 1.8;
    animation.beginTime = 0.2;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[animation,opacAnimation];
    animationGroup.duration = 2;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    return animationGroup;
}

- (CAAnimationGroup *)heartAnimationGroup{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(M_PI /4);
    animation.toValue = @(0.0);
    animation.duration = 1;
    animation.beginTime = 0.0;
    
    CABasicAnimation *opacAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacAnimation.fromValue = [NSNumber numberWithFloat:0.2];
    opacAnimation.toValue = [NSNumber numberWithFloat:1];
    animation.duration = 1.8;
    animation.beginTime = 0.0;
    
    CABasicAnimation *scalAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scalAnimation.fromValue = [NSNumber numberWithFloat:0.4];
    scalAnimation.toValue = [NSNumber numberWithFloat:1.0];
    scalAnimation.duration = 2;
    scalAnimation.beginTime = 0.0;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[animation,opacAnimation,scalAnimation];
    animationGroup.duration = 2;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    return animationGroup;
}

- (CABasicAnimation *)animationWithStartPath:(UIBezierPath *)startPath endPath:(UIBezierPath *)endpath{
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"path";
    basicAnimation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    basicAnimation.toValue = (__bridge id _Nullable)(endpath.CGPath);
    basicAnimation.duration = 2.0f;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    return basicAnimation;
}

//计算圆上的坐标
- (CGPoint)calcCircleCoordinateWithCenter:(CGPoint)center  andWithAngle:(CGFloat)angle andWithRadius:(CGFloat)radius{
    CGFloat x2 = radius * cosf(angle * M_PI / 180);
    CGFloat y2 = radius * sinf(angle * M_PI / 180);
    return CGPointMake(center.x + x2, center.y - y2);
}

#pragma mark - menu
- (void)menuAnimation{
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(120, 200, 100, 100)];
//    
//    CAShapeLayer *layer = [CAShapeLayer layer];
//    layer.frame = CGRectMake(0, 0, 100, 100);
//    layer.path = path.CGPath;
//    layer.fillColor = [UIColor blueColor].CGColor;
//    [self.view.layer addSublayer:layer];
//    
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = CGRectMake(0, 0, 100, 100);
//    gradientLayer.colors = @[(id)[UIColor blueColor].CGColor,
//                             (id)[UIColor yellowColor].CGColor,
//                             (id)[UIColor redColor].CGColor];
//    gradientLayer.locations = @[@(0.1f),@(0.4f)];
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(0, 1);
//    [layer addSublayer:gradientLayer];
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 addArcWithCenter:CGPointMake(200, 250) radius:50 startAngle:0 endAngle:(CGFloat)(90 * M_PI / 180) clockwise:true];
    
    CAShapeLayer *layer1 = [CAShapeLayer layer];
    layer1.path = [path1 CGPath];
    layer1.fillColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer1];
}

#pragma mark - rotation
- (void)rotationAnimation{
    UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(120, 200, 100, 100)];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
