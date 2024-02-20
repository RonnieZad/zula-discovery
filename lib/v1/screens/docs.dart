import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/app_background.dart';
import 'package:zula/v1/widgets/widgets.dart';

class DocsPages extends StatelessWidget {
  const DocsPages({
    super.key,
    required this.termsOfServie,
    required this.headingText,
    this.textAlign,
  });

  final String termsOfServie;
  final String headingText;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppBackground(),
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            children: [
              140.ph,
              Center(
                  child: title(
                      text: headingText,
                      textAlign: TextAlign.center,
                      fontSize: 36.sp)),
              20.ph,
              paragraph(
                  text: termsOfServie,
                  fontSize: 22.sp,
                  textAlign: textAlign ?? TextAlign.justify)
            ],
          ),
          const Header(
            titleText: 'Back',
            headingText: '',
            hasBackButton: true,
          ),
        ],
      ),
    );
  }
}
