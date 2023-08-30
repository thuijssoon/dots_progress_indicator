# Dots Progress Indicator

A configurable indeterminate progress indicator showing bouncing dots.

[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)

## Usage

### 1. Add the dependency

First, add `dots_progress_indicator` as a dependency in your pubspec.yaml file.

```yaml
dependencies:
  dots_progress_indicator:
  git:
    url: https://github.com/thuijssoon/dots_progress_indicator.git

```

Don't forget to `flutter pub get`.

### 2. Use `DotsProgressIndicator` in your app

```dart
DotsProgressIndicator(
  backgroundColor: Colors.black12,
  color: Colors.blue,
  curve: Curves.bounceIn,
  dotDiameter: 20,
  duration: Duration(milliseconds: 1000),
  numberOfDots: 5,
  spaceBetween: 4,
),

```
