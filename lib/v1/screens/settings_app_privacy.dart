import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/constants/strings.dart';
import 'package:zula/v1/screens/docs.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';

class AppPrivacySection extends StatelessWidget {
  const AppPrivacySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        title(
            text: 'Privacy',
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DocsPages(
                                termsOfServie: termsCondtionsText,
                                headingText: 'Zula App\nTerms and Conditions',
                              )));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      const Icon(LineIcons.link),
                      10.pw,
                      paragraph(text: 'Terms'),
                      const Spacer(),
                      paragraph(text: 'Visit Link'),
                    ],
                  ),
                ),
              ),
              20.ph,
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DocsPages(
                                termsOfServie: privacyPolicyText,
                                headingText: 'Zula App\nPrivacy Policy',
                              )));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      const Icon(LineIcons.link),
                      10.pw,
                      paragraph(text: 'Privacy Policy'),
                      const Spacer(),
                      paragraph(text: 'Visit Link'),
                    ],
                  ),
                ),
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     paragraph(text: '2FA'),
              //     Switch(
              //         trackColor: MaterialStatePropertyAll(brandSecondaryColor),
              //         value: true,
              //         onChanged: (value) {})
              //   ],
              // ),
              // 20.ph,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     paragraph(text: 'Permissions'),
              //     paragraph(text: 'All Accepted'),
              //   ],
              // ),
              // 20.ph,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     paragraph(text: 'Data Sharing'),
              //     paragraph(text: 'Turned Off'),
              //   ],
              // ),
            ],
          ),
        ),
        30.ph,
      ],
    );
  }
}
