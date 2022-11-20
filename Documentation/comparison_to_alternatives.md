# Comparing GetLaid Against its Alternatives

I invite you to extend this comparison. First, the example code itself could be extended and, second, it would be interesting how it looks written with the native API, SnapKit and Anchorage ...

## Before (PureLayout)

```swift
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
```

## After (GetLaid)

```swift
item1 >> item1.parent
item1 >> item1.parent?.top
item1.width >> 42
item1 >> item2.left
item1 >> item2.centerX
item1 >> (82, 42)
item1.bottom >> item2.top.offset(-20)
item1.height >> .min(64)
item1 >> item1.parent?.allButTop
item1.left >> item1.parent?.right.at(0.5)
item1.width >> item1.height.at(16 / 9)
item1 >> item1.parent?.all(topInset: 10)
```
