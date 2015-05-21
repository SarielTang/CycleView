//
//  CycleViewController.swift
//  cycleView
//
//  Created by Sariel's Mac on 15-5-18.
//  Copyright (c) 2015年 Sariel. All rights reserved.
//

import UIKit


public class CycleViewController: UICollectionViewController {
    
    public var CycleViewLayout: UICollectionViewFlowLayout?
    
    public var imageList = [String]()
    
    public var CycleViewCellID = String()
    
    public var cycleView: UICollectionView?
    
    var currentIndex: Int = 0
    
//    public class func cycleView(view:UIView,layout:UICollectionViewFlowLayout,cellID:String,imageList:String) {
//        CycleViewLayout = layout
//        self.imageList = imageList
//        CycleViewCellID = cellID
//        CycleView = view
//    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Register cell classes
        
        println("viewDidLoad:\(imageList)")
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 设置布局属性
        CycleViewLayout?.itemSize = cycleView!.bounds.size
        CycleViewLayout?.minimumInteritemSpacing = 0
        CycleViewLayout?.minimumLineSpacing = 0
        CycleViewLayout?.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        // 继承自 UIScrollView
        collectionView?.pagingEnabled = true;
        collectionView?.showsHorizontalScrollIndicator = true;
        //        println("viewDidLayoutSubviews:\(imageList)")
        // 设置图像的索引
        currentIndex = 0;
        println("viewdidLayoutSubViews____")
    }
    
    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        println("viewWillAppear:\(imageList)")
    }
    
    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // 让滚动视图滚动到第一个索引项，直接定位到图片
        let indexPath = NSIndexPath(forItem: 1, inSection: 0)
        collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
        
        println("viewDidAppear:\(imageList)")
    }

    // MARK: - UICollectionViewDataSource
    
    override public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count ?? 0
    }

    override public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CycleViewCellID, forIndexPath: indexPath) as UICollectionViewCell
    
        let imageView = UIImageView(frame: cell.bounds)
        cell.addSubview(imageView)
        // Configure the cell
        // 根据当前显示的图像索引来设置图像
        if imageList.count != 0 {
            let index = (indexPath.item - 1 + imageList.count + self.currentIndex) % imageList.count
            imageView.image = UIImage(named: imageList[index])
        }
//
//        NSLog(@"%@ 照片索引 %zd", indexPath, self.currentIndex);

//        cell.imageName = imageList[indexPath.item]
    
        return cell
    }

    //MARK: - UIScrollViewDelegate
    // 停止滚动代理方法
    
//    override public func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
//        let offset = Int(scrollView.contentOffset.x / scrollView.bounds.size.width) - 1;
//        if offset != 0{
//            currentIndex = (currentIndex + offset + self.imageList.count) % self.imageList.count;
//            // 直接跳回到第一个页面
//            let indexPath = NSIndexPath(forItem: 1, inSection: 0)
//            collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
//            
//            // 解决 collectionView 的动画bug
//            // 1. 关闭动画
//            UIView.setAnimationsEnabled(false)
//            // 2. 直接刷新第一页的cell
//            collectionView?.reloadItemsAtIndexPaths([indexPath])
//            // 3. 打开动画
//            UIView.setAnimationsEnabled(true)
//        }
//    }
    
//    - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    
//    // 计算偏移，判断照片是否需要更换
//    NSInteger offset = scrollView.contentOffset.x / scrollView.bounds.size.width - 1;
//    //    NSLog(@"%zd", offset);
//    
//    if (offset != 0) {
//    self.currentIndex = (self.currentIndex + offset + self.imageList.count) % self.imageList.count;
//    
//    // 直接跳回到第一个页面
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
//    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
//    
//    // 解决 collectionView 的动画bug
//    // 1. 关闭动画
//    [UIView setAnimationsEnabled:NO];
//    // 2. 直接刷新第一页的cell
//    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
//    // 3. 打开动画
//    [UIView setAnimationsEnabled:YES];
//    }
//    }
    
    
    // MARK: - UICollectionViewDelegate
    
    // cell 显示完成调用
    // 注意：参数：cell&indexPath都是之前消失的那个 cell 的
//    override public func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
    
//        // 获取正在显示的cell
//        println(collectionView.indexPathsForVisibleItems())
//        let path = collectionView.indexPathsForVisibleItems().last as! NSIndexPath
//        
//        if path.item == imageCount - 1 {
//            // 根据 indexPath 获得到 cell
//            let cell = collectionView.cellForItemAtIndexPath(path) as! NewFeatureCell
//            // 播放动画
//            cell.showStartButton()
//        }
//    }


}
