import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget withPadding({
    double? all,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left ?? all ?? 0,
        top: top ?? all ?? 0,
        right: right ?? all ?? 0,
        bottom: bottom ?? all ?? 0,
      ),
      child: this,
    );
  }
}
