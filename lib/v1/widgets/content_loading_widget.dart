import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';

class ContentLoadingWidget extends StatelessWidget {
  const ContentLoadingWidget({
    super.key,
    this.hasPadding = true,
  });

  final bool? hasPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        hasPadding == true ? 240.ph : const SizedBox.shrink(),
        Lottie.asset('splash_animation'.toJson, width: 100.w, height: 100.w),
        10.ph,
        paragraph(text: 'Loading, please wait')
      ],
    );
  }
}
