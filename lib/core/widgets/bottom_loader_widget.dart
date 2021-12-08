import 'package:flutter/material.dart';

class BottomLoaderWidget extends StatelessWidget {
  BottomLoaderWidget({this.strokeWidth = 3});
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.secondaryVariant),
      ),
    );
  }
}
