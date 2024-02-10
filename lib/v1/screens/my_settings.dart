//  ENYUMBA MOBILE APP
//
//  Created by Ronald Zad Muhanguzi .
//  2023, Enyumba App. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:vybe/v1/controllers/auth_controller.dart';
import 'package:vybe/v1/utils/extensions.dart';
import 'package:vybe/v1/utils/typography.dart';
import 'package:vybe/v1/widgets/app_background.dart';
import 'package:vybe/v1/widgets/header.dart';
import 'package:vybe/v1/widgets/settings_container.dart';
import 'package:vybe/v1/widgets/settings_row.dart';
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
    AuthController _authController = Get.find();
    return Scaffold(
      body: Stack(
        children: [
          const AppBackground(),
          Padding(
            padding: EdgeInsets.only(top: 150.h),
            child: ListView(
                padding: EdgeInsets.only(bottom: 130.h),
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  const SettingsWidget(
                    title: 'Help',
                    widget: Column(
                      children: [
                        SettingsRow(
                          routeName: 'helpCenter',
                          subHeading: 'Talk to Team for assistance',
                          iconData: LucideIcons.helpCircle,
                          title: 'Help Center',
                        ),
                        SettingsRow(
                          routeName: '',
                          subHeading: 'Learn more about our Terms of Service',
                          iconData: LucideIcons.fileText,
                          title: 'Terms of Service',
                        ),
                        SettingsRow(
                          routeName: '',
                          subHeading: 'See our terms and conditions',
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
                        color: Colors.white10,
                        child: label(text: 'Log out'),
                        onPressed: () {
                          showDialog(
                              context: context,
                              barrierColor: Colors.black87,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  backgroundColor: Colors.black,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 15.h),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          heading(
                                              text: 'Test here',
                                              color: Colors.white),
                                          10.ph,
                                          paragraph(
                                              text:
                                                  'Confirm whether you would like to log out',
                                              color: Colors.white60),
                                          25.ph,
                                          Row(
                                            children: [
                                              Expanded(
                                                child: CupertinoButton(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                  color: Colors.white10,
                                                  child: label(text: 'Log out'),
                                                  onPressed: () {
                                                    _authController
                                                        .guestLogout();
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          10.ph,
                                          Center(
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: label(
                                                      text: 'Cancel',
                                                      color: Colors.white60)))
                                        ]),
                                  ),
                                );
                              });
                        }),
                  ),
                  50.ph,
                  SvgPicture.asset(
                    'assets/images/zula_logo.svg',
                    width: 65.w,
                    color: Colors.white30,
                  ),
                  10.ph,
                  Center(
                      child: paragraph(
                          text: 'Version: 1.0.0 Beta', color: Colors.white30))
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
