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
    
    var currentIndex: Int = 0
    
    public var imageList = [UIImage]()
    
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
        
        collectionView!.registerClass(PictureCycleCell.self, forCellWithReuseIdentifier: PictureCycleCellID)
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // 开始时就定位到第2页
        let indexPath = NSIndexPath(forItem: 1, inSection: 0)
        collectionView!.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
    }
    
    //MARK: - UICollectionView的数据源方法public 
    public override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count ?? 0
    }
    
    public override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PictureCycleCellID, forIndexPath: indexPath) as! PictureCycleCell
        
        //Config Cell...
        let index = (indexPath.item - 1 + imageList.count + currentIndex) % imageList.count
        cell.image = imageList[index]
        
        return cell
    }
    
    // MARK: - 实现UIScrollView滚动结束后的代理方法
    public override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    
        let offset = Int(collectionView!.contentOffset.x / collectionView!.bounds.size.width) - 1
        
        if offset != 0 {
            currentIndex = (currentIndex + imageList.count + offset ) % imageList.count
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
        imageView = UIImageView(frame: self.bounds)
        
        addSubview(imageView!)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
