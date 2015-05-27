//
//  CycleAnimatorViewController.swift
//  CycleView
//
//  Created by xl_bin on 15/5/26.
//  Copyright (c) 2015年 Sariel. All rights reserved.
//

import UIKit
/*

动画类型	说明	对应常量	是否支持方向设置
公开API
fade	淡出效果	kCATransitionFade	是
movein	新视图移动到旧视图上	kCATransitionMoveIn	是
push	新视图推出旧视图	kCATransitionPush	是
reveal	移开旧视图显示新视图	kCATransitionReveal	是
私有API	 	私有API只能通过字符串访问
cube	立方体翻转效果	无	是
oglFlip	翻转效果	无	是
suckEffect	收缩效果	无	否
rippleEffect	水滴波纹效果	无	否
pageCurl	向上翻页效果	无	是
pageUnCurl	向下翻页效果	无	是
cameralIrisHollowOpen	摄像头打开效果	无	否
cameraIrisHollowClose	摄像头关闭效果	无	否
另外对于支持方向设置的动画类型还包含子类型：

动画子类型	说明
kCATransitionFromRight	从右侧转场
kCATransitionFromLeft	从左侧转场
kCATransitionFromTop	从顶部转场
kCATransitionFromBottom	从底部转场

*/
public enum SRTransitionAnimateType: String {
    case FADE = "fade"
    case MOVEIN = "movein"
    case PUSH = "push"
    case REVEAL = "reveal"
    case CUBE = "cube"
    case OGLFLIP = "oglFlip"
    case SUCKEFFECT = "suckEffect"
    case RIPPLEEFFECT = "rippleEffect"
    case PAGECURL = "pageCurl"
    case PAGEUNCURL = "pageUnCurl"
    case CAMERALIRISHOLLOWOPEN = "cameralIrisHollowOpen"
    case CAMERALIRISHOLLOWCLOSE = "cameraIrisHollowClose"
}

public class CycleAnimatorViewController: UIViewController {

    var currentIndex: Int? = 0
    var AnimatorTimer :NSTimer?
    
    //公开变量
    public var AnimatorImageView:UIImageView?
    public var AnimatorImageList = [UIImage]()
    public var AnimationType = SRTransitionAnimateType.CUBE.rawValue
    
    public override func loadView() {
        view = UIView(frame: UIScreen.mainScreen().bounds)
        AnimatorImageView = UIImageView(frame: self.view.bounds)
        view.addSubview(AnimatorImageView!)
        AnimatorImageView?.userInteractionEnabled = true
        
        //设置imageView的约束VFL
        var cons = [AnyObject]()
//        
        cons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[imageView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["imageView": AnimatorImageView!])
        cons += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[imageView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["imageView": AnimatorImageView!])
        view.addConstraints(cons)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let leftSwiperGesture = UISwipeGestureRecognizer(target: self, action: "leftSwipe:")
        leftSwiperGesture.direction = UISwipeGestureRecognizerDirection.Left
        view.addGestureRecognizer(leftSwiperGesture)
        
        let rightSwiperGesture = UISwipeGestureRecognizer(target: self, action: "rightSwipe:")
        rightSwiperGesture.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(rightSwiperGesture)
        
        timeStart()
    }
    
    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        AnimatorImageView?.image = AnimatorImageList[currentIndex!]
    }
    
    func leftSwipe(gestuer:UISwipeGestureRecognizer){
        transitionAnimation(true)
    }
    
    func rightSwipe(gestuer:UISwipeGestureRecognizer){
        transitionAnimation(false)
    }
    
    //MARK: - 设置定时器
    func timeStart() {
        //4 定时器,自动滚动    当时间间隔到达才会执行
        let timer = NSTimer(timeInterval: 2, target: self, selector: "nextImage", userInfo: nil, repeats: true)

        AnimatorTimer = timer;
        //    extern NSString* const  NSDefaultRunLoopMode ;
        //    extern NSString* const  NSRunLoopCommonModes;
        let runloop = NSRunLoop.currentRunLoop()
        runloop.addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    func nextImage() {
        transitionAnimation(true)
    }

    public override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        println(__FUNCTION__)
        AnimatorTimer?.invalidate()
        AnimatorTimer = nil
    }
    public override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        println(__FUNCTION__)
        let timer = NSTimer(timeInterval: 2, target: self, selector: "nextImage", userInfo: nil, repeats: true)
        AnimatorTimer = timer
        let runloop = NSRunLoop.currentRunLoop()
        runloop.addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    
    //转场动画
    func transitionAnimation(isNext:Bool) {
        let transition = CATransition()
        transition.type = AnimationType
        
        //设置子类型
        if (isNext) {
            transition.subtype=kCATransitionFromRight;
        }else{
            transition.subtype=kCATransitionFromLeft;
        }
        //设置动画时常
        transition.duration=1.0;
        
        //3.设置转场后的新视图添加转场动画
        AnimatorImageView!.image = getImage(isNext);
        AnimatorImageView!.layer.addAnimation(transition, forKey: "SRTransitionAnimation")
    }

    //取得当前图片
    func getImage(isNext:Bool) ->(UIImage) {
        if (isNext) {
            currentIndex = (currentIndex!+1)%AnimatorImageList.count;
        }else{
            currentIndex = (currentIndex!-1+AnimatorImageList.count)%AnimatorImageList.count;
        }
        return AnimatorImageList[currentIndex!]
    }
}
