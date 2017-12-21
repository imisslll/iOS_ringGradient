//
//  ViewController.m
//  RingGradientAnimatDemo
//
//  Created by 程科 on 2017/12/21.
//  Copyright © 2017年 程科. All rights reserved.
//

#define KShapeLayerRadius 30 // 半径
#define KShapeLayerWidth 8 // 圆环宽

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView * layerImageView; // 渐变层
@property (nonatomic, strong) CAShapeLayer * shapeLayer; // 遮罩layer
@property (nonatomic, strong) CAAnimationGroup * animationGroup; // 动画组

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    
    [self.shapeLayer addAnimation:self.animationGroup forKey:@"MusicPlayerAnimat"];
}


#pragma mark - -- 懒加载

- (UIImageView *)layerImageView {
    
    if (!_layerImageView) {
        
        _layerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gradient.png"]];
        _layerImageView.frame = CGRectMake(100, 100, KShapeLayerRadius * 2, KShapeLayerRadius * 2);
        // 添加遮罩
        _layerImageView.layer.mask = self.shapeLayer;
    }
    
    return _layerImageView;
}
- (CAShapeLayer *)shapeLayer {
    
    if (!_shapeLayer) {
        
        _shapeLayer = [CAShapeLayer layer];
        // 圆环颜色
        _shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        // 圆环中心填充色
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        // 圆环宽
        _shapeLayer.lineWidth = KShapeLayerWidth;
        // 用贝塞尔曲线画圆环
        _shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(KShapeLayerWidth / 2.0, KShapeLayerWidth / 2, KShapeLayerRadius * 2 - KShapeLayerWidth, KShapeLayerRadius * 2 - KShapeLayerWidth) cornerRadius:KShapeLayerRadius - KShapeLayerWidth / 2.0].CGPath;
        // 间断的虚线模式
//        _shapeLayer.lineDashPattern = @[@6,@3];
        // 添加到view.layer
        [self.view.layer addSublayer:_shapeLayer];
        [self.view.layer addSublayer:self.layerImageView.layer];
    }
    
    return _shapeLayer;
}
- (CAAnimationGroup *)animationGroup {
    
    if (!_animationGroup) {
        
        /// 起点动画
        CABasicAnimation * strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        // 线性
        strokeStartAnimation.fromValue = @(-1);
        //        strokeStartAnimation.byValue = @(0);
        strokeStartAnimation.toValue = @(1);
        
        /// 终点动画
        CABasicAnimation * strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeEndAnimation.fromValue = @(0);
        //        strokeEndAnimation.byValue = @(1);
        strokeEndAnimation.toValue = @(1);
        
        // 组合动画
        _animationGroup = [CAAnimationGroup animation];
        _animationGroup.animations = @[strokeEndAnimation, strokeStartAnimation];
        _animationGroup.duration = 2.0;
        _animationGroup.repeatCount = CGFLOAT_MAX;
        _animationGroup.fillMode = kCAFillModeForwards;
        _animationGroup.removedOnCompletion = NO;
    }
    
    return _animationGroup;
}


@end
