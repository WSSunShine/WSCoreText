# WSCoreText

WSCoreText  is order to use low-level CoreText APIs conveniently to build your app, current functions contains Text & Graphics &  user-defined click event.Waiting for improvement.

##Installation with CocoaPods

[CocoaPods](http://cocoapods.org/)is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like WSCoreText in your projects.You can install it with the following command:

```
$ sudo gem install cocoapods
```

##### Podfile

To integrate AFNetworking into your Xcode project using CocoaPods, specify it in your `Podfile`

```
platform:ios, '9.0'
target 'name' do
 pod 'WSCoreText'
end
```

## Requirements

| WSCoreText Version | Minimum iOS Target |
| :----------------: | :----------------: |
|       0.0.1        |        9.0         |

 ## Usage

```objective-c
		//构建图片模型
WSImageInfo * imageInfo = [[WSImageInfo alloc] initWithImage:[UIImage imageNamed:@"share_copy"] position:CGRectZero callback:^{
        //callback 
    }];
    NSArray <WSImageInfo *> *imageArr = @[imageInfo];
		//构建富文本处理类
    WSCoreTextManager * manager = [[WSCoreTextManager alloc] initWithAttributeString:[[NSMutableAttributedString alloc] initWithString:@"傅立叶分析分为傅立叶级数和傅立叶变换。傅里叶级数的本质是将一个周期的信号分解成无限多分开的（离散的）正弦波。傅里叶变换，则是将一个时域非周期的连续信号" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17], NSForegroundColorAttributeName: [UIColor redColor]}] frame:CGRectMake(0, 0, self.view.bounds.size.width - 20 * 2,400) images:imageArr];
		//计算图片位置
    [manager measureImagePosition];
		//负责视图绘画View
    WSView * view = [[WSView alloc] initWithFrame:CGRectMake(10, 88, self.view.bounds.size.width - 20 * 2,400)];
    view.backgroundColor = [UIColor whiteColor];
    view.coreTextManager = manager;
```



## License

WSCoreText is released under the MIT license. See License for details.