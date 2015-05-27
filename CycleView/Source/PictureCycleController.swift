//
//  PictureCycleController.swift
//  CycleView
//
//  Created by xl_bin on 15/5/20.
//  Copyright (c) 2015年 Sariel. All rights reserved.
//

import UIKit

var PictureCycleCellID = "PictureCycleCellID"

public class PictureCycleController: UICollectionViewController,UICollectionViewDataSource,UIScrollViewDelegate  {
    
    //当前图片索引
    var currentIndex: Int = 0
    //记录当前Cell的索引
    var cellIndex: Int = 0
    var cycleTimer :NSTimer?
    
    public var CycleImageList = [UIImage]()
    //懒加载collection布局
    lazy var layout:UICollectionViewFlowLayout = {
        let l = UICollectionViewFlowLayout()
        l.itemSize = self.view.bounds.size
        l.minimumInteritemSpacing = 0
        l.minimumLineSpacing = 0
        l.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        return l
    }()
    
//    lazy var picCollectionView :UICollectionView = {
//        let cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: self.layout)
//        
//        cv.showsHorizontalScrollIndicator = false
//        cv.showsVerticalScrollIndicator = false
//        cv.pagingEnabled = true
//        //设置collectionView的代理对象
//        cv.dataSource = self
//        return cv
//    }()
    
    //通过代码加载视图
    override public func loadView() {
        view = UIView(frame: UIScreen.mainScreen().bounds)

        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: self.layout)
        
        collectionView!.showsHorizontalScrollIndicator = false
        collectionView!.showsVerticalScrollIndicator = false
        collectionView!.pagingEnabled = true
        //设置collectionView的代理对象
        collectionView!.dataSource = self
//        view.addSubview(picCollectionView)
    }
    //    //通过sb加载视图
    //    override func awakeFromNib() {
    //        super.awakeFromNib()
    //
    //        view.addSubview(collectionView)
    //    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        //注册cell
        collectionView!.registerClass(PictureCycleCell.self, forCellWithReuseIdentifier: PictureCycleCellID)
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // 开始时就定位到第2页
        let indexPath = NSIndexPath(forItem: 1, inSection: 0)
        collectionView!.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
        
        timeStart()
    }
    
    public override func viewDidLayoutSubviews() {
        layout.itemSize = self.view.bounds.size
    }
    
    //MARK: - UICollectionView的数据源方法public 
    public override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CycleImageList.count ?? 0
    }
    
    public override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PictureCycleCellID, forIndexPath: indexPath) as! PictureCycleCell
        
        //Config Cell...
        cellIndex = indexPath.item
        let index = (indexPath.item - 1 + CycleImageList.count + currentIndex) % CycleImageList.count
        cell.image = CycleImageList[index]
        
        return cell
    }
    
    // MARK: - 实现UIScrollView滚动结束后的代理方法
    public override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    
        let offset = Int(collectionView!.contentOffset.x / collectionView!.bounds.size.width) - 1
        
        if offset != 0 {
            currentIndex = (currentIndex + CycleImageList.count + offset ) % CycleImageList.count
            let indexPath = NSIndexPath(forItem: 1, inSection: 0)
            collectionView!.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
            
            UIView.setAnimationsEnabled(false)
            
            self.collectionView!.reloadItemsAtIndexPaths([indexPath])
            
            UIView.setAnimationsEnabled(true)
            
        }
    }

    //MARK: - 设置定时器
    func timeStart() {
        //4 定时器,自动滚动    当时间间隔到达才会执行
        let timer = NSTimer(timeInterval: 2, target: self, selector: "nextImage", userInfo: nil, repeats: true)
        
        cycleTimer = timer;
        //    extern NSString* const  NSDefaultRunLoopMode ;
        //    extern NSString* const  NSRunLoopCommonModes;
        let runloop = NSRunLoop.currentRunLoop()
        runloop.addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    func nextImage() {
        let indexPath = NSIndexPath(forItem: ++cellIndex, inSection: 0)
        collectionView!.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
    }
    
    public override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //开始拖拽,停止定时器
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    public override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let timer = NSTimer(timeInterval: 2, target: self, selector: "nextImage", userInfo: nil, repeats: true)
        cycleTimer = timer
        let runloop = NSRunLoop.currentRunLoop()
        runloop.addTimer(timer, forMode: NSRunLoopCommonModes)
    }

    public override func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        let offset = Int(collectionView!.contentOffset.x / collectionView!.bounds.size.width) - 1
        
        if offset != 0 {
            currentIndex = (currentIndex + CycleImageList.count + offset ) % CycleImageList.count
            let indexPath = NSIndexPath(forItem: 1, inSection: 0)
            collectionView!.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
            
            UIView.setAnimationsEnabled(false)
            
            self.collectionView!.reloadItemsAtIndexPaths([indexPath])
            
            UIView.setAnimationsEnabled(true)
            
        }
    }
}

class PictureCycleCell: UICollectionViewCell {
    
    var imageView: UIImageView?
    
    var image: UIImage? {
        didSet {
            imageView!.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView()
        imageView!.contentMode = UIViewContentMode.ScaleToFill
        addSubview(imageView!)
        
        //设置imageView的约束VFL
        imageView?.setTranslatesAutoresizingMaskIntoConstraints(false)
        var cons = [AnyObject]()
        cons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[imageView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["imageView":imageView!])
        cons += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[imageView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["imageView":imageView!])
        addConstraints(cons)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}










