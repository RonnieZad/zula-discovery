import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gallery_3d/gallery3d.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:octo_image/octo_image.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/constants/strings.dart';
import 'package:zula/v1/models/location_model.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/link_parser.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/app_background.dart';
import 'package:zula/v1/widgets/image_blur_backdrop.dart';
import 'package:zula/v1/widgets/parallax_widget.dart';
import 'package:zula/v1/widgets/screen_overlay.dart';
import 'package:zula/v1/widgets/sheets/menu_activity_sheet.dart';
import 'package:zula/v1/widgets/sheets/place_review_sheet.dart';
import 'package:zula/v1/widgets/sheets/share_sheet.dart';
import 'package:zula/v1/widgets/sheets/virtual_tour_sheet.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ExploreDetails extends StatefulWidget {
  const ExploreDetails({
    super.key,
    required this.locationDetails,
  });

  final Location locationDetails;

  @override
  State<ExploreDetails> createState() => _ExploreDetailsState();
}

class _ExploreDetailsState extends State<ExploreDetails> {
  int currentIndex = 0;
  double topOne = 0;
  double topTwo = 0;

  late Gallery3DController controller;
  late WebViewController webViewController;
  ScrollController activityScrollController = ScrollController();
  List<bool> extraInfoState = [false, false];

  @override
  void initState() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.locationDetails.virtualTourPreviewUrl));
    controller = Gallery3DController(
        itemCount: widget.locationDetails.locationPicture.length,
        autoLoop: true,
        minScale: 0.84);
    super.initState();
  }

  Widget buildGallery3D() {
    return Gallery3D(
        controller: controller,
        itemConfig:  GalleryItemConfig(
            width: 320,
            height: 460,
            radius: 15.r,
            shadows: [
              const BoxShadow(color: Colors.white, blurRadius: 20, spreadRadius: 8)
            ]),
        width: MediaQuery.of(context).size.width,
        height: 500,
        isClip: false,
        onItemChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        onClickItem: (index) {
          if (kDebugMode) print("currentIndex:$index");
          ScreenOverlay.showAppSheet(context,
              sheet: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: OctoImage(
                  height: 700,
                  width: double.infinity,
                  placeholderBuilder: OctoBlurHashFix.placeHolder(
                      'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                  errorBuilder: OctoError.icon(color: Colors.red),
                  image: CachedNetworkImageProvider(
                    widget.locationDetails.locationPicture[index]
                        .locationPictureUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ));
        },
        itemBuilder: (context, index) {
          return OctoImage(
            placeholderBuilder:
                OctoBlurHashFix.placeHolder('LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
            errorBuilder: OctoError.icon(color: Colors.red),
            image: CachedNetworkImageProvider(
              widget.locationDetails.locationPicture[index].locationPictureUrl,
            ),
            fit: BoxFit.cover,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        onNotification: (notify) {
          if (notify is ScrollUpdateNotification) {
            if (notify.metrics.axisDirection == AxisDirection.down) {
              setState(() {
                topOne += -notify.scrollDelta! / 4;
                topTwo += notify.scrollDelta! / 5;
              });
            }
          }

          return true;
        },
        child: Stack(
          children: [
            const AppBackground(),
            ParallaxWidget(
              top: topOne,
              widget: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Colors.white, Colors.transparent],
                      stops: [0.6, 0.99],
                    ).createShader(
                      Rect.fromLTRB(
                        0,
                        0,
                        bounds.width,
                        bounds.height,
                      ),
                    );
                  },
                  blendMode: BlendMode.dstATop,
                  child: BackgrounBlurView(
                    imageUrl: widget.locationDetails
                        .locationPicture[currentIndex].locationPictureUrl,
                  )),
            ),
            ListView(
              padding: EdgeInsets.only(top: 120.h),
              shrinkWrap: true,
              children: [
                buildGallery3D(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              heading(
                                  text: widget.locationDetails.locationName,
                                  fontSize: 27.sp,
                                  color: brandPrimaryColor),
                              5.ph,
                              paragraph(
                                  text: widget.locationDetails.locationCity,
                                  fontSize: 20.sp,
                                  color: Colors.white),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              heading(
                                  text: widget.locationDetails.locationCategory,
                                  fontSize: 27.sp,
                                  color: brandPrimaryColor),
                              5.ph,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(LucideIcons.star,
                                      color: Colors.yellow, size: 20.w),
                                  2.pw,
                                  Icon(LucideIcons.star,
                                      color: Colors.yellow, size: 20.w),
                                  2.pw,
                                  Icon(LucideIcons.star,
                                      color: Colors.yellow, size: 20.w),
                                  2.pw,
                                  paragraph(
                                      text:
                                          '${widget.locationDetails.locationRating}',
                                      fontSize: 20.sp,
                                      color: brandPrimaryColor),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      20.ph,
                      paragraph(
                          text: widget.locationDetails.locationFullDescription,
                          fontSize: 21.sp,
                          color: brandPrimaryColor),
                      10.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                ScreenOverlay.showAppSheet(context,
                                    sheet: PlaceReviewSheet(
                                      locationReviews:
                                          widget.locationDetails.locationReview,
                                    ));
                              },
                              icon: Icon(LucideIcons.quote,
                                  color: brandPrimaryColor, size: 30.w)),
                          IconButton(
                              onPressed: () {
                                ScreenOverlay.showConfirmationDialog(context,
                                    title: 'Open Maps',
                                    description:
                                        'This will open another applciaiton to show your map location',
                                    action: () {
                                  LinkParser.launchGoolgeMapsNavigation(
                                      widget.locationDetails
                                          .locationLatCoordinate,
                                      widget.locationDetails
                                          .locationLongCoordinate);
                                });
                              },
                              icon: Icon(LineIcons.alternateMapMarked,
                                  color: brandPrimaryColor, size: 30.w)),
                          IconButton(
                              onPressed: () {
                                ScreenOverlay.showAppSheet(context,
                                    sheet: MenuActivitySheet(
                                        locationMenuActivity: widget
                                            .locationDetails
                                            .locationMenuActivity));
                              },
                              icon: Icon(Icons.restaurant_menu,
                                  color: brandPrimaryColor, size: 30.w)),
                          IconButton(
                              onPressed: () {
                                ScreenOverlay.showAppSheet(context,
                                    sheet: VirtualTourSheet(
                                        webViewController: webViewController));
                              },
                              icon: Icon(Icons.threed_rotation,
                                  color: brandPrimaryColor, size: 30.w)),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(LineIcons.heart,
                                  color: brandPrimaryColor, size: 30.w)),
                          IconButton(
                              onPressed: () {
                                ScreenOverlay.showAppSheet(context,
                                    sheet: ShareSheet());
                              },
                              icon: Icon(LineIcons.share,
                                  color: brandPrimaryColor, size: 30.w)),
                        ],
                      ),
                      20.ph,
                      heading(
                          text: 'Activites',
                          fontSize: 27.sp,
                          color: brandPrimaryColor),
                      15.ph,
                      SizedBox(
                        height: 240.h,
                        child: ListView.builder(
                            controller: activityScrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                widget.locationDetails.locationActivity.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  ScreenOverlay.showAppSheet(context,
                                      sheet: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: OctoImage(
                                          height: 700,
                                          width: double.infinity,
                                          placeholderBuilder:
                                              OctoBlurHashFix.placeHolder(
                                                  'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                                          errorBuilder:
                                              OctoError.icon(color: Colors.red),
                                          image: CachedNetworkImageProvider(
                                            widget
                                                .locationDetails
                                                .locationActivity[index]
                                                .locationActivityPictureUrl,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: OctoImage(
                                          height: 200.h,
                                          width: 200.w,
                                          placeholderBuilder:
                                              OctoBlurHashFix.placeHolder(
                                                  'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                                          errorBuilder:
                                              OctoError.icon(color: Colors.red),
                                          image: CachedNetworkImageProvider(
                                            widget
                                                .locationDetails
                                                .locationActivity[index]
                                                .locationActivityPictureUrl,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      10.ph,
                                      paragraph(
                                          text: widget
                                              .locationDetails
                                              .locationActivity[index]
                                              .locationActivityName,
                                          fontSize: 20.sp,
                                          color: brandPrimaryColor),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      20.ph,
                      heading(
                          text: 'What to expect',
                          fontSize: 27.sp,
                          color: brandPrimaryColor),
                      35.ph,
                      GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              widget.locationDetails.locationAmenity.length,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 10.0,
                                  crossAxisSpacing: 10.0,
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) => Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(placeAmenities[index]['icon'],
                                      color: brandPrimaryColor, size: 30.w),
                                  10.ph,
                                  paragraph(
                                      text: widget
                                          .locationDetails
                                          .locationAmenity[index]
                                          .locationAmenityName,
                                      fontSize: 20.sp,
                                      color: brandPrimaryColor.withOpacity(0.8),
                                      textAlign: TextAlign.center)
                                ],
                              )),
                      
                      heading(
                          text: 'Extra Information',
                          fontSize: 27.sp,
                          color: brandPrimaryColor),
                      35.ph,
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: extraInfoState.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                extraInfoState = [false, false, false];
                                extraInfoState[index] = true;
                              });
                            },
                            child: AnimatedContainer(
                              margin: EdgeInsets.only(bottom: 10.h),
                              duration: const Duration(milliseconds: 300),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 15.h),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          brandPrimaryColor.withOpacity(0.4)),
                                  color: extraInfoState[index]
                                      ? brandPrimaryColor.withOpacity(0.2)
                                      : brandPrimaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: extraInfoState[index]
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        paragraph(
                                            text:
                                                'Opens at ${widget.locationDetails.locationExtraInfo.openingTime}',
                                            fontSize: 20.sp,
                                            color: brandPrimaryColor
                                                .withOpacity(0.8)),
                                        10.ph,
                                        paragraph(
                                            text:
                                                'Closes at ${widget.locationDetails.locationExtraInfo.closingTime}',
                                            fontSize: 20.sp,
                                            color: brandPrimaryColor
                                                .withOpacity(0.8)),
                                        10.ph,
                                        paragraph(
                                            text: widget.locationDetails
                                                .locationExtraInfo.description,
                                            fontSize: 20.sp,
                                            color: brandPrimaryColor
                                                .withOpacity(0.8)),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            paragraph(
                                                text:
                                                    'Opens at ${widget.locationDetails.locationExtraInfo.openingTime}',
                                                fontSize: 20.sp,
                                                color: brandPrimaryColor
                                                    .withOpacity(0.8)),
                                            Icon(
                                              LucideIcons.chevronDown,
                                              color: brandPrimaryColor
                                                  .withOpacity(0.8),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                            ),
                          );
                        },
                      ),
                      100.ph,
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: topOne != 0 ? 54.h : 60.h,
              left: topOne != 0 ? 16.w : 20.w,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: topOne != 0
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration:
                                const BoxDecoration(color: Colors.white38),
                            child: Row(
                              children: [
                                Icon(CupertinoIcons.arrow_left,
                                    color: brandPrimaryColor.withOpacity(0.8),
                                    size: 30.w),
                                20.pw,
                                heading(
                                    text: 'Back',
                                    fontSize: 30.sp,
                                    color: brandPrimaryColor.withOpacity(0.8)),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          Icon(CupertinoIcons.arrow_left,
                              color: brandPrimaryColor.withOpacity(0.8),
                              size: 30.w),
                          20.pw,
                          heading(
                              text: 'Back',
                              fontSize: 30.sp,
                              color: brandPrimaryColor.withOpacity(0.8)),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
