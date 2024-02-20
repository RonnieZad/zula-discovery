import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/constants/strings.dart';
import 'package:zula/v1/controllers/location_controller.dart';
import 'package:zula/v1/controllers/ticket_controller.dart';
import 'package:zula/v1/screens/dicover_page.dart';

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
  LocationController locationController = Get.put(LocationController());
  TickerController tickerController = Get.put(TickerController());

  List<Widget> appPages = [
    const MyHomePage(),
    const DiscoverPage(),
    const TicketPage(),
    const MySettings()
  ];

  int currentPageIndex = 0;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color(0xFFFFB6B9),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    super.initState();
  }

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
              child: ClipRRect(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: 15.h, top: 15.h, left: 40.w, right: 40.w),
                  // color: Colors.white10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: bottomNavbar
                        .map((nav) => GestureDetector(
                              onTap: () {
                                HapticFeedback.selectionClick();
                                _appPageController
                                    .jumpToPage(bottomNavbar.indexOf(nav));
                                setState(() {
                                  currentPageIndex = bottomNavbar.indexOf(nav);
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
                                              currentPageIndex
                                          ? brandPrimaryColor
                                          : const Color.fromARGB(
                                              167, 19, 14, 9),
                                      size: bottomNavbar.indexOf(nav) ==
                                              currentPageIndex
                                          ? 35.w
                                          : 26,
                                    ),
                                    10.ph,
                                    label(
                                      text: nav['label'],
                                      color: bottomNavbar.indexOf(nav) ==
                                              currentPageIndex
                                          ? brandPrimaryColor
                                          : const Color.fromARGB(
                                              167, 19, 14, 9),
                                    )
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ))
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
