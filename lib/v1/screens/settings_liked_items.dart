

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/controllers/location_controller.dart';
import 'package:zula/v1/controllers/ticket_controller.dart';
import 'package:zula/v1/screens/explore_page.dart';
import 'package:zula/v1/screens/ticket_page_detail.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/image_blur_backdrop.dart';

class SavedItems extends StatefulWidget {
  const SavedItems({
    super.key,
  });

  @override
  State<SavedItems> createState() => _SavedItemsState();
}

class _SavedItemsState extends State<SavedItems> {
  int groupValue = 0;
  LocationController locationController = Get.find();

  TickerController eventTicketController = Get.find();
  PageController savedItemPageController = PageController();

  @override
  void initState() {
    locationController.getUserSavedLocations();
    eventTicketController.getUserSavedEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            title(
                text: 'Saved Items',
                fontSize: 46.sp,
                color: brandPrimaryColor,
                fontFamily: 'Broncks',
                textAlign: TextAlign.center),
            30.ph,
            Row(
              children: [
                Expanded(
                  child: CupertinoSlidingSegmentedControl(
                      backgroundColor: brandPrimaryColor.withOpacity(0.1),
                      groupValue: groupValue,
                      padding:
                          EdgeInsets.symmetric(vertical: 7.h, horizontal: 8.w),
                      children: {
                        0: label(
                            text: "Locations",
                            color: groupValue == 0
                                ? Colors.black
                                : brandPrimaryColor),
                        1: label(
                            text: "Events",
                            color: groupValue == 1
                                ? Colors.black
                                : brandPrimaryColor),
                      },
                      onValueChanged: (selectedTab) {
                        setState(() {
                          groupValue = selectedTab!;
                          savedItemPageController.jumpToPage(selectedTab);
                        });
                      }),
                ),
              ],
            ),
            20.ph,
            SizedBox(
              height: 560.h,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: savedItemPageController,
                children: [
                  Column(
                    children: [
                      locationController.savedLocationLoading.value
                          ? Expanded(
                              child: GridView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(bottom: 120.h),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisExtent: 270,
                                              mainAxisSpacing: 15.w,
                                              crossAxisSpacing: 15.h,
                                              crossAxisCount: 2),
                                      itemCount: 8,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: EdgeInsets.all(20.w),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6.r),
                                              color: Colors.white24),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: 100,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.r),
                                                    color: Colors.white30),
                                              ),
                                              10.ph,
                                              Container(
                                                width: 60,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.r),
                                                    color: Colors.white30),
                                              )
                                            ],
                                          ),
                                        );
                                      })
                                  .animate(
                                      onPlay: (controller) =>
                                          controller.repeat())
                                  .shimmer(
                                    delay: 700.ms,
                                    duration: 3000.ms,
                                    color: Colors.black38,
                                  ),
                            )
                          : locationController.retrievedSavedLocations.isEmpty
                              ? Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      140.ph,
                                      heading(
                                        text: 'No Saved Locations',
                                      ),
                                      10.ph,
                                      paragraph(
                                          text:
                                              'When you favorite locations\nthey will appear here',
                                          textAlign: TextAlign.center)
                                    ],
                                  ),
                                )
                              : Expanded(
                                  child: GridView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(
                                          left: 0.w, right: 0.w, bottom: 120.h),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisExtent: 270,
                                              mainAxisSpacing: 15.w,
                                              crossAxisSpacing: 15.h,
                                              crossAxisCount: 2),
                                      itemCount: locationController
                                          .retrievedSavedLocations.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            HapticFeedback.selectionClick();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ExploreDetails(
                                                            locationDetails:
                                                                locationController
                                                                        .retrievedSavedLocations[
                                                                    index])));
                                          },
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: Stack(
                                                    children: [
                                                      OctoImage(
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        placeholderBuilder:
                                                            OctoBlurHashFix
                                                                .placeHolder(
                                                                    'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                                                        errorBuilder:
                                                            OctoError.icon(
                                                                color:
                                                                    Colors.red),
                                                        image: CachedNetworkImageProvider(
                                                            locationController
                                                                .retrievedSavedLocations[
                                                                    index]
                                                                .locationPicture[
                                                                    0]
                                                                .locationPictureUrl),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      Container(
                                                        height: double.infinity,
                                                        width: double.infinity,
                                                        decoration: const BoxDecoration(
                                                            gradient: LinearGradient(
                                                                begin: Alignment
                                                                    .topCenter,
                                                                end: Alignment
                                                                    .bottomCenter,
                                                                colors: [
                                                              Colors
                                                                  .transparent,
                                                              Colors.black45
                                                            ])),
                                                      ),
                                                      Positioned(
                                                        bottom: 15.h,
                                                        left: 15.w,
                                                        right: 15.w,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            heading(
                                                                text: locationController
                                                                    .retrievedSavedLocations[
                                                                        index]
                                                                    .locationName,
                                                                fontSize: 25.sp,
                                                                color: Colors
                                                                    .white),
                                                            // 8.ph,
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
                                      }),
                                )
                    ],
                  ),
                  Column(
                    children: [
                      eventTicketController.savedEventPageLoading.value
                          ? Expanded(
                              child: GridView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(bottom: 120.h),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisExtent: 270,
                                              mainAxisSpacing: 15.w,
                                              crossAxisSpacing: 15.h,
                                              crossAxisCount: 2),
                                      itemCount: 8,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: EdgeInsets.all(20.w),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6.r),
                                              color: Colors.white24),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: 100,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.r),
                                                    color: Colors.white30),
                                              ),
                                              10.ph,
                                              Container(
                                                width: 60,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.r),
                                                    color: Colors.white30),
                                              )
                                            ],
                                          ),
                                        );
                                      })
                                  .animate(
                                      onPlay: (controller) =>
                                          controller.repeat())
                                  .shimmer(
                                    delay: 700.ms,
                                    duration: 3000.ms,
                                    color: Colors.black38,
                                  ),
                            )
                          : eventTicketController.savedEventTickets.isEmpty
                              ? Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      140.ph,
                                      heading(
                                        text: 'No saved Event Tickets',
                                      ),
                                      10.ph,
                                      paragraph(
                                          text:
                                              'When you favorite locations\nthey will appear here',
                                          textAlign: TextAlign.center)
                                    ],
                                  ),
                                )
                              : Expanded(
                                  child: GridView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(
                                          left: 0.w, right: 0.w, bottom: 120.h),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisExtent: 270,
                                              mainAxisSpacing: 15.w,
                                              crossAxisSpacing: 15.h,
                                              crossAxisCount: 2),
                                      itemCount: eventTicketController
                                          .savedEventTickets.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            HapticFeedback.selectionClick();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TicketPageDetail(
                                                            ticketData:
                                                                eventTicketController
                                                                        .savedEventTickets[
                                                                    index])));
                                          },
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: Stack(
                                                    children: [
                                                      OctoImage(
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        placeholderBuilder:
                                                            OctoBlurHashFix
                                                                .placeHolder(
                                                                    'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                                                        errorBuilder:
                                                            OctoError.icon(
                                                                color:
                                                                    Colors.red),
                                                        image: CachedNetworkImageProvider(
                                                            eventTicketController
                                                                .savedEventTickets[
                                                                    index]
                                                                .artworkPictureUrl),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      Container(
                                                        height: double.infinity,
                                                        width: double.infinity,
                                                        decoration: const BoxDecoration(
                                                            gradient: LinearGradient(
                                                                begin: Alignment
                                                                    .topCenter,
                                                                end: Alignment
                                                                    .bottomCenter,
                                                                colors: [
                                                              Colors
                                                                  .transparent,
                                                              Colors.black45
                                                            ])),
                                                      ),
                                                      Positioned(
                                                        bottom: 15.h,
                                                        left: 15.w,
                                                        right: 15.w,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            heading(
                                                                text: eventTicketController
                                                                    .savedEventTickets[
                                                                        index]
                                                                    .eventTitle,
                                                                fontSize: 25.sp,
                                                                color: Colors
                                                                    .white),
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
                                      }),
                                )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
