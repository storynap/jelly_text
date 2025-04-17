# JellyText

A Flutter widget that provides an expandable text with "See more" functionality.

## Features

- 📝 Acts as a drop-in replacement for the standard Flutter Text widget
- 🔍 Automatically shows a "See more" text when content overflows the maxLines limit
- 📱 Expands to show the full text when "See more" is tapped
- 🎨 Customizable "See more" text and styling
- 🔄 Custom callback support for the "See more" action

## Getting started

Add the package to your `pubspec.yaml` file:

```yaml
dependencies:
  jelly_text: ^0.0.1
```

Then run:

```
flutter pub get
```

## Usage

Import the package:

```dart
import 'package:jelly_text/jelly_text.dart';
```

### Basic usage

```dart
JellyText(
  text: 'This is a long text that will be truncated with a "See more" button when it exceeds the maximum number of lines.',
  maxLines: 2,
)
```

### Customizing the "See more" text

```dart
JellyText(
  text: 'This is a long text that will be truncated with a custom button text when it exceeds the maximum number of lines.',
  maxLines: 2,
  seeMoreText: 'Read more...',
)
```

### Customizing the "See more" style

```dart
JellyText(
  text: 'This is a long text with custom "See more" styling.',
  maxLines: 2,
  seeMoreStyle: TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  ),
)
```

### Using a custom callback for "See more"

```dart
JellyText(
  text: 'This is a long text with a custom callback when "See more" is tapped.',
  maxLines: 2,
  seeMoreText: 'Tap for action',
  onSeeMoreTap: () {
    // Your custom action here
    print('Custom action executed!');
  },
)
```

## Complete Example

The `/example` folder contains a complete Flutter application that demonstrates all features of the JellyText widget.

## Additional Information

- The JellyText widget is designed to be a drop-in replacement for the standard Flutter Text widget
- It supports most Text widget properties such as style, textAlign, overflow, etc.
- When the "See more" button is tapped, the text expands to show the full content by default
- You can override this behavior by providing a custom `onSeeMoreTap` callback
