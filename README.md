## CycleView

* The easiest way to use infinite-loop-view
* 用法最简单的无限循环的图片轮播器

## Requirements

* iOS 8.0+ 
* Xcode 6.3


## Usage

### Swift

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
        imageList = arrayM;
    }
    
}

```

