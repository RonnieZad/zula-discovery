//  ENYUMBA MOBILE APP
//
//  Created by Ronald Zad Muhanguzi .
//  2023, Enyumba App. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/constants/strings.dart';
import 'package:zula/v1/screens/dicover_page.dart';
import 'package:zula/v1/screens/notification_center.dart';
import 'package:zula/v1/screens/settings_account.dart';
import 'package:zula/v1/screens/settings_app_info.dart';
import 'package:zula/v1/screens/settings_app_privacy.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/header.dart';
import 'package:zula/v1/widgets/screen_overlay.dart';

class MySettings extends StatefulWidget {
  const MySettings({super.key});

  @override
  State<MySettings> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  @override
  void initState() {
    super.initState();
  }

  void _appSettingsRoute({required String settingsRoute}) {
    print(settingsRoute);
    switch (settingsRoute) {
      case 'account':
        ScreenOverlay.showAppSheet(context, sheet: const AppAccountSection());

        break;
      case 'privacy':
        ScreenOverlay.showAppSheet(context, sheet: const AppPrivacySection());

        break;
      case 'about':
        ScreenOverlay.showAppSheet(context, sheet: const AppAboutSection());

        break;
      default:
    }
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: brandPrimaryColor.withOpacity(0.2),
      actions: [
        IconButton(
          icon: Icon(
            LineIcons.compass,
            color: brandPrimaryColor,
            size: 40.w,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const DiscoverPage()));
          },
        ),
        // 10.pw,
        IconButton(
          icon: Icon(
            LineIcons.bell,
            color: brandPrimaryColor,
            size: 40.w,
          ),
          onPressed: () {
            ScreenOverlay.showAppSheet(context,
                sheet: const NotificationCenter());
          },
        ),
      ],
      title: title(
          text: 'Setup',
          fontSize: 46.sp,
          color: brandPrimaryColor,
          fontFamily: 'TypoGraphica',
          textAlign: TextAlign.center),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GridView.builder(
              padding: EdgeInsets.only(
                  top: 30.h, left: 10.w, right: 10.w, bottom: 140),
              itemCount: settingsOptions.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 255, crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.h),
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      _appSettingsRoute(
                          settingsRoute:
                              settingsOptions[index]['title'].toLowerCase());
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Stack(
                        children: [
                          Positioned(
                              right: -40,
                              top: -34,
                              child: Icon(
                                settingsOptions[index]['icon'],
                                size: 140.0,
                                color: Colors.black26,
                              )),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 20.h),
                            decoration: BoxDecoration(
                                color: brandPrimaryColor.withOpacity(0.16),
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                heading(text: settingsOptions[index]['title']),
                                10.ph,
                                paragraph(
                                    text: settingsOptions[index]
                                        ['description']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
