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
import 'package:zula/v1/screens/settings.dart';
import 'package:zula/v1/screens/ticket_page.dart';

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
            child: BottomNavigationBar(
              elevation: 0,
                enableFeedback: true,
                unselectedIconTheme: IconThemeData(
                    color: brandPrimaryColor.withOpacity(0.8), size: 30.w),
                selectedIconTheme:
                    IconThemeData(color: brandPrimaryColor, size: 35.w),
                currentIndex: locationController.currentPageIndex.value,
                selectedLabelStyle: TextStyle(
                    fontSize: 18.sp,
                    color: brandPrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Cereal'),
                unselectedLabelStyle: TextStyle(
                    fontSize: 17.sp,
                    color: brandPrimaryColor,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Cereal'),
                backgroundColor: Colors.white,
                onTap: (value) {
                  analytics.logEvent(name: 'pages_tracked', parameters: {
                    "page_name": bottomNavbar[value]['label'],
                    "page_index": value
                  });
                  _appPageController.jumpToPage(value);
                  setState(() {
                    locationController.currentPageIndex.value = value;
                  });
                },
                items: bottomNavbar
                    .map((nav) => BottomNavigationBarItem(
                        tooltip: nav['label'],
                        label: nav['label'],
                        icon: Icon(
                          nav['icon'],
                        )))
                    .toList()),
          ),
        ],
      ),
    );
  }
}
