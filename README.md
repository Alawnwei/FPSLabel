# FPSLabel
[FPSLabel](https://github.com/leiguang/FPSLabel)简单的 FPS 指示器，参考自 [ibireme的YYFPSLabel](https://github.com/ibireme/YYText/blob/master/Demo/YYTextDemo/YYFPSLabel.m)，

> 下段内容引用自：[ibireme的iOS 保持界面流畅的技巧](https://blog.ibireme.com/2015/11/12/smooth_user_interfaces_for_ios/)，受益匪浅。
> ### 如何评测界面的流畅度
>       最后还是要提一下，“过早的优化是万恶之源”，在需求未定，性能问题不明显时，没必要尝试做优化，而要尽量正确的实现功能。做性能优化时，也最好是走修改代码 -> Profile -> 修改代码这样一个流程，优先解决最值得优化的地方。</br>
>       如果你需要一个明确的 FPS 指示器，可以尝试一下 [KMCGeigerCounter](https://github.com/kconner/KMCGeigerCounter)。对于 CPU 的卡顿，它可以通过内置的 CADisplayLink 检测出来；对于 GPU 带来的卡顿，它用了一个 1×1 的 SKView 来进行监视。这个项目有两个小问题：SKView 虽然能监视到 GPU 的卡顿，但引入 SKView 本身就会对 CPU/GPU 带来额外的一点的资源消耗；这个项目在 iOS 9 下有一些兼容问题，需要稍作调整。</br>
>       我自己也写了个简单的 FPS 指示器：FPSLabel 只有几十行代码，仅用到了 CADisplayLink 来监视 CPU 的卡顿问题。虽然不如上面这个工具完善，但日常使用没有太大问题。</br>
>       最后，用 Instuments 的 GPU Driver 预设，能够实时查看到 CPU 和 GPU 的资源消耗。在这个预设内，你能查看到几乎所有与显示有关的数据，比如 Texture 数量、CA 提交的频率、GPU 消耗等，在定位界面卡顿的问题时，这是最好的工具。

### 避免Timer、CADisplayLink之类的循环引用：
- TargetProxy 参考[Kingfisher中的写法](https://github.com/onevcat/Kingfisher/blob/master/Sources/AnimatedImageView.swift#L63-L74)
- YYWeakProxy 参考 [ibireme的YYWeakProxy](https://github.com/ibireme/YYText/blob/master/Demo/YYTextDemo/YYWeakProxy.m)


