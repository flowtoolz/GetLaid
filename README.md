# GetLaid

[![Pod Version](https://img.shields.io/cocoapods/v/GetLaid.svg?longCache=true&style=flat-square)](http://cocoapods.org/pods/GetLaid)

## Why

GetLaid has some advantages over [PureLayout](https://github.com/PureLayout/PureLayout):

* :white_check_mark: More Readable
    - All functions are of the form `constrain<CONSTRAINED ATTRIBUTE>to<CONSTRAINING ATTRIBUTE>`
    - The prefix `constrain` expresses best what the functions really do. They constrain some attribute and return the applied constraints.
    - Helpful auto completion: If you want to constrain the left side, write `constrainLeft`. Auto completion will show all possible ways to do it.
    - PureLayout is much more convoluted with its 6 different function prefixes: `autoPin`, `autoAlign`, `autoMatch`, `autoCenter`, `autoSet` and `autoConstrain`.
* :white_check_mark: More Succinct
    - Less Lines of Code
    - Shorter Lines of Code
* :white_check_mark: Applicable to Layout Guides
    - [UILayoutGuide](https://developer.apple.com/documentation/uikit/uilayoutguide)
    - [NSLayoutGuide](https://developer.apple.com/documentation/appkit/nslayoutguide)
* :white_check_mark: Easy Relative Layouting
    - Relative Positioning: `item1.constrainLeft(to: 0.2, of: item2)`
    - Relative Sizing: `item1.constrainWidth(to: 0.3, of: item2)`
* :white_check_mark: Easy Positioning of Items Next to Each Other
    - `item1.constrain(above: item2, gap: 10)`
    - `item1.constrain(toTheLeftOf: item2)`
* :white_check_mark: Modern Swift Under the Hood
    - No Objective-c
    - Extensive Use of [Layout Anchors](https://developer.apple.com/documentation/uikit/nslayoutanchor)

## How

Let's compare GetLaid to [PureLayout](https://github.com/PureLayout/PureLayout). Notice how GetLaid is readable and succinct.

Some examples using PureLayout:

~~~swift
item1.autoPinEdgesToSuperviewEdges()
item1.autoPinEdge(toSuperviewEdge: .top)
item1.autoSetDimension(.width, toSize: 42)
item1.autoPinEdge(.left, to: .left, of: item2)
item1.autoAlignAxis(.vertical, toSameAxisOf: item2)
item1.autoSetDimensions(to: CGSize(width: 82, height: 42))
item1.autoPinEdge(.bottom, to: .top, of: item2, withOffset: -20)
item1.autoPinEdgesToSuperviewEdges(with: NSEdgeInsetsZero, excludingEdge: .top)
item1.autoConstrainAttribute(.left, to: .right, of: item2, withMultiplier: 0.2)
item1.autoPinEdgesToSuperViewEdges(with: NSEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
~~~

The same examples using GetLaid:

~~~swift
item1.constrainToParent()
item1.constrainTopToParent()
item1.constrainWidth(to: 42)
item1.constrainLeft(to: item2)
item1.constrainCenterX(to: item2)
item1.constrainSize(to: 82, 42)
item1.constrain(above: item2, gap: 20)
item1.constrainToParentExcludingTop()
item1.constrainLeft(to: 0.2, of: item2)
item1.constrainToParent(insetTop: 10)
~~~