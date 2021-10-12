# FastBlurView

[![CI Status](https://img.shields.io/travis/cleexiang/FastBlurView.svg?style=flat)](https://travis-ci.org/cleexiang/FastBlurView)
[![Version](https://img.shields.io/cocoapods/v/FastBlurView.svg?style=flat)](https://cocoapods.org/pods/FastBlurView)
[![License](https://img.shields.io/cocoapods/l/FastBlurView.svg?style=flat)](https://cocoapods.org/pods/FastBlurView)
[![Platform](https://img.shields.io/cocoapods/p/FastBlurView.svg?style=flat)](https://cocoapods.org/pods/FastBlurView)

## Screenshot
<img src="./Screenshots/fastblur.gif" alt="" width="292" height="633"/>

## Easy to use
* If you want to continuously refresh the blur effect with the content below the view, set continuous to true.
```
    let blurView = FastBlurView(frame: CGRect(x: 0, y: 100, width: 300, height: 200), device: MTLCreateSystemDefaultDevice())
    blurView.continuous = true
    view.addSubview(blurView)
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

FastBlurView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FastBlurView'
```

## Author

cleexiang, cleexiang@126.com

## License

FastBlurView is available under the MIT license. See the LICENSE file for more info.
