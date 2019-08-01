

import UIKit

/*
 浮岛上下摆动、小飞机按照路径飞，逆行。
 封装定点的view以及点击事件
 接口数据获取，浮岛和定点根据场景数据动态匹配
 小飞机的起始位置 n-3（n>3）
 
 
 addScrollView()
 
 let theNumber:CGFloat = 7
 let wateranimationView = RSWaveAnimation.init(frame:CGRect.init(x: 0, y: mScreenH/2, width: theNumber*mScreenW, height: 420),num:Int(theNumber))
 //  wateranimationView.center = self.view
 scrollView.addSubview(wateranimationView)
 wateranimationView.backgroundColor = UIColor.red
 // wateranimationView.movePoint()
 //  wateranimationView.setAnimationNumber(7)
 scrollView.contentSize = CGSize.init(width: wateranimationView.frame.size.width, height: scrollView.contentSize.height)
 
 
 
 */
class RSWaveAnimation:UIView {
    
    //振幅--这个决定波形的起伏高度
    private var waterAmplitude: CGFloat = 0.0
    //频率--这个决定波形的宽度
    private var waterFrequency: CGFloat = 0.0
    //初相:这个决定了波形水平移动的速度
    private var waterEpoch: CGFloat = 0.0
    //偏距--调节距离顶部的高度
    private var waterSetover: CGFloat = 0.0
    //波形整个的宽度
    private var waterWaveWidth: CGFloat = 0.0
    //波形的整个高度
    private var waterWaveHeight: CGFloat = 0.0
    private var theNumber = 0
    
    //*layer
  //  private var waterShapeLayer: CAShapeLayer?
    
    init(frame: CGRect,num:Int) {
        super.init(frame: frame)
        
        waterAmplitude = 210;
        //假设在frame的长度上出现3个完整的波形:注意这里乘以0.5出现震荡效果,如果不乘以0.5只会出现波形平移的效。
        waterWaveWidth = frame.size.width;
        theNumber = num;
        
        waterFrequency = CGFloat(2 * .pi * Double(num)) /  waterWaveWidth ;
        waterEpoch = 0.0;
        waterSetover = 0;
        
       // _waterWaveHeight = CGRectGetHeight(self.frame);
     //   waterShapeLayer.frame = frame
        
        self.waterWaveAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var waterShapeLayer:CAShapeLayer = {
        let wlayer = CAShapeLayer.init()
        wlayer.frame = self.bounds
        wlayer.fillColor = UIColor.clear.cgColor
        wlayer.strokeColor = UIColor.white.cgColor
        wlayer.lineWidth = 7
        wlayer.lineDashPattern = [8,8]
        return wlayer
    }()
    
    func waterWaveAnimation() {
        //创建一个路径
        let path = CGMutablePath()
        //将点移动到 x=0,y=currentK的位置
        path.move(to: CGPoint(x: 0, y: 0), transform: .identity)
        
        for x in 0...Int32(Int(waterWaveWidth)) {
            
            //标准正玄波浪公式
            let y: Float = Float(waterAmplitude) * sinf(Float(waterFrequency) * Float(x) + Float(waterEpoch)) + Float(waterSetover)
            
            if y == 210 || y == -210
            {
                let tempView = UIView.init(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
                tempView.backgroundColor = UIColor.blue
                tempView.center.x = CGFloat(x)
                tempView.center.y = CGFloat(y)

               // CGPoint(x: , y: CGFloat(y)
                self.layer.addSublayer(tempView.layer)
                
                let lView = UIView.init(frame: CGRect(x: 0, y: 0, width: 460, height: 460))
                lView.backgroundColor = UIColor.blue
                
                if y == 210 {
                    lView.center.x = CGFloat(x)
                    lView.center.y = CGFloat(y-29-230)
                }else{
                    lView.center.x = CGFloat(x)
                    lView.center.y = CGFloat(y+89+230)
                }
               
                self.layer.addSublayer(lView.layer)
                
            }
            //将点连成线
            path.addLine(to: CGPoint(x: CGFloat(x), y: CGFloat(y)), transform: .identity)
            //  NSLog(@"%ld-----%f",(long)x,_waterWaveWidth);
        }
        
        
        waterShapeLayer.path = path
        
        self.layer.addSublayer(waterShapeLayer)
        
    }
    
}
