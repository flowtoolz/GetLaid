# GetLaid

[![badge-pod]](http://cocoapods.org/pods/GetLaid) ![badge-pms] ![badge-languages] ![badge-platforms] ![badge-mit]

GetLaid is a lean framework for defining complex view layouts through elegant code.

## Features

GetLaid has some advantages even over classic simple frameworks like [PureLayout](https://github.com/PureLayout/PureLayout):

* :white_check_mark: Readability
    - Functions are of the principle form "constrain [constrained aspect] to [constraining aspect]"
    - This semantic naming makes auto completion more valuable: If you want to constrain the left side, write `constrainLeft`. Auto completion will show all possible ways to do it.
    - All functions have the prefix `constrain` which expresses best what they really do: They constrain some attributes and return the resulting constraints.
    - PureLayout is much more convoluted with its 6 different function prefixes: `autoPin`, `autoAlign`, `autoMatch`, `autoCenter`, `autoSet` and `autoConstrain`.
* :white_check_mark: Brevity
    - Shorter lines of code with less function arguments (see comparison below)
* :white_check_mark: Applicable to Layout Guides
    - [UILayoutGuide](https://developer.apple.com/documentation/uikit/uilayoutguide)
    - [NSLayoutGuide](https://developer.apple.com/documentation/appkit/nslayoutguide)
* :white_check_mark: Easy Relative Layouting
    - Relative positioning: `item1.constrainLeftToParent(at: 0.5)`
    - Relative sizing: `item1.constrainWidth(to: 0.3, of: item2)`
    - Aspect ratio: `item.constrainAspectRatio(to: 16/9)`
* :white_check_mark: Easy Positioning of Items Next to Each Other
    - `item1.constrain(above: item2, gap: 10)`
    - `item1.constrain(toTheLeftOf: item2)`
* :white_check_mark: Modern Swift Under the Hood
    - No Objective-c
    - Extensive use of [Layout Anchors](https://developer.apple.com/documentation/uikit/nslayoutanchor)

## Why Not Interface Builder?

Well, that [would be insane](https://www.flowtoolz.com/2019/09/27/the-reasons-for-why-i-hate-xcode-interface-builder.html).

## Why AutoLayout Wrappers?

Programmatic AutoLayout without any such frameworks was never hard. It's all about creating objects of `NSLayoutConstraint`, which has only one [powerful initializer](https://developer.apple.com/documentation/uikit/nslayoutconstraint/1526954-init).

Since iOS 9.0 and macOS 10.11, we also have `NSLayoutAnchor`, which adds a native abstraction layer on top of `NSLayoutConstraint`, further reducing the need for any AutoLayout wrappers at all.

At this point, all an AutoLayout wrapper can do is to make code even more meaningful, readable and succinct at the point of use. GetLaid does exactly that.

## Why Not Other AutoLayout Wrappers?

Modern AutoLayout wrappers like [SnapKit](https://github.com/SnapKit/SnapKit) are almost too clever for the simple task at hand. A SnapKit example:

~~~swift
box.snp.makeConstraints { (make) -> Void in
    make.width.height.equalTo(50)
    make.center.equalTo(self.view)
}
~~~

Classic AutoLayout wrappers like [PureLayout](https://github.com/PureLayout/PureLayout), have easier syntax but are still wordy:

~~~swift
box.autoSetDimensions(to: CGSize(width: 50, height: 50))
box.autoCenterInSuperView()
~~~

GetLaid trims AutoLayout code even further down to the essence. Compare for yourself:

### Before (PureLayout)

~~~swift
item1.autoPinEdgesToSuperviewEdges()
item1.autoPinEdge(toSuperviewEdge: .top)
item1.autoSetDimension(.width, toSize: 42)
item1.autoPinEdge(.left, to: .left, of: item2)
item1.autoAlignAxis(.vertical, toSameAxisOf: item2)
item1.autoSetDimensions(to: CGSize(width: 82, height: 42))
item1.autoPinEdge(.bottom, to: .top, of: item2, withOffset: -20)
item1.autoSetDimension(.height, toSize: 64, relation: .greaterThanOrEqual)
item1.autoPinEdgesToSuperviewEdges(with: NSEdgeInsetsZero, excludingEdge: .top)
item1.autoConstrainAttribute(.left, to: .right, of: parent, withMultiplier: 0.5)
item1.autoConstrainAttribute(.width, to: .height, of: item1, withMultiplier: 16/9)
item1.autoPinEdgesToSuperViewEdges(with: NSEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
~~~

### After (GetLaid)

~~~swift
item1.constrainToParent()
item1.constrainTopToParent()
item1.constrainWidth(to: 42)
item1.constrainLeft(to: item2)
item1.constrainCenterX(to: item2)
item1.constrainSize(to: 82, 42)
item1.constrain(above: item2, gap: 20)
item1.constrainHeight(toMinimum: 64)
item1.constrainToParentExcludingTop()
item1.constrainLeftToParent(at: 0.5)
item1.constrainAspectRatio(to: 16/9)
item1.constrainToParent(insetTop: 10)
~~~

So, which is prettier, mh?

If you can spare fancyness but appreciate readability, GetLaid might be for you.

## How to GetLaid

### Install

With the [**Swift Package Manager**](https://github.com/apple/swift-package-manager/tree/master/Documentation#swift-package-manager), you can just add the GetLaid package [via Xcode](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) (11+).

Or you manually adjust the [Package.swift](https://github.com/apple/swift-package-manager/blob/master/Documentation/Usage.md#create-a-package) file of your project:

~~~swift
// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "MyApp",
    dependencies: [
        .package(url: "https://github.com/flowtoolz/GetLaid.git",
                 .upToNextMajor(from: "2.0.0"))
    ],
    targets: [
        .target(name: "MyAppTarget",
                dependencies: ["GetLaid"])
    ]
)
~~~

Then run `$ swift build` or `$ swift run`.

With [**Cocoapods**](https://cocoapods.org), adjust your [Podfile](https://guides.cocoapods.org/syntax/podfile.html):

```ruby
target "MyAppTarget" do
  pod "GetLaid", "~> 2.0"
end
```

Then run `$ pod install`.

Finally, in your **Swift** files:

```swift
import GetLaid
```

### Add Subviews and Layout Guides

The generic function `addForAutoLayout` adds a subview and prepares it for AutoLayout. It returns the subview it takes as its exact type. Use this function to add subviews:

~~~swift
class List: NSView {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        header.constrainToParentExcludingBottom()
    }
    private lazy var header = addForAutoLayout(Header()) // of type Header
}
~~~

If you don't use `addForAutoLayout`, remember to set `translatesAutoresizingMaskIntoConstraints = false` on the views you incorporate in AutoLayout.

There's also a helper function for adding a new layout guide to a view:

~~~swift
let guide = view.addLayoutGuide()
~~~

### Contrain Subviews and Layout Guides

You can constrain layout items of type `UIView`, `NSView`, `UILayoutGuide` and `NSLayoutGuide`. All constraining functions have the prefix `constrain` and are well discoverable via auto completion. Functions that constrain items to their parents are only available on the view classes. 

[badge-pod]: https://img.shields.io/cocoapods/v/GetLaid.svg?label=version&style=flat-square

[badge-pms]: https://img.shields.io/badge/supports-SPM%20%7C%20CocoaPods-green.svg?style=flat-square

[badge-languages]: https://img.shields.io/badge/language-Swift-orange.svg?style=flat-square

[badge-platforms]: https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20tvOS-lightgrey.svg?style=flat-square

[badge-mit]: https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat-square

