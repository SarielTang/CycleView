## CycleView

* The easiest way to use infinite-loop-view
* 用法最简单的无限循环的图片轮播器

## Requirements

* iOS 8.0+ 
* Xcode 6.3

## Installation

### CocoaPods

CocoaPods 0.36 adds supports for Swift and embedded frameworks. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate SwiftQRCode into your Xcode project using CocoaPods, specify it in your `Podfile`:

```
platform :ios, '8.0'
use_frameworks!

pod 'CycleView'
```

Then, run the following command:

```bash
$ pod install
```

You should open the `{Project}.xcworkspace` instead of the `{Project}.xcodeproj` after you installed anything from CocoaPods.

For more information about how to use CocoaPods, I suggest [this tutorial](http://www.raywenderlich.com/64546/introduction-to-cocoapods-2).

## 如何使用CycleView
* cocoapods导入：`pod 'CycleView'`
* 手动导入：
    * 将`CycleView/CycleView/Source`文件夹中的所有文件拽入项目中
    * 导入主头文件：`#import "CycleView.h"`

## Usage

### Swift
#### Regulu

```swift
import CycleView

class className : PictureCycleController{
    
    //override loadView function
    //重写loadViewe方法
    override func loadView() {
        super.loadView()
    }
    
    var arrayM: [UIImage]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //input an Array with UIImage
        //传入一个UIImage的图像数组
        CycleImageList = arrayM;
    }
    
}

```

#### Special
```
import CycleView

class AnimatorViewController: CycleAnimatorViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var arrayM = [UIImage]()
        for var i = 0; i < 16; ++i {
            let imageName = String(format: "%02d.jpg", i + 1)
            arrayM.append(UIImage(named: imageName)!)
        }
        AnimatorImageList = arrayM;
        
        //you can modify the animation effect by enumeration type
        //可以通过枚举类型,修改动画效果
        AnimationType = SRTransitionAnimateType.CUBE.rawValue
        //you can change image's contentMode
        //可以设置图片填充模式
        AnimatorImageView!.contentMode = UIViewContentMode.ScaleAspectFit
    }
```
