
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';

class AppPreferencesSection extends StatelessWidget {
  const AppPreferencesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        title(
            text: 'Preferences',
            fontSize: 46.sp,
            color: brandPrimaryColor,
            fontFamily: 'Broncks',
            textAlign: TextAlign.center),
        30.ph,
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
              color: brandPrimaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  paragraph(text: 'Light Mode'),
                  Switch(
                      trackColor: MaterialStatePropertyAll(brandSecondaryColor),
                      value: true,
                      onChanged: (value) {})
                ],
              ),
              20.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  paragraph(text: 'Language'),
                  paragraph(text: 'English'),
                ],
              ),
              20.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  paragraph(text: 'Interests'),
                  paragraph(text: 'All Content'),
                ],
              ),
            ],
          ),
        ),
        30.ph,
      ],
    );
  }
}
