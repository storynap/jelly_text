library jelly_text;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A Text widget that shows a "See more" button when text exceeds maxLines.
/// When tapped, it expands to show the full content.
class JellyText extends StatefulWidget {
  /// The text to display.
  final String text;

  /// The text style to use.
  final TextStyle? style;

  /// The custom "See more" text to use.
  final String seeMoreText;

  /// The style for the "See more" text.
  final TextStyle? seeMoreStyle;

  /// The function to call when "See more" is tapped.
  /// If null, the default behavior (expanding text) is used.
  final VoidCallback? onSeeMoreTap;

  /// The maximum number of lines to show initially.
  final int maxLines;

  /// The text overflow behavior.
  final TextOverflow overflow;

  /// The text alignment.
  final TextAlign? textAlign;

  /// The text direction.
  final TextDirection? textDirection;

  /// Whether to softwrap the text.
  final bool softWrap;

  /// The text scale factor.
  final double? textScaleFactor;

  /// The locale for the text.
  final Locale? locale;

  /// The struct style to use.
  final StrutStyle? strutStyle;

  /// The text width basis.
  final TextWidthBasis textWidthBasis;

  /// The text height behavior.
  final TextHeightBehavior? textHeightBehavior;

  /// Whether to select text.
  final bool selectionEnabled;

  /// Creates a JellyText widget.
  const JellyText({
    super.key,
    required this.text,
    this.style,
    this.seeMoreText = 'See more',
    this.seeMoreStyle,
    this.onSeeMoreTap,
    this.maxLines = 3,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign,
    this.textDirection,
    this.softWrap = true,
    this.textScaleFactor,
    this.locale,
    this.strutStyle,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
    this.selectionEnabled = false,
  });

  @override
  State<JellyText> createState() => _JellyTextState();
}

class _JellyTextState extends State<JellyText> {
  bool _expanded = false;
  late TextSpan _textSpan;
  late TextSpan _seeMoreSpan;

  @override
  void initState() {
    super.initState();
    _updateTextSpans();
  }

  @override
  void didUpdateWidget(JellyText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text ||
        oldWidget.style != widget.style ||
        oldWidget.seeMoreText != widget.seeMoreText ||
        oldWidget.seeMoreStyle != widget.seeMoreStyle) {
      _updateTextSpans();
    }
  }

  void _updateTextSpans() {
    _textSpan = TextSpan(
      text: widget.text,
      style: widget.style,
    );

    _seeMoreSpan = TextSpan(
      text: widget.seeMoreText,
      style: widget.seeMoreStyle ??
          const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          if (widget.onSeeMoreTap != null) {
            widget.onSeeMoreTap!();
          } else {
            setState(() {
              _expanded = true;
            });
          }
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Check if the text would overflow
    final textPainter = TextPainter(
      text: _textSpan,
      textDirection: widget.textDirection ?? TextDirection.ltr,
      maxLines: widget.maxLines,
      textScaler: widget.textScaleFactor != null
          ? TextScaler.linear(widget.textScaleFactor!)
          : MediaQuery.of(context).textScaler,
    )..layout(maxWidth: MediaQuery.of(context).size.width);

    final bool hasTextOverflow = textPainter.didExceedMaxLines;

    if (!hasTextOverflow || _expanded) {
      // If text doesn't overflow or it's expanded, show the regular text
      return Text(
        widget.text,
        style: widget.style,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        softWrap: widget.softWrap,
        overflow: _expanded ? TextOverflow.clip : widget.overflow,
        textScaler: widget.textScaleFactor != null
            ? TextScaler.linear(widget.textScaleFactor!)
            : MediaQuery.of(context).textScaler,
        maxLines: _expanded ? null : widget.maxLines,
        locale: widget.locale,
        strutStyle: widget.strutStyle,
        textWidthBasis: widget.textWidthBasis,
        textHeightBehavior: widget.textHeightBehavior,
        selectionColor: widget.selectionEnabled ? Theme.of(context).colorScheme.primary.withOpacity(0.4) : null,
      );
    } else {
      // If text overflows and not expanded, show truncated text with "See more" button
      // Calculate approximate character count that will fit in maxLines
      final textStyle = widget.style ?? DefaultTextStyle.of(context).style;
      final displayWidth = MediaQuery.of(context).size.width;

      // Estimate how many characters we can fit per line
      final charactersPerLine = displayWidth / (textStyle.fontSize ?? 14.0) * 1.5;

      // Calculate total characters that should fit within maxLines
      // Reserve space for "See more" text and ellipsis
      final seeMoreLength = widget.seeMoreText.length + 4; // +1 for space, +3 for ellipsis
      final maxChars = (charactersPerLine * widget.maxLines).toInt() - seeMoreLength;

      // Ensure we don't try to substring beyond text length
      final endIndex = widget.text.length > maxChars ? maxChars : widget.text.length;
      final truncatedText = widget.text.substring(0, endIndex);

      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: truncatedText,
              style: widget.style ?? DefaultTextStyle.of(context).style,
            ),
            TextSpan(
              text: '... ',
              style: widget.style ?? DefaultTextStyle.of(context).style,
            ),
            _seeMoreSpan,
          ],
        ),
        textAlign: widget.textAlign ?? TextAlign.start,
        textDirection: widget.textDirection,
        softWrap: widget.softWrap,
        locale: widget.locale,
        strutStyle: widget.strutStyle,
        textScaler: widget.textScaleFactor != null
            ? TextScaler.linear(widget.textScaleFactor!)
            : MediaQuery.of(context).textScaler,
        textWidthBasis: widget.textWidthBasis,
        textHeightBehavior: widget.textHeightBehavior,
      );
    }
  }
}
