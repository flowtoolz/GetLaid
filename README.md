# GetLaid

[![badge-pod]](http://cocoapods.org/pods/GetLaid) ![badge-pms] ![badge-languages] ![badge-platforms] ![badge-mit]

GetLaid is a lean framework for laying out complex user interfaces through elegant code.

* [Why Oh Why?](#why-oh-why)
* [Install](#install)
* [Add Subviews and Layout Guides](#add-subviews-and-layout-guides)
* [Constrain Positions](#constrain-positions)
* [Constrain Multiple Positions](#constrain-multiple-positions)
* [Constrain Dimensions](#constrain-dimensions)
* [Constrain Both Dimensions](#constrain-both-dimensions)

## Why Oh Why?

### Features

GetLaid has some advantages even over classic simple frameworks like [PureLayout](https://github.com/PureLayout/PureLayout):

* :white_check_mark: Readability
    - Functions are of the principle form "[constrained aspect] constrain to [constraining aspect]"
    - This semantic naming makes auto completion more valuable, as it quickly and meaningfully narrows down the available options.
    - All functions have the prefix `constrain` which expresses best what they really do: They constrain some attributes and return the resulting constraints.
    - PureLayout is much more convoluted with its 6 different function prefixes: `autoPin`, `autoAlign`, `autoMatch`, `autoCenter`, `autoSet` and `autoConstrain`.
* :white_check_mark: Brevity
    - Shorter lines of code with less function arguments (see comparison below)
* :white_check_mark: Applicable to Layout Guides
    - [UILayoutGuide](https://developer.apple.com/documentation/uikit/uilayoutguide)
    - [NSLayoutGuide](https://developer.apple.com/documentation/appkit/nslayoutguide)
* :white_check_mark: Easy Relative Layouting
    - Relative positioning: `item1.constrainToParentLeft(at: 0.5)`
    - Relative sizing: `item1.constrain(to: item2.width.at(0.3))`
    - Aspect ratio: `item.constrainAspectRatio(to: 16/9)`
* :white_check_mark: Easy Positioning of Items Next to Each Other
    - `item1.constrain(above: item2, gap: 10)`
    - `item1.constrain(after: item2)` (localized via leading / trailing)
* :white_check_mark: Modern Swift Under the Hood
    - No Objective-c
    - Extensive use of [Layout Anchors](https://developer.apple.com/documentation/uikit/nslayoutanchor)

### Why Not Interface Builder?

Well, that [would be insane](https://www.flowtoolz.com/2019/09/27/the-reasons-for-why-i-hate-xcode-interface-builder.html).

### Why AutoLayout Wrappers?

Programmatic AutoLayout without any such frameworks was never hard. It's all about creating objects of `NSLayoutConstraint`, which has only one [powerful initializer](https://developer.apple.com/documentation/uikit/nslayoutconstraint/1526954-init).

Since iOS 9.0 and macOS 10.11, we also have `NSLayoutAnchor`, which adds a native abstraction layer on top of `NSLayoutConstraint`, further reducing the need for any AutoLayout wrappers at all.

At this point, all an AutoLayout wrapper can do is to make code even more meaningful, readable and succinct at the point of use. GetLaid does exactly that.

### Why Not Other AutoLayout Wrappers?

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

GetLaid trims AutoLayout further down to the essence. The operator `>>` can be read as "constrain to":

~~~swift
box >> 50
box >> box.parent?.center
~~~

Here's a richer comparison against PureLayout:

#### Before (PureLayout)

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
item1.autoConstrainAttribute(.width, to: .height, of: item1, withMultiplier: 16 / 9)
item1.autoPinEdgesToSuperViewEdges(with: NSEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
~~~

#### After (GetLaid)

~~~swift
item1 >> item1.parent
item1 >> item1.parent?.top
item1.width >> 42
item1 >> item2.left
item1 >> item2.centerX
item1 >> (82, 42)
item1.constrain(above: item2, gap: 20)
item1.height >> .min(64)
item1 >> item1.parent?.allButTop
item1.constrainLeftToParent(at: 0.5)
item1.constrainAspectRatio(to: 16 / 9)
item1.constrainToParent(topInset: 10)
~~~

So, which is prettier, mh?

If you can spare fancyness but appreciate readability, GetLaid might be for you.

## Install

With the [**Swift Package Manager**](https://github.com/apple/swift-package-manager/tree/master/Documentation#swift-package-manager), you can just add the GetLaid package [via Xcode](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) (11+).

Or you manually adjust the [Package.swift](https://github.com/apple/swift-package-manager/blob/master/Documentation/Usage.md#create-a-package) file of your project:

~~~swift
// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "MyApp",
    dependencies: [
        .package(url: "https://github.com/flowtoolz/GetLaid.git",
                 .upToNextMajor(from: "3.0.0"))
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
  pod "GetLaid", "~> 3.0"
end
```

Then run `$ pod install`.

Finally, in your **Swift** files:

```swift
import GetLaid
```

## Add Subviews and Layout Guides

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

## Constrain Positions

You generally call `constrain` on exactly the thing you want to constrain:

```swift
item1.left.constrain(to: item2.centerX)
```

All layout attributes can be used in that way, while baselines are not available on layout guides.

If source and target refer to the same position/anchor, you may omit one of them. These are equivalent:

```swift
item1.left.constrain(to: item2.left)
item1.left.constrain(to: item2)
item1.constrain(to: item2.left)
```

You may modify the constrain target and also chain these modifications:

```swift
item1.constrain(to: item2.left.offset(8))
item1.constrain(to: item2.left.min)              // >= item2.left
item1.constrain(to: item2.left.max)              // <= item2.left
item1.constrain(to: item2.left.at(0.5))          // at 0.5 of item2.left
item1.constrain(to: item2.left.min.offset(8))
```

## Constrain Multiple Positions

You may constrain multiple positions at once:

```swift
item1.constrain(to: item2.allButTop(leadingOffset: 5,   // leading, bottom, trailing
                                    bottomOffset: -5))
item1.constrain(to: item2.center)                       // centerX, centerY
item1.constrain(to: item2.all)                          // all edges
item1.constrain(to: item2)                              // shorthand for .all
```

Available position target combinations are:

* `all`
* `allButTop`
* `allButLeading`
* `allButLeft`
* `allButBottom`
* `allButTrailing`
* `allButRight`
* `center`

All of them take offsets as arguments for exactly the constrained positions, in counter-clockwise order.

## Constrain Dimensions

You constrain width and height just like positions:

```swift
item1.width.constrain(to: item2.height)
```

As with positions, you can omit anchors, modify the target, and chain modifications:

```swift
item1.constrain(to: item2.height.at(0.6).min)  // >= 60% of item2.height
```

You can constrain a dimension to a constant size. These are equivalent:

```swift
item.width.constrain(to: .size(100))
item.width.constrain(to: 100)
```

Omit the dimension to constrain both dimensions to the same constant. These are also equivalent:

```swift
item.constrain(to: .size(100))  // square with edge length 100
item.constrain(to: 100)         // same
```

Modify the constant size target like any other target, for one or both dimensions:

```swift
item.width.constrain(to: .size(100).max)  // width <= 100
item.constrain(to: .size(100).max)        // width, height <= 100
```

There's a shorter notation for minimum and maximum constants. These are equivalent:

```swift
item.constrain(to: .size(100).max)  // width, height <= 100
item.constrain(to: .max(100))       // same
```

## Constrain Both Dimensions

The `size` target combines width and height. It works fully equivalent to those single dimensions:

```swift
item1.constrain(to: item2.size.min)  // at least as big as item2
```

A size target can also represent a constant size. These are equivalent:

```swift
item.constrain(to: .size(100, 50))  // size target with constants
item.constrain(to: 100, 50)         // same
```

And there's also a shorthand notation for minimum and maximum size. These are equivalent:

```swift
item.constrain(to: .size(100, 50).min)  // at least 100 by 50
item.constrain(to: .min(100, 50))       // same
```

Finally, there's a shorthand for constraining aspect ratio. These are equivalent:

```swift
videoView.width.constrain(to: videoView.height.at(16 / 9))
videoView.constrainAspectRatio(to: 16 / 9)
```

## TO DOcument

* separate core API that uses `constrain(to:` functions from convenience API
* operator >>
* system spacing
  * find out whether there's still a difference between sibling spacing and parent spacing
* safe areas, parent
* constrain to parent (convenience funcs)
* constrain neighbours
* shorten and update motivational introduction

[badge-pod]: https://img.shields.io/cocoapods/v/GetLaid.svg?label=version&style=flat-square

[badge-pms]: https://img.shields.io/badge/supports-SPM%20%7C%20CocoaPods-green.svg?style=flat-square

[badge-languages]: https://img.shields.io/badge/language-Swift-orange.svg?style=flat-square

[badge-platforms]: https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20tvOS-lightgrey.svg?style=flat-square

[badge-mit]: https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat-square

