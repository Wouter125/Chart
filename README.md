# LineChart

### Configuration

#### Graph

| Parameter              | Type        | Default                                            | Description                                                                                 |
|------------------------|-------------|----------------------------------------------------|---------------------------------------------------------------------------------------------|
| data                   | [CGPoint]   | nil                                                | The data that you want to render on the graph canvas                                        |
| inset                  | UIEdgeInset | UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) | Apply additional insets on your graph canvas                                                |
| isTouchTrackingEnabled | Bool        | true                                               | Enable or disable the ability to pan on the graph to retrieve the data on the touched point |


#### Axes


#### Line

| Parameter        | Type      | Default                             | Description                                                                |
|------------------|-----------|-------------------------------------|----------------------------------------------------------------------------|
| lineType         | LineType  | .linear                             | Whether you want your data to render as a `.linear` line or `.bezier` line |
| lineColor        | CGColor   | UIColor.systemGreen.cgColor         | The color of the line                                                      |
| lineWidth        | CGFloat   | 2.0                                 | The width of the line                                                      |
| showBackground   | Bool      | true                                | Show a gradient or solid color below the line                              |
| backgroundColors | [CGColor] | [systemGreen(0.24), systemGreen(0)] | The colors for the gradient or solid color below the line                  |

#### Points
| Parameter         | Type    | Default                     | Description                                                     |
|-------------------|---------|-----------------------------|-----------------------------------------------------------------|
| showPoints        | Bool    | false                       | Whether you want to show points at the data points you provided |
| pointsFillColor   | CGColor | UIColor.white.cgColor       | The fill color of the point                                     |
| pointsBorderColor | CGColor | UIColor.systemGreen.cgColor | The border color of the point                                   |
| pointsBorderWidth | CGFloat | 2.0                         | The border width of the point                                   |

#### Animation
| Parameter         | Type                  | Default        | Description                                                                |
|-------------------|-----------------------|----------------|----------------------------------------------------------------------------|
| isAnimated        | Bool                  | true           | Whether you want to animate the layer when switching data sets             |
| animationCurve    | CAMediaTimingFunction | easeInOutCubic | The animation curve you want to apply. A full overview can be found here;  |
| animationDuration | Double                | 0.8            | The duration of the animation                                              |
