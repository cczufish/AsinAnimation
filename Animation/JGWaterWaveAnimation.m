//
//  JGWaterWaveAnimation.m
//  Animation
//
//  Created by yu shuhui on 2019/7/29.
//  Copyright © 2019 yu shuhui. All rights reserved.
//

#import "JGWaterWaveAnimation.h"

@interface JGWaterWaveAnimation()
{
    //振幅--这个决定波形的起伏高度
    CGFloat _waterAmplitude;
    //频率--这个决定波形的宽度
    CGFloat _waterFrequency;
    //初相:这个决定了波形水平移动的速度
    CGFloat _waterEpoch;
    //偏距--调节距离顶部的高度
    CGFloat _waterSetover;
    
    //波形整个的宽度
    CGFloat _waterWaveWidth;
    //波形的整个高度
    CGFloat _waterWaveHeight;
}
/**layer*/
@property(strong,nonatomic)CAShapeLayer *waterShapeLayer;

@end


@implementation JGWaterWaveAnimation
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _waterAmplitude = 100;
        //假设在frame的长度上出现3个完整的波形:注意这里乘以0.5出现震荡效果,如果不乘以0.5只会出现波形平移的效果。
        _waterFrequency = 2 *M_PI * 1 / frame.size.width ;
        _waterEpoch = 0.0;
        _waterSetover = 0;
        
        _waterWaveWidth = CGRectGetWidth(self.frame);
        _waterWaveHeight = CGRectGetHeight(self.frame);
        
        [self.layer addSublayer:self.waterShapeLayer];
        [self waterWaveAnimation1];

    }
    return self;
}


- (void)waterWaveAnimation2{
    //创建一个路径
    UIBezierPath *waterPath = [UIBezierPath bezierPath];
    [waterPath moveToPoint:CGPointMake(0, 210)];
    [waterPath addCurveToPoint:CGPointMake(self.frame.size.width/4, 420) controlPoint1:CGPointMake(self.frame.size.width/4*3, 0) controlPoint2:CGPointMake(self.frame.size.width, 210)];
    [waterPath stroke];
    
}


- (void)waterWaveAnimation1{
    //创建一个路径
    CGMutablePathRef path = CGPathCreateMutable();
    //将点移动到 x=0,y=currentK的位置
    CGPathMoveToPoint(path, nil, 0, 0);
    for (NSInteger x = 0.0f; x<=_waterWaveWidth; x++) {
       
        if (x == (int)_waterWaveWidth) {
            break;
        }else{
            //标准正玄波浪公式
            CGFloat y = _waterAmplitude * sinf(_waterFrequency * x + _waterEpoch) + _waterSetover;
            
            //将点连成线
            CGPathAddLineToPoint(path, nil, x, y);
            NSLog(@"%ld-----%f",(long)x,_waterWaveWidth);

        }
    }

    
    self.waterShapeLayer.path = path;
    CGPathRelease(path);
}

// 让view对象沿指定的路径进行动画的方法
- (void) movePoint{
    
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //在动画设置一些变量
    pathAnimation.calculationMode = kCAAnimationPaced;
    //我们希望动画持续
    //如果我们动画从左到右的东西——我们想要呆在新位置,
    //然后我们需要这些参数
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 10;//完成动画的时间
    //让循环连续演示
    pathAnimation.repeatCount = 1;
    
    pathAnimation.path = self.waterShapeLayer.path;
    UIImageView *circleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.jpg"]];
    circleView.frame = CGRectMake(1, 1, 40, 40);
    circleView.backgroundColor = [UIColor redColor];
    
    [self addSubview:circleView];
    //添加动画circleView——一旦你添加动画层,动画开始
    [circleView.layer addAnimation:pathAnimation
                            forKey:@"moveTheSquare"];
    
    
}

- (CAShapeLayer *)waterShapeLayer{
    if (!_waterShapeLayer) {
        _waterShapeLayer = [CAShapeLayer layer];
        _waterShapeLayer.frame = self.bounds;
        _waterShapeLayer.fillColor = [UIColor clearColor].CGColor;
        _waterShapeLayer.strokeColor = [UIColor colorWithRed:52/255.0 green:152/255.0 blue:219/255.0 alpha:1.0].CGColor;
        _waterShapeLayer.lineWidth = 7;
        _waterShapeLayer.lineDashPattern = @[@8,@8]; //设置虚线
    }
    return _waterShapeLayer;
}



@end



