import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:octo_image/octo_image.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/screens/explore_page.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/image_blur_backdrop.dart';

import '../controllers/location_controller.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({
    super.key,
    this.hideBackButton = false,
  });

  final bool? hideBackButton;

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  LocationController locationController = Get.find();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // add setCurrentScreeninstead of initState because might not always give you the
    // expected results because initState() is called before the widget
    // is fully initialized, so the screen might not be visible yet.
    FirebaseAnalytics.instance.logScreenView(screenName: "SearchScreen");
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
                top: widget.hideBackButton! ? 50.h : 140.h,
                left: 0.0,
                right: 0.0,
                bottom: 100.0,
                child: locationController.searchPageViewIsLoading.value
                    ? Column(
                        children: [
                          240.ph,
                          Lottie.asset('splash_animation'.toJson,
                              width: 100.w, height: 100.w),
                          10.ph,
                          paragraph(text: 'Loading, please wait')
                        ],
                      )
                    : GridView.builder(
                            padding: EdgeInsets.only(
                                left: 20.w, right: 20.w, bottom: 120.h),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 270,
                                    mainAxisSpacing: 15.w,
                                    crossAxisSpacing: 15.h,
                                    crossAxisCount: 2),
                            itemCount: locationController
                                .retrievedLocationSearches.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  HapticFeedback.selectionClick();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ExploreDetails(
                                              locationDetails: locationController
                                                      .retrievedLocationSearches[
                                                  index])));
                                },
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Stack(
                                          children: [
                                            OctoImage(
                                              width: double.infinity,
                                              height: double.infinity,
                                              placeholderBuilder:
                                                  OctoBlurHashFix.placeHolder(
                                                      'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                                              errorBuilder: OctoError.icon(
                                                  color: Colors.red),
                                              image: CachedNetworkImageProvider(
                                                  locationController
                                                      .retrievedLocationSearches[
                                                          index]
                                                      .locationPicture[0]
                                                      .locationPictureUrl),
                                              fit: BoxFit.cover,
                                            ),
                                            Container(
                                              height: double.infinity,
                                              width: double.infinity,
                                              decoration: const BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                    Colors.transparent,
                                                    Colors.black45
                                                  ])),
                                            ),
                                            Positioned(
                                              bottom: 15.h,
                                              left: 15.w,
                                              right: 15.w,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  heading(
                                                      text: locationController
                                                          .retrievedLocationSearches[
                                                              index]
                                                          .locationName,
                                                      fontSize: 25.sp,
                                                      color: Colors.white),
                                                  8.ph,
                                                  // paragraph(
                                                  //     text:
                                                  //         '${locationController.retrievedLocationSearches[index].categoryCount} places',
                                                  //     fontSize: 18.sp,
                                                  //     color: Colors.white)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })
                        .animate(onPlay: (controller) => controller.repeat())
                        .shimmer(
                            delay: 700.ms,
                            duration: 2000.ms,
                            color: Theme.of(context).scaffoldBackgroundColor)),
            widget.hideBackButton!
                ? const SizedBox.shrink()
                : Positioned(
                    top: 60.h,
                    left: 20.w,
                    right: 20.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Icon(CupertinoIcons.arrow_left,
                                    color: brandPrimaryColor, size: 30.w),
                                20.pw,
                                heading(
                                    text: 'Search Results',
                                    fontSize: 30.sp,
                                    color: brandPrimaryColor),
                              ],
                            ),
                          ),
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
