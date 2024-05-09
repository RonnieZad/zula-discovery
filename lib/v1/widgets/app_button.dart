import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/utils/typography.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.labelText,
      required this.action,
      this.hasPadding = true});

  final String labelText;
  final VoidCallback action;
  final bool? hasPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: hasPadding == true ? 20.w : 0.0),
      child: SizedBox(
        height: 64.h,
        width: double.infinity,
        child: CupertinoButton(
            borderRadius: BorderRadius.circular(50.0),
            color: brandPrimaryColor.withOpacity(0.7),
            onPressed: action,
            child: label(text: labelText)),
      ),
    );
  }
}
