import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/controllers/controllers.dart';
import 'package:zula/v1/screens/dicover_page.dart';
import 'package:zula/v1/screens/explore_page.dart';
import 'package:zula/v1/screens/notification_center.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zula/v1/widgets/screen_helpers.dart';
import 'package:zula/v1/widgets/screen_overlay.dart';
import 'dart:math' as math;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController(viewportFraction: 0.95);

  LocationController locationController = Get.find();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    FirebaseAnalytics.instance.logScreenView(screenName: "HomePageScreen");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0.h,
              left: 0.0,
              right: 0.0,
              bottom: Platform.isAndroid ? 90.h : 90.h,
              child: locationController.homePageViewIsLoading.value
                  ? Container(
                      height: 0.2.sh,
                      width: 400.w,
                      margin: EdgeInsets.only(
                          top: 160.h, left: 20.w, right: 20.w, bottom: 40.h),
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: brandPrimaryColor.withOpacity(0.08)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 120,
                            height: 8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: Colors.black12),
                          ),
                          10.ph,
                          Container(
                            width: 80,
                            height: 8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                color: Colors.black12),
                          )
                        ],
                      ),
                    )
                      .animate(onPlay: (controller) => controller.repeat())
                      .slideY(
                        begin: 1.2,
                        end: 0,
                        delay: 300.ms,
                        duration: 800.ms,
                        curve: Curves.ease,
                      )
                      .shimmer(
                          curve: Curves.decelerate,
                          delay: 700.ms,
                          duration: 2000.ms,
                          color: Colors.white70)
                  : locationController.retrievedLocations.isEmpty
                      ? const NoContentWidget(
                          label:
                              'No Locations found\nCheck your internet or Refresh',
                        )
                      : PageView.builder(
                          clipBehavior: Clip.none,
                          controller: _pageController,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              locationController.retrievedLocations.length,
                          onPageChanged: (selectedPage) {
                            setState(() {
                              locationController.currentVideoFrameIndex =
                                  selectedPage;
                            });
                          },
                          itemBuilder: (context, index) {
                            return AnimatedBuilder(
                                animation: _pageController,
                                builder: (context, child) {
                                  double pageOffset = 0;
                                  if (_pageController.position.haveDimensions) {
                                    pageOffset = _pageController.page! - index;
                                  }
                                  double gauss = math.exp(
                                      -(math.pow((pageOffset.abs() - 0.5), 2) /
                                          0.08));
                                  return GestureDetector(
                                    onTap: () {
                                      HapticFeedback.selectionClick();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ExploreDetails(
                                            locationDetails: locationController
                                                .retrievedLocations[index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Transform.translate(
                                      offset: Offset(
                                          -32 * gauss * pageOffset.sign, 0),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          clipBehavior: Clip.none,
                                          children: [
                                            Positioned(
                                              bottom: 40.h,
                                              left: 0.0,
                                              right: 0.0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.r),
                                                    border: Border.all(
                                                      color: Colors.white24,
                                                    )),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.r),
                                                  child: SizedBox(
                                                    height: .715.sh,
                                                    width: double.infinity,
                                                    child: Stack(
                                                      children: [
                                                        locationController
                                                                .videoPlayerControllers
                                                                .isNotEmpty
                                                            ? VisibilityDetector(
                                                                key: Key(locationController
                                                                    .retrievedLocations[
                                                                        index]
                                                                    .locationName),
                                                                onVisibilityChanged:
                                                                    (visibilityInfo) {
                                                                  var visiblePercentage =
                                                                      visibilityInfo
                                                                              .visibleFraction *
                                                                          100;

                                                                  if (visiblePercentage >
                                                                          50 &&
                                                                      locationController
                                                                              .currentPageIndex
                                                                              .value ==
                                                                          0) {
                                                                    locationController
                                                                        .videoPlayerControllers[
                                                                            index]
                                                                        .play();
                                                                    locationController
                                                                        .videoPlayerControllers[
                                                                            index]
                                                                        .setLooping(
                                                                            true);
                                                                  } else {
                                                                    locationController
                                                                        .videoPlayerControllers[
                                                                            index]
                                                                        .pause();
                                                                  }
                                                                },
                                                                child: VideoPlayer(
                                                                    locationController
                                                                            .videoPlayerControllers[
                                                                        index]),
                                                              )
                                                            : const Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              ),
                                                        Container(
                                                          decoration: const BoxDecoration(
                                                              gradient: LinearGradient(
                                                                  begin: Alignment
                                                                      .topCenter,
                                                                  end: Alignment.bottomCenter,
                                                                  colors: [
                                                                Colors
                                                                    .transparent,
                                                                Colors.black87
                                                              ])),
                                                        ),
                                                        Positioned(
                                                          bottom: 65.h,
                                                          left: 15.w,
                                                          right: 15.w,
                                                          child: Transform
                                                              .translate(
                                                            offset: Offset(
                                                                -32 *
                                                                    gauss *
                                                                    pageOffset
                                                                        .sign,
                                                                0),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Expanded(
                                                                      child: heading(
                                                                          text: locationController
                                                                              .retrievedLocations[
                                                                                  index]
                                                                              .locationName,
                                                                          fontSize: 52
                                                                              .sp,
                                                                          fontFamily:
                                                                              'Rangile',
                                                                          color: Colors
                                                                              .white,
                                                                          textAlign:
                                                                              TextAlign.center),
                                                                    ),
                                                                  ],
                                                                ),
                                                                10.ph,
                                                                paragraph(
                                                                    text: locationController
                                                                        .retrievedLocations[
                                                                            index]
                                                                        .locationDescription,
                                                                    fontSize:
                                                                        22.sp,
                                                                    color: Colors
                                                                        .white,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 13.h,
                                              right: 120.w,
                                              left: 120.w,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 17.h,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: brandPrimaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          45.r),
                                                ),
                                                child: Center(
                                                    child: heading(
                                                        text: 'Explore',
                                                        color: Colors.white,
                                                        fontSize: 24.sp)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Positioned(
                                  bottom: 13.h,
                                  right: 120.w,
                                  left: 120.w,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 17.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: brandPrimaryColor,
                                      borderRadius: BorderRadius.circular(45.r),
                                    ),
                                    child: Center(
                                        child: heading(
                                            text: 'Explore',
                                            color: Colors.white,
                                            fontSize: 24.sp)),
                                  ),
                                ));
                          }),
            ),
            Positioned(
              top: Platform.isAndroid ? 40.h : 60.h,
              left: 20.w,
              right: 5.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/zula_logo.svg',
                    width: 100.w,
                    color: brandPrimaryColor,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      LineIcons.compass,
                      color: brandPrimaryColor,
                      size: 40.w,
                    ),
                    onPressed: () {
                      HapticFeedback.selectionClick();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DiscoverPage()));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      LineIcons.bell,
                      color: brandPrimaryColor,
                      size: 40.w,
                    ),
                    onPressed: () {
                      HapticFeedback.selectionClick();
                      ScreenOverlay.showAppSheet(context,
                          sheet: const NotificationCenter());

                      locationController.pauseAllVideoPlayback();
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
