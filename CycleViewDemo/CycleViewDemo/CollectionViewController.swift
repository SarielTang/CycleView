//
//  CollectionViewController.swift
//  CycleViewDemo
//
//  Created by Sariel's Mac on 15-5-18.
//  Copyright (c) 2015年 Sariel. All rights reserved.
//

import UIKit
import CycleView

class CollectionViewController: CycleViewController {

    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
println(collectionView?.frame)
        println("viewDidLoad")
        
        var arrayM = [String]()
        
        for var i = 0; i < 10; ++i {
            let imageName = String(format: "%02d.jpg", i + 1)
            arrayM.append(imageName)
        }
        imageList = arrayM;
        
        println(imageList)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println(collectionView?.frame)
        println("viewWillAppear=====")
    }
    
    override func viewDidLayoutSubviews() {
        CycleViewLayout = self.layout
        
        CycleViewCellID = "Cell"
        
        cycleView = self.collectionView!
        
        
        super.viewDidLayoutSubviews()
        println(collectionView?.frame)
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
