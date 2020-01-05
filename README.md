# GetLaid

[![badge-pod]](http://cocoapods.org/pods/GetLaid) ![badge-pms] ![badge-languages] ![badge-platforms] ![badge-mit]

GetLaid is a lean framework for laying out complex UIs through short readable code.

* [Why Oh Why?](#why-oh-why)
* [Install](#install)
* [Add Subviews and Layout Guides](#add-subviews-and-layout-guides)
* [Constrain Positions](#constrain-positions)
* [Constrain Multiple Positions](#constrain-multiple-positions)
* [Constrain Dimensions](#constrain-dimensions)
* [Constrain Both Dimensions](#constrain-both-dimensions)
* [Constrain to the Parent](#constrain-to-the-parent)
* [Constrain to the Safe Area on iOS](#constrain-to-the-safe-area-on-ios)
* [System Spacing on iOS and tvOS](#system-spacing-on-ios-and-tvos)

## Why Oh Why?

### Features

* :white_check_mark: Readability
    - The syntax is close to natural language instead of technically fancy.
    - All constraining has the form `source.constrain(to: target)`.
    - The operator `>>` can add further clarity: `source >> target`
* :white_check_mark: Brevity
    - Code lines are super short and involve few function arguments.
    - A single code line can do a lot, via combined targets like `allButTop` and `size`.
* :white_check_mark: Integrated Simplicity
    - Simple consistent systematic design: Understand 1 thing to do everything.
    - Seemless coverage of parent views, safe areas and system spacings.
* :white_check_mark: Easy Advanced Layouting
    - Modify any constrain target with `offset(CGFLoat)`, `min`, `max` and `at(_ factor: CGFloat)`.
    - Chain target modifications together: `item1 >> item2.size.at(0.5).min`.
* :white_check_mark: Compatability
    - Works on iOS, tvOS and macOS
    - Works on [UILayoutGuide](https://developer.apple.com/documentation/uikit/uilayoutguide) and [NSLayoutGuide](https://developer.apple.com/documentation/appkit/nslayoutguide) just as well as on views

### Why Not Interface Builder?

Well, that [would be insane](https://www.flowtoolz.com/2019/09/27/the-reasons-for-why-i-hate-xcode-interface-builder.html).

### Why AutoLayout Wrappers?

Programmatic AutoLayout without any such frameworks was never hard. It's all about creating objects of `NSLayoutConstraint`, which has only one [powerful initializer](https://developer.apple.com/documentation/uikit/nslayoutconstraint/1526954-init).

Since iOS/tvOS 9.0 and macOS 10.11, we also have [`NSLayoutAnchor`](https://developer.apple.com/documentation/uikit/nslayoutanchor), which adds a native abstraction layer on top of `NSLayoutConstraint`, further reducing the need for any AutoLayout wrappers at all.

At this point, all an AutoLayout wrapper can do is to make code even more meaningful, readable and succinct at the point of use. GetLaid does exactly that.

### Why Not Other AutoLayout Wrappers?

Modern AutoLayout wrappers like [SnapKit](https://github.com/SnapKit/SnapKit) are almost too clever for the simple task at hand. The first example from the SnapKit README:

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

GetLaid trims AutoLayout further down to the essence. Just read the operator `>>` as "constrain to":

~~~swift
box >> 50
box >> box.parent?.center
~~~

So, which is prettier, mh? If you can spare fancyness but appreciate readability, GetLaid might be for you.

Here is also a [richer comparison](Documentation/comparison_to_alternatives.md) of how layout code looks with GetLaid and its alternatives.

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
class List: UIView {
    // ... other code, including call to addSubviews() ...

    func addSubviews() {
        addForAutoLayout(header) >> allButBottom  // add header to the top
    }
    private let header = Header()
}
~~~

If you don't use `addForAutoLayout`, remember to set `translatesAutoresizingMaskIntoConstraints = false` on the views you incorporate in AutoLayout.

There's also a helper function for adding a new layout guide to a view:

~~~swift
let guide = view.addLayoutGuide()
~~~

## Constrain Positions

You would always call `constrain(to:)` on exactly the thing you want to constrain. And you can always replace that function with the shorthand operator `>>`, which we'll do in the examples. These lines are equivalent :

```swift
view1.top.constrain(to: view2.lastBaseline)
view1.top >> view2.lastBaseline
```

All layout attributes can be used in that way, while baselines are not available on layout guides.

If left side (source) and right side (target) refer to the same layout attribute, you may omit one of them. These are equivalent:

```swift
item1.left >> item2.left
item1.left >> item2
item1 >> item2.left
```

You may modify the constrain target (right side attribute) and also chain these modifications:

```swift
item1 >> item2.left.offset(8)
item1 >> item2.left.min            // >= item2.left
item1 >> item2.left.max            // <= item2.left
item1 >> item2.left.at(0.5)        // at 0.5 of item2.left
item1 >> item2.left.min.offset(8)
```

## Constrain Multiple Positions

You may constrain multiple positions at once:

```swift
item1 >> item2.allButTop(leadingOffset: 5,  // leading, bottom, trailing
                         bottomOffset: -5)
item1 >> item2.center                       // centerX, centerY
item1 >> item2.all                          // all edges
item1 >> item2                              // shorthand for .all
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
item1.width >> item2.height
```

As with positions, you can omit redundant attributes, modify the target, and chain modifications:

```swift
item1 >> item2.height.at(0.6).min  // >= 60% of item2.height
```

You can constrain a dimension to a constant size. These are equivalent:

```swift
item.width >> .size(100)
item.width >> 100
```

Omit the dimension to constrain both dimensions to the same constant. These are equivalent:

```swift
item >> .size(100)  // square with edge length 100
item >> 100         // same
```

You can modify the constant size target like any other target, for one or both dimensions. Unfortunately, for this to work with the `>>` operator, Swift needs the explicit target type as context. There are two workarounds, a more native one and a prettier one:

```swift
item >> .size(100).max                 // WON'T COMPILE❗
item >> DimensionTarget.size(100).max  // spells out the target type (ugly)
item >> layoutSize(100).max            // global func makes the target (better)
```

> **Side Note:** The global function `layoutSize` could not be named just `size` because that would technically produce name collisions and also would not properly establish the AutoLayout context in terms of meaning.

Fortunately, you'll virtually never need the above workaround, thanks to shorthand notations for minimum and maximum constants. These are equivalent:

```swift
item >> layoutSize(100).max  // width, height <= 100
item >> .max(100)            // same
```

## Constrain Both Dimensions

The `size` target combines width and height. It works fully equivalent to those single dimensions:

```swift
item1 >> item2.size.min  // at least as big as item2
```

A size target can also represent a constant size. These are equivalent:

```swift
item >> .size(100, 50)  // size target with constants
item >> (100, 50)       // same
```

And there are also shorthand notations for minimum and maximum size. These are equivalent:

```swift
item >> layoutSize(100, 50).min  // at least 100 by 50
item >> .min(100, 50)            // same
```

## Constrain to the Parent

Normally, in well structured code, views add and layout their own subviews. In those contexts, the parent (superview) of the constrained subviews is `self`, which makes it easy to constrain those subviews to any of their parent's attributes:

```swift
class MySuperview: UIView {
    // ... other code, including call to addSubviews() ...
  
    func addSubviews() {
        let subview = addForAutoLayout(UIView())
        subview >> allButBottom                   // constrain 3 edges to parent (self)
        subview >> height.at(0.2)                 // constrain height to 20% of parent (self)
    }
}
```

Sometimes, not all superviews are implemented as their own custom view class. In other words, some custom view- or controller classes add and layout whole subview hierarchies. In those contexts, the enclosing custom view or view controller controls the parent-child relation of its subviews and can directly constrain subviews to their parents:

```swift
class MySuperview: UIView {
    // ... other code, including call to addSubviews() ...

    func addSubviews() {
        let subview = addForAutoLayout(UIView())
        let subsubview = subview.addForAutoLayout(UIView())
        subsubview >> subview.allButBottom        // constrain 3 edges to parent
        subsubview >> subview.height.at(0.2)      // constrain height to 20% of parent
    }
}
```

If you still want to explicitly constrain a layout item to its parent, you can use the `parent` property. On a view, `parent` is its `superView`. On a layout guide, `parent` is its `owningView`. Of course, `parent` is optional, but all layout item based constrain targets can just be optional:

```swift
item >> item.parent?.top.offset(10)          // constrain top to parent, inset 10
item >> item.parent?.allButBottom            // constrain 3 edges to parent
item >> item.parent?.size.at(0.3)            // constrain width and height to 30% of parent
item >> item.parent?.all(leadingOffset: 10)  // constrain all edges to parent, leading inset 10
item >> item.parent                          // constrain all edges to parent
```

## Constrain to the Safe Area on iOS

On iOS 11 and above, you can access the safe area of a view via the `safeArea` property and the parent's safe area via the optional `parentSafeArea` property.

Normally, in well structured code where views add and layout their own subviews, you would simply call `safeArea` on `self`:

```swift
class MyView: UIView {
    // ... other code, including call to addSubviews() ...

    func addSubviews() {
        addForAutoLayout(MyContentView()) >> safeArea  // constrain content to safe area
    }
}
```

If you find youself constraining many subviews to the safe area, there should probably be a content view containing them.

## System Spacing on iOS and tvOS

With Apple's `NSLayoutAnchor`, you can make use of a mysterious "system spacing". Apple does not disclose how that is calculated and does not offer any concrete values you could access. Using system spacings through the `NSLayoutAnchor` API is a bit awkward, limited in how it is applied and limited in what it can be applied to.

GetLaid exposes the system spacing as two global `CGFLoat` constants. It calls the actual Apple API to calculate the constants the first time you acces them:

1. `systemSiblingSpacing` is the gap the user's system wants between sibling views.
2. `systemParentSpacing` is the inset the user's system wants from a view's edge to a contained subview.

It seems that on iOS both these system spacings are always the same. At least, I checked that from iPhone SE up to the newest 13" iPad Pro, and from iOS 12.0 to iOS 13.3. So GetLaid also offers a universal `systemSpacing` which just returns `systemSiblingSpacing`.

The system spacing as a constant offers loads of flexibility:

```swift
item2.left >> item1.right.offset(systemSpacing)  // gap between views
item >> item.parent?.top.offset(systemSpacing)   // inset to parent
spacer.width >> .min(systemSpacing)              // minimum spacer width
```

Remember that these constants are not hardcoded but dynamically calculated on the actual user device, so they are absolutely true to what Apple intents for sibling gaps and parent insets, on any system and on any iOS/tvOS version. But also note that these two values do not capture the system spacing magic that `NSLayoutAnchor` offers in conjunction with baselines and font sizes and possibly in other contexts.

[badge-pod]: https://img.shields.io/cocoapods/v/GetLaid.svg?label=version&style=flat-square

[badge-pms]: https://img.shields.io/badge/supports-SPM%20%7C%20CocoaPods-green.svg?style=flat-square

[badge-languages]: https://img.shields.io/badge/language-Swift-orange.svg?style=flat-square

[badge-platforms]: https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20tvOS-lightgrey.svg?style=flat-square

[badge-mit]: https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat-square

