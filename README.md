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

### Why Not Use Interface Builder?

The appropriate question is: Why would any **professional** use Interface Builder? IB may help to build very simple rough prototypes. It is really no option for professional apps.

So here is what you get using the Interface Builder:

* :no_entry_sign: The IB is slow. Opening and loading a storyboard usually has a significant delay.
* :no_entry_sign: The IB does not make it obvious where configurations deviate from defaults, i.e. where they have been manipulated by a developer.
* :no_entry_sign: Handleing complex interfaces through pointing, zooming, scrolling and selecting, intertwined with keyboard input is actually pretty fucking slow.
* :no_entry_sign: Algorithmic (dynamic) layouts are impossible. However, often the mere existence of a view is determined at runtime, or layouts depend on data.
* :no_entry_sign: What constraints are actually applied is less explicit, in particular in the context of the code.
* :no_entry_sign: IB files create a mess with collaboration and version control systems like git.
* :no_entry_sign: IB files mess up the architecture I: They entangle the logical definition of the interface (which constitutes something like a "view model") with highly system specific file formats.
* :no_entry_sign: IB files mess up the architecture II: They entangle the logical definition of screen flow (high level navigation) with highly system specific file formats.
* :no_entry_sign: Setting very specific constraints with multipliers etc. and also debugging layout issues are a nightmare with the IB.
* :no_entry_sign: Coding animations often requires to access or even replace constraints. Good luck doing that when using the IB!
* :no_entry_sign: There are more initializers to worry about as well as the general interoperation between code and IB files.
* :no_entry_sign: Communicating with views requires to create outlets, which is actually quite cumbersome.
* :no_entry_sign: Your app will be harder to port to other platforms, even within the Apple universe.
* :no_entry_sign: It is harder to build nested interfaces with container- and child view controllers.
* :no_entry_sign: It is harder to turn views into reusable custom views when they exist in IB files.
* :no_entry_sign: You'll encounter a bunch of issues when trying to package IB files into frameworks and Cocoapods.

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
item1.autoSetDimension(.height, toSize: 64, relation: .greaterThanOrEqual)
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
item1.constrainHeight(toMinimum: 64)
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
