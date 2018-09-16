# GetLaid

[![Pod Version](https://img.shields.io/cocoapods/v/GetLaid.svg?longCache=true&style=flat-square)](http://cocoapods.org/pods/GetLaid)

## Why

GetLaid has some advantages over [PureLayout](https://github.com/PureLayout/PureLayout):

* :white_check_mark: Readability
    - Functions are of the principle form "constrain [constrained aspect] to [constraining aspect]"
    - This semantic naming makes auto completion more valuable: If you want to constrain the left side, write `constrainLeft`. Auto completion will show all possible ways to do it.
    - All functions have the prefix `constrain` which expresses best what they really do: They constrain some attributes and return the resulting constraints.
    - PureLayout is much more convoluted with its 6 different function prefixes: `autoPin`, `autoAlign`, `autoMatch`, `autoCenter`, `autoSet` and `autoConstrain`.
* :white_check_mark: Brevity
    - Fewer lines of code
    - Shorter lines of code
* :white_check_mark: Applicable to Layout Guides
    - [UILayoutGuide](https://developer.apple.com/documentation/uikit/uilayoutguide)
    - [NSLayoutGuide](https://developer.apple.com/documentation/appkit/nslayoutguide)
* :white_check_mark: Easy Relative Layouting
    - Relative positioning: `item1.constrainLeft(to: 0.2, of: item2)`
    - Relative sizing: `item1.constrainWidth(to: 0.3, of: item2)`
* :white_check_mark: Easy Positioning of Items Next to Each Other
    - `item1.constrain(above: item2, gap: 10)`
    - `item1.constrain(toTheLeftOf: item2)`
* :white_check_mark: Modern Swift Under the Hood
    - No Objective-c
    - Extensive use of [Layout Anchors](https://developer.apple.com/documentation/uikit/nslayoutanchor)

## How

You know [Cocoapods](https://cocoapods.org), right? Then add this to your podfile: `pod 'GetLaid'`

Now, let's see how GetLaid can revamp code written with [PureLayout](https://github.com/PureLayout/PureLayout) ...

### Before (PureLayout)

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

### After (GetLaid)

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

So, which is prettier, mh?

### Adding Subviews

Remember to set `translatesAutoresizingMaskIntoConstraints = false` on the views you incorporate in auto layout.

The generic function `addForAutoLayout(...)` adds a subview and prepares it for auto layout. It returns the subview as its exact type. I use this function to initialize subview properties:

~~~swift
class List: NSView
{
    override init(frame frameRect: NSRect)
    {
        super.init(frame: frameRect)
        
        header.constrainToParentExcludingBottom()
    }
    
    private lazy var header = addForAutoLayout(Header())
}
~~~

### Adding Layout Guides

There are two helper functions to add new layout guides to views:

~~~swift
let guide = view.addLayoutGuide()
let tenGuides = view.addLayoutGuides(10)
~~~
