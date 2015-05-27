//
//  AnimatorViewController.swift
//  CycleViewDemo
//
//  Created by xl_bin on 15/5/27.
//  Copyright (c) 2015年 Sariel. All rights reserved.
//

import UIKit
import CycleView

class AnimatorViewController: CycleAnimatorViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var arrayM = [UIImage]()
        
        for var i = 0; i < 10; ++i {
            let imageName = String(format: "%02d.jpg", i + 1)
            arrayM.append(UIImage(named: imageName)!)
        }
//        println(arrayM)
        AnimatorImageList = arrayM;
        AnimationType = SRTransitionAnimateType.CUBE.rawValue
        AnimatorImageView!.contentMode = UIViewContentMode.ScaleAspectFit
    }

}
