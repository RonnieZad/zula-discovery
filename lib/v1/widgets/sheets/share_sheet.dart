import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:octo_image/octo_image.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/link_parser.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/image_blur_backdrop.dart';

class ShareSheet extends StatelessWidget {
  const ShareSheet({
    super.key,
    this.imagePath,
    this.postTitle,
    this.postDescription,
  });

  final String? imagePath, postTitle, postDescription;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          imagePath == null
              ? const SizedBox.shrink()
              : Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Stack(
                        children: [
                          OctoImage(
                            width: 420.w,
                            height: 510.h,
                            placeholderBuilder: OctoBlurHashFix.placeHolder(
                                'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                            errorBuilder: OctoError.icon(color: Colors.red),
                            image: CachedNetworkImageProvider(
                              imagePath!,
                            ),
                            fit: BoxFit.cover,
                          ),
                          Container(
                            width: 420.w,
                            height: 510.h,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.transparent, Colors.black87])),
                          ),
                          Positioned(
                            bottom: 65.h,
                            left: 15.w,
                            right: 15.w,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: heading(
                                          text: postTitle!,
                                          fontSize: 52.sp,
                                          fontFamily: 'Rangile',
                                          color: Colors.white,
                                          textAlign: TextAlign.center),
                                    ),
                                  ],
                                ),
                                10.ph,
                                paragraph(
                                    text: postDescription!,
                                    fontSize: 22.sp,
                                    color: Colors.white,
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
               10.ph,
                ],
              ),
          Center(
            child: title(
                text: 'Share',
                fontSize: 46.sp,
                color: brandPrimaryColor,
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
                      paragraph(text: 'X', fontSize: 22.sp)
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
                      paragraph(text: 'SMS', fontSize: 22.sp)
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
                      paragraph(text: 'Facebook', fontSize: 22.sp)
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
                      paragraph(text: 'IG', fontSize: 22.sp)
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
