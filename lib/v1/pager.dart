import 'dart:io';
import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/constants/strings.dart';
import 'package:zula/v1/controllers/location_controller.dart';
import 'package:zula/v1/controllers/ticket_controller.dart';
import 'package:zula/v1/screens/homepage.dart';
import 'package:zula/v1/screens/my_settings.dart';
import 'package:zula/v1/screens/ticket_page.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';

class AppCanvas extends StatefulWidget {
  const AppCanvas({super.key});

  @override
  State<AppCanvas> createState() => _AppCanvasState();
}

class _AppCanvasState extends State<AppCanvas> {
  final PageController _appPageController = PageController();
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  LocationController locationController = Get.put(LocationController());
  TickerController tickerController = Get.put(TickerController());

  List<Widget> appPages = [
    const MyHomePage(),
    const TicketPage(),
    const MySettings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _appPageController,
              itemBuilder: (context, index) {
                return appPages[index];
              }),
          Positioned(
              bottom: 0.h,
              left: 0.w,
              right: 0.w,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                    bottom: Platform.isAndroid ? 15.h : 30.h,
                    top: 10.h,
                    left: 40.w,
                    right: 40.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: bottomNavbar
                      .map((nav) => GestureDetector(
                            onTap: () {
                              analytics.logEvent(
                                  name: 'pages_tracked',
                                  parameters: {
                                    "page_name": nav['label'],
                                    "page_index": bottomNavbar.indexOf(nav)
                                  });
                              HapticFeedback.selectionClick();
                              _appPageController
                                  .jumpToPage(bottomNavbar.indexOf(nav));
                              setState(() {
                                locationController.currentPageIndex.value =
                                    bottomNavbar.indexOf(nav);
                              });
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    nav['icon'],
                                    color: bottomNavbar.indexOf(nav) ==
                                            locationController
                                                .currentPageIndex.value
                                        ? brandPrimaryColor
                                        : brandPrimaryColor.withOpacity(0.7),
                                    size: bottomNavbar.indexOf(nav) ==
                                            locationController
                                                .currentPageIndex.value
                                        ? 38.w
                                        : 28,
                                  ),
                                  6.ph,
                                  label(
                                    text: nav['label'],
                                    color: bottomNavbar.indexOf(nav) ==
                                            locationController
                                                .currentPageIndex.value
                                        ? brandPrimaryColor
                                        : brandPrimaryColor.withOpacity(0.7),
                                  )
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ))
        ],
      ),
    );
  }
}
