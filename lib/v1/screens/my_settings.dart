//  ENYUMBA MOBILE APP
//
//  Created by Ronald Zad Muhanguzi .
//  2023, Enyumba App. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/controllers/auth_controller.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/app_background.dart';
import 'package:zula/v1/widgets/header.dart';
import 'package:zula/v1/widgets/screen_overlay.dart';
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

  List<Map<String, dynamic>> settingsOptions = [
    {
      'title': 'Account',
      'description': 'Password\nPhone Number\nNotifications',
      'icon': LucideIcons.user
    },
    {
      'title': 'Preferences',
      'description': 'Theme\nLanguage\nInterests',
      'icon': LucideIcons.settings
    },
    {
      'title': 'Privacy',
      'description': 'Authentication\nPermissions\nData sharing',
      'icon': LucideIcons.shield
    },
    {
      'title': 'About',
      'description': 'App Version\nTerms\nPrivacy Policy',
      'icon': LucideIcons.info
    },
    // {
    //   'title': 'About',
    //   'description': 'App Version\nTerms\nPrivacy Policy',
    //   'icon': LucideIcons.info
    // }
  ];

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return Scaffold(
      body: Stack(
        children: [
          const AppBackground(),
          GridView.builder(
              padding: EdgeInsets.only(
                  top: 130.h, left: 10.w, right: 10.w, bottom: 140),
              itemCount: settingsOptions.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 235, crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.h),
                  child: GestureDetector(
                    onTap: () {
                      if (settingsOptions[index]['title'] == 'Account') {
                        ScreenOverlay.showAppSheet(context,
                            sheet: const AppAccountSection());
                      } else if (settingsOptions[index]['title'] ==
                          'Preferences') {
                        ScreenOverlay.showAppSheet(context,
                            sheet: const AppPreferencesSection());
                      } else if (settingsOptions[index]['title'] == 'Privacy') {
                        ScreenOverlay.showAppSheet(context,
                            sheet: const AppPrivacySection());
                      } else if (settingsOptions[index]['title'] == 'About') {
                        ScreenOverlay.showAppSheet(context,
                            sheet: const AppAboutSection());
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Stack(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
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
                                color: Colors.white70,
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

class AppAboutSection extends StatelessWidget {
  const AppAboutSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        title(
            text: 'About App',
            fontSize: 46.sp,
            color: Colors.white,
            fontFamily: 'Broncks',
            textAlign: TextAlign.center),
        30.ph,
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
              color: Colors.white70, borderRadius: BorderRadius.circular(20.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  paragraph(text: 'App Name'),
                  paragraph(text: 'Zula Vibe'),
                ],
              ),
              20.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  paragraph(text: 'App Version'),
                  paragraph(text: 'v1.0.4+10 Beta'),
                ],
              ),
              20.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  paragraph(text: 'Last Updated'),
                  paragraph(text: '12/03/2024'),
                ],
              ),
              20.ph,
              Row(
                children: [
                  paragraph(text: 'Terms'),
                  const Spacer(),
                  paragraph(text: 'Visit Link'),
                  10.pw,
                  const Icon(Icons.link)
                ],
              ),
              20.ph,
              Row(
                children: [
                  paragraph(text: 'Privacy Policy'),
                  const Spacer(),
                  paragraph(text: 'Visit Link'),
                  10.pw,
                  const Icon(Icons.link)
                ],
              ),
            ],
          ),
        ),
        35.ph,
        SizedBox(
          height: 64.h,
          width: 350,
          child: CupertinoButton(
              borderRadius: BorderRadius.circular(50.0),
              color: brandPrimaryColor.withOpacity(0.7),
              child: label(text: 'Share app '),
              onPressed: () {}),
        ),
        30.ph,
        paragraph(
          text: 'Made with ❤️ by\nSynapse Technologies',
          textAlign: TextAlign.center,
        ),
        30.ph,
      ],
    );
  }
}

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
            color: Colors.white,
            fontFamily: 'Broncks',
            textAlign: TextAlign.center),
        30.ph,
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
              color: Colors.white70, borderRadius: BorderRadius.circular(20.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  paragraph(text: '2FA'),
                  Switch(value: true, onChanged: (value) {})
                ],
              ),
              20.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  paragraph(text: 'Permissions'),
                  paragraph(text: 'All Accepted'),
                ],
              ),
              20.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  paragraph(text: 'Data Sharing'),
                  paragraph(text: 'Turned Off'),
                ],
              ),
            ],
          ),
        ),
                35.ph,
        SizedBox(
          height: 64.h,
          width: 350,
          child: CupertinoButton(
              borderRadius: BorderRadius.circular(50.0),
              color: brandPrimaryColor.withOpacity(0.7),
              child: label(text: 'Log Out'),
              onPressed: () {
                
              }),
        ),
        30.ph,
      ],
    );
  }
}

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
            color: Colors.white,
            fontFamily: 'Broncks',
            textAlign: TextAlign.center),
        30.ph,
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
              color: Colors.white70, borderRadius: BorderRadius.circular(20.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  paragraph(text: 'Light Mode'),
                  Switch(value: true, onChanged: (value) {})
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

class AppAccountSection extends StatelessWidget {
  const AppAccountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return Column(
      children: [
        title(
            text: 'Account',
            fontSize: 46.sp,
            color: Colors.white,
            fontFamily: 'Broncks',
            textAlign: TextAlign.center),
        30.ph,
        const CircleAvatar(
          maxRadius: 80,
          child: Icon(
            LucideIcons.user,
            size: 80,
          ),
        ),
        30.ph,
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
              color: Colors.white70, borderRadius: BorderRadius.circular(20.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  paragraph(text: 'Name'),
                  paragraph(text: '-'),
                ],
              ),
              20.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  paragraph(text: 'Phone Number'),
                  paragraph(text: '-'),
                ],
              ),
              20.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  paragraph(text: 'Email Address'),
                  paragraph(text: '-'),
                ],
              ),
              20.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  paragraph(text: 'Notifications'),
                  Switch(value: true, onChanged: (value) {})
                ],
              ),
            ],
          ),
        ),
        35.ph,
        SizedBox(
          height: 64.h,
          width: 350,
          child: CupertinoButton(
              borderRadius: BorderRadius.circular(50.0),
              color: brandPrimaryColor.withOpacity(0.7),
              child: label(text: 'Log Out'),
              onPressed: () {
                authController.guestLogout();
                Navigator.pop(context);
              }),
        ),
        30.ph,
      ],
    );
  }
}
