//
//  UIView+BorderLine.m
//  Car
//
//  Created by MrYeL on 2017/11/27.
//  Copyright © 2017年 wyh. All rights reserved.
//

#import "UIView+BorderLine.h"

@implementation UIView (BorderLine)
- (UIView *)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType {  
    
    if (borderType == UIBorderSideTypeAll) {  
        self.layer.borderWidth = borderWidth;  
        self.layer.borderColor = color.CGColor;  
        return self;  
    }  
    
    
    /// 左侧  
    if (borderType & UIBorderSideTypeLeft) {  
        /// 左侧线路径  
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.f, 0.f) toPoint:CGPointMake(0.0f, self.frame.size.height) color:color borderWidth:borderWidth]];  
    }  
    
    /// 右侧  
    if (borderType & UIBorderSideTypeRight) {  
        /// 右侧线路径  
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(self.frame.size.width, 0.0f) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:color borderWidth:borderWidth]];  
    }  
    
    /// top  
    if (borderType & UIBorderSideTypeTop) {  
        /// top线路径  
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, 0.0f) toPoint:CGPointMake(self.frame.size.width, 0.0f) color:color borderWidth:borderWidth]];  
    }  
    
    /// bottom  
    if (borderType & UIBorderSideTypeBottom) {  
        /// bottom线路径  
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, self.frame.size.height) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:color borderWidth:borderWidth]];  
    }  
    
    return self;  
}  

- (CAShapeLayer *)addLineOriginPoint:(CGPoint)p0 toPoint:(CGPoint)p1 color:(UIColor *)color borderWidth:(CGFloat)borderWidth {  
    
    /// 线的路径  
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];  
    [bezierPath moveToPoint:p0];  
    [bezierPath addLineToPoint:p1];  
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];  
    shapeLayer.strokeColor = color.CGColor;  
    shapeLayer.fillColor  = [UIColor clearColor].CGColor;  
    /// 添加路径
    shapeLayer.path = bezierPath.CGPath;  
    /// 线宽度  
    shapeLayer.lineWidth = borderWidth;  
    return shapeLayer;  
}  

-(void)addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
    [self.layer addSublayer:border];
    
}
-(void)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
    [self.layer addSublayer:border];
    
}
-(void)addLeftBorderWithColor:(UIColor* )color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:border];
    
}
-(void)addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:border];
    
}

- (UIView *)borderForView:(CGFloat )borderWidth color:(UIColor *)color{
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint:CGPointMake(0,self.frame.size.height)];
    
    [bezierPath addLineToPoint:CGPointMake(0, 0)];
    
    [bezierPath addLineToPoint:CGPointMake(self.frame.size.width, 0)];
    
    [bezierPath addLineToPoint:CGPointMake( self.frame.size.width, self.frame.size.height)];
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.strokeColor = color.CGColor;
    
    shapeLayer.fillColor  = [UIColor clearColor].CGColor;
    
    shapeLayer.path = bezierPath.CGPath;
    
    shapeLayer.lineWidth = borderWidth;
    
    [self.layer addSublayer:shapeLayer];
    
    return self;
}


@end
