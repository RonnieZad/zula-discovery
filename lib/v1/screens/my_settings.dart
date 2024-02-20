//  ENYUMBA MOBILE APP
//
//  Created by Ronald Zad Muhanguzi .
//  2023, Enyumba App. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:zula/v1/controllers/auth_controller.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/app_background.dart';
import 'package:zula/v1/widgets/header.dart';
import 'package:zula/v1/widgets/screen_overlay.dart';
import 'package:zula/v1/widgets/settings_container.dart';
import 'package:zula/v1/widgets/settings_row.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return Scaffold(
      body: Stack(
        children: [
          const AppBackground(),
          Padding(
            padding: EdgeInsets.only(top: 120.h),
            child: ListView(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  const SettingsWidget(
                    title: '',
                    widget: Column(
                      children: [
                        SettingsRow(
                          routeName: 'helpCenter',
                          subHeading: 'Talk to Team for assistance',
                          iconData: LucideIcons.helpCircle,
                          title: 'Help Center',
                        ),
                        SettingsRow(
                          routeName: 'termsOfService',
                          subHeading: 'Learn more about our Terms of Service',
                          iconData: LucideIcons.fileText,
                          title: 'Terms of Service',
                        ),
                        SettingsRow(
                          routeName: 'privacyPolicy',
                          subHeading: 'See our privacy plicy',
                          iconData: LucideIcons.fileText,
                          title: 'Privacy Policy',
                        ),
                      ],
                    ),
                  ),
                  60.ph,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CupertinoButton(
                        borderRadius: BorderRadius.circular(50.0),
                        color: Colors.white24,
                        child: label(text: 'Log out'),
                        onPressed: () {
                          ScreenOverlay.showConfirmationDialog(context,
                              title: 'Log out',
                              description:
                                  'Confirm whether you would like to log out',
                              action: () {
                            authController.guestLogout();
                          });
                        }),
                  ),
                  50.ph,
                  SvgPicture.asset(
                    'assets/images/zula_logo.svg',
                    width: 65.w,
                    color: Colors.white70,
                  ),
                  10.ph,
                  Center(
                      child: paragraph(
                          text: 'Version: 1.0.1+3 Beta', color: Colors.white70))
                ]),
          ),
          const Header(
            titleText: 'Settings',
            headingText: 'Configure and set up preferences',
          ),
        ],
      ),
    );
  }
}
