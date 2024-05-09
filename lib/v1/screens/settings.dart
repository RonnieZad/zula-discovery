//  ENYUMBA MOBILE APP
//
//  Created by Ronald Zad Muhanguzi .
//  2023, Enyumba App. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/constants/strings.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GridView.builder(
              padding: EdgeInsets.only(
                  top: 130.h, left: 10.w, right: 10.w, bottom: 140),
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
          const Header(
            titleText: 'Settings',
            headingText: '',
          ),
        ],
      ),
    );
  }
}
