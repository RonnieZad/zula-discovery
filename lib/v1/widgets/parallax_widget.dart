import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParallaxWidget extends StatelessWidget {
  const ParallaxWidget({
    Key? key,
    required this.top,
    required this.widget,
  }) : super(key: key);

  final double top;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -130.w,
      right: -130.w,
      top: top,
      child: widget,
    );
  }
}
