import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/link_parser.dart';
import 'package:zula/v1/utils/typography.dart';

class ShareSheet extends StatelessWidget {
  const ShareSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: title(
                text: 'Share',
                fontSize: 46.sp,
                color: brandPrimaryColor,
                fontFamily: 'Broncks',
                textAlign: TextAlign.center),
          ),
          20.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  LinkParser.launchWhatsappWithLink(
                      'Check out the Zula Discovery app on playstore to find the perfect memory place, use the link below');
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Icon(LineIcons.twitter, size: 35.w),
                      10.ph,
                      paragraph(
                          text: 'X', fontSize: 22.sp)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  LinkParser.launchWhatsappWithLink(
                      'Check out the Zula Discovery app on playstore to find the perfect memory place, use the link below');
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Icon(LineIcons.whatSApp, size: 35.w),
                      10.ph,
                      paragraph(
                          text: 'Whatsapp',
                          fontSize: 22.sp,
                          )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  LinkParser.launchSMSWithLink(
                      'Check out the Zula Discovery app on playstore to find the perfect memory place, use the link below');
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Icon(LineIcons.sms, size: 35.w),
                      10.ph,
                      paragraph(
                          text: 'SMS', fontSize: 22.sp)
                    ],
                  ),
                ),
              ),
                  GestureDetector(
                onTap: () {
                  LinkParser.launchSMSWithLink(
                      'Check out the Zula Discovery app on playstore to find the perfect memory place, use the link below');
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Icon(LineIcons.facebookF, size: 35.w),
                      10.ph,
                      paragraph(
                          text: 'Facebook', fontSize: 22.sp)
                    ],
                  ),
                ),
              ),
                  GestureDetector(
                onTap: () {
                  LinkParser.launchSMSWithLink(
                      'Check out the Zula Discovery app on playstore to find the perfect memory place, use the link below');
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Icon(LineIcons.instagram, size: 35.w),
                      10.ph,
                      paragraph(
                          text: 'IG', fontSize: 22.sp)
                    ],
                  ),
                ),
              ),
              
            ],
          ),
          60.ph,
        ],
      ),
    );
  }
}
