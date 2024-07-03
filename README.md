# PullAppBar

📱 PullAppBar is a Flutter package that enhances app navigation by allowing users to change page content dynamically by pulling the app bar. It provides a smooth and interactive user experience with customizable titles and pages.

## Live Demo

Check out the live demo [here](https://hamidrzash.github.io/pull_appbar).

## Features
![PullAppBar](https://raw.githubusercontent.com/Hamidrzash/pull_appbar/main/assets/preview.gif)
- Change page content by pulling the app bar
- Smooth transitions and animations

## Installation

Add `pull_appbar` to your `pubspec.yaml` dependencies. And import it:

```dart
import 'package:pull_appbar/pull_appbar.dart';
```

## Usage

Simply create a `PullAppBar` widget, and pass the required params:

```dart
PullAppBar(
      titles: const [
        Text('Title1'),
        Text('Title2'),
        Text('Title3'),
        Text('Title4'),
      ],
      onPageChanged: (value) => print(value),
      children: const [
        Center(child: Text('Page1')),
        Center(child: Text('Page2')),
        Center(child: Text('Page3')),
        Center(child: Text('Page4')),
      ],
    ),
```
