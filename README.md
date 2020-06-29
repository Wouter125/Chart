# Line Chart

Line Chart is a simple and light-weight line chart component for iOS. It's fully written in Swift, based upon UIView, and highly customizable. It currently supports the following features;

- [x] Bezier Curves
- [x] Linear Curves
- [x] Touch Tracking for linear and bezier curves
- [x] Fully customizable axes
- [x] Graph points
- [x] Animation control when switching between data sets

## How to install

Currently Line Chart is only available through the [Swift Package Manager](https://swift.org/package-manager/) or manual install. 

1. Installation through Swift Package Manager can be done by going to `File > Swift Packages > Add Package Dependency`. Then enter the following line;
```https://github.com/Wouter125/Chart```

2. Manual installation can be done by cloning this repository and dragging all assets into your Xcode Project.

## How to use

To give you an idea of how to configure the line chart here are two examples. For more details see [parameters](#parameters).

**Linear line with graph points and axes**
```
private let graph: LineChart = {
    let graph = LineChart()
    graph.lineType = .linear
    
    graph.isAnimated = false

    graph.axesConfiguration.x.isHidden = false
    graph.axesConfiguration.y.isHidden = false

    graph.inset = UIEdgeInsets(top: 0, left: 48, bottom: 0, right: 24)
    graph.showPoints = true

    return graph
}()
```

**Bezier line with custom animation curves**
```
private let graph: LineChart = {
    let graph = LineChart()
    graph.lineType = .bezier
    
    graph.isAnimated = true
    graph.animationCurve = .easeInEaseOut
    graph.animationDuration = 1.5
    
    return graph
}()
```

## Parameters

### Graph

| Parameter              | Type        | Default                                            | Description                                                                                 |
|------------------------|-------------|----------------------------------------------------|---------------------------------------------------------------------------------------------|
| data                   | [CGPoint]   | nil                                                | The data that you want to render on the graph canvas                                        |
| inset                  | UIEdgeInset | UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) | Apply additional insets on your graph canvas                                                |
| isTouchTrackingEnabled | Bool        | true                                               | Enable or disable the ability to pan on the graph to retrieve the data on the touched point |


### Axes
Axes uses a `struct` called `AxesConfiguration` which consists out of the following options;

| Parameter  | Type    | Default                           | Description                                                                               |
|------------|---------|-----------------------------------|-------------------------------------------------------------------------------------------|
| x          | xAxis   | xAxis(isHidden: true, count: nil) | Defines whether the x axis should be shown, and if show how many of them there should be. |
| y          | yAxis   | yAxis(isHidden: true, count: nil) | Defines whether the x axis should be shown, and if show how many of them there should be. |
| color      | CGColor | UIColor.systemGray5.cgColor       | The color of the axes                                                                     |
| width      | CGFloat | 1.0                               | The width of the axes                                                                     |
| labelColor | CGColor | UIColor.systemGray.cgColor        | The color of the labels of the axes                                                       |


### Line

| Parameter        | Type      | Default                             | Description                                                                |
|------------------|-----------|-------------------------------------|----------------------------------------------------------------------------|
| lineType         | LineType  | .linear                             | Whether you want your data to render as a `.linear` line or `.bezier` line |
| lineColor        | CGColor   | UIColor.systemGreen.cgColor         | The color of the line                                                      |
| lineWidth        | CGFloat   | 2.0                                 | The width of the line                                                      |
| showBackground   | Bool      | true                                | Show a gradient or solid color below the line                              |
| backgroundColors | [CGColor] | [systemGreen(0.24), systemGreen(0)] | The colors for the gradient or solid color below the line                  |

### Points

| Parameter         | Type    | Default                     | Description                                                     |
|-------------------|---------|-----------------------------|-----------------------------------------------------------------|
| showPoints        | Bool    | false                       | Whether you want to show points at the data points you provided |
| pointsFillColor   | CGColor | UIColor.white.cgColor       | The fill color of the point                                     |
| pointsBorderColor | CGColor | UIColor.systemGreen.cgColor | The border color of the point                                   |
| pointsBorderWidth | CGFloat | 2.0                         | The border width of the point                                   |

### Animation

| Parameter         | Type                  | Default        | Description                                                                |
|-------------------|-----------------------|----------------|----------------------------------------------------------------------------|
| isAnimated        | Bool                  | true           | Whether you want to animate the layer when switching data sets             |
| animationCurve    | CAMediaTimingFunction | easeInOutCubic | The animation curve you want to apply. A full overview can be found here;  |
| animationDuration | Double                | 0.8            | The duration of the animation                                              |
