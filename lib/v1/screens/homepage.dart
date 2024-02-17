import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zula/v1/controllers/controllers.dart';
import 'package:zula/v1/screens/explore_page.dart';
import 'package:zula/v1/screens/notification_center.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zula/v1/widgets/app_background.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController(viewportFraction: 0.95);

  LocationController locationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            const AppBackground(),
            Positioned(
              top: 0.h,
              left: 0.0,
              right: 0.0,
              bottom: 90.h,
              child: locationController.homePageViewIsLoading.value
                  ? Container(
                      height: 0.2.sh,
                      width: 400.w,
                      margin: EdgeInsets.only(
                          top: 160.h, left: 20.w, right: 20.w, bottom: 40.h),
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: Colors.white24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 120,
                            height: 8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: Colors.white30),
                          ),
                          10.ph,
                          Container(
                            width: 80,
                            height: 8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                color: Colors.white30),
                          )
                        ],
                      ),
                    )
                      .animate(onPlay: (controller) => controller.repeat())
                      .slideY(begin: 0.2, end: 0, duration: 500.ms)
                      .shimmer(
                          delay: 700.ms,
                          duration: 2000.ms,
                          color: Colors.black38)
                      .scaleY(duration: 800.ms)
                  : PageView.builder(
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: locationController.retrievedLocations.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ExploreDetails(
                                        locationDetails: locationController
                                            .retrievedLocations[index])));
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  bottom: 50.h,
                                  left: 0.0,
                                  right: 0.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        border: Border.all(
                                          color: Colors.white24,
                                        )),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.r),
                                      child: SizedBox(
                                        height: .674.sh,
                                        width: double.infinity,
                                        child: Stack(
                                          children: [
                                            locationController
                                                    .videoPlayerControllers
                                                    .isNotEmpty
                                                ? VisibilityDetector(
                                                    key: Key(locationController.retrievedLocations[index]
                                                        .locationName),
                                                    onVisibilityChanged:
                                                        (visibilityInfo) {
                                                      var visiblePercentage =
                                                          visibilityInfo
                                                                  .visibleFraction *
                                                              100;

                                                      if (visiblePercentage >
                                                          50) {
                                                        locationController
                                                            .videoPlayerControllers[
                                                                index]
                                                            .play();
                                                        locationController
                                                            .videoPlayerControllers[
                                                                index]
                                                            .setLooping(true);
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
                                                            index]))
                                                : const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                    Colors.transparent,
                                                    Colors.black87
                                                  ])),
                                            ),
                                            Positioned(
                                              bottom: 65.h,
                                              left: 15.w,
                                              right: 15.w,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      heading(
                                                          text: locationController
                                                              .retrievedLocations[
                                                                  index]
                                                              .locationName,
                                                          fontSize: 30.sp,
                                                          color: Colors.white),
                                                      10.pw,
                                                      Icon(
                                                        LucideIcons.badgeCheck,
                                                        color: Colors.white,
                                                        size: 20.w,
                                                      )
                                                    ],
                                                  ),
                                                  10.ph,
                                                  paragraph(
                                                      text: locationController
                                                          .retrievedLocations[
                                                              index]
                                                          .locationDescription,
                                                      fontSize: 20.sp,
                                                      color: Colors.white,
                                                      textAlign:
                                                          TextAlign.center),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 18.h,
                                  right: 120.w,
                                  left: 120.w,
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 17.h),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(20, 45, 66, 1),
                                      borderRadius: BorderRadius.circular(15.r),
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
                        );
                      }),
            ),
            Positioned(
                top: 50.h,
                left: 20.w,
                right: 20.w,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/images/zula_logo.svg',
                            width: 100.w,
                            color: Colors.white,
                          ),
                          4.ph,
                          paragraph(
                              text: 'Experience Everywhere!',
                              color: Colors.white60,
                              fontSize: 17.sp)
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        icon:  Icon(
                          LucideIcons.bell,
                          color: Colors.white,
                          size: 35.w,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotificationCenter()));
                        },
                      ),
                    ])),
          ],
        );
      }),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
