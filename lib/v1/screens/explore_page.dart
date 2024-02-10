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
import 'package:vybe/v1/constants/strings.dart';
import 'package:vybe/v1/screens/dicover_page.dart';
import 'package:vybe/v1/utils/extensions.dart';
import 'package:vybe/v1/utils/typography.dart';
import 'package:vybe/v1/widgets/app_background.dart';
import 'package:vybe/v1/widgets/image_blur_backdrop.dart';
import 'package:vybe/v1/widgets/parallax_widget.dart';
import 'package:vybe/v1/widgets/screen_overlay.dart';
import 'package:vybe/v1/widgets/sheets/menu_activity_sheet.dart';
import 'package:vybe/v1/widgets/sheets/place_review_sheet.dart';
import 'package:vybe/v1/widgets/sheets/share_sheet.dart';
import 'package:vybe/v1/widgets/sheets/virtual_tour_sheet.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ExploreDetails extends StatefulWidget {
  const ExploreDetails({super.key});

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
      ..loadRequest(Uri.parse(
          'https://kuula.co/share/collection/7XRsg?logo=1&info=1&fs=1&vr=0&sd=1&thumbs=1'));
    controller = Gallery3DController(
        itemCount: imageUrlList.length,
        autoLoop: true,
        ellipseHeight: 0,
        minScale: 0.4);
    super.initState();
  }

  Widget buildGallery3D() {
    return Gallery3D(
        controller: controller,
        // padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        itemConfig: const GalleryItemConfig(
            width: 320,
            height: 460,
            radius: 10,
            isShowTransformMask: true,
            shadows: [
              BoxShadow(
                  color: Color(0x90000000), offset: Offset(2, 0), blurRadius: 5)
            ]),
        width: MediaQuery.of(context).size.width,
        height: 500,
        isClip: true,

        // currentIndex: currentIndex,
        onItemChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        onClickItem: (index) {
          if (kDebugMode) print("currentIndex:$index");
        },
        itemBuilder: (context, index) {
          return OctoImage(
            placeholderBuilder:
                OctoBlurHashFix.placeHolder('LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
            errorBuilder: OctoError.icon(color: Colors.red),
            image: CachedNetworkImageProvider(
              imageUrlList[index],
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
          print(topOne);
          return true;
        },
        child: Stack(
          children: [
         const AppBackground(),
            ParallaxWidget(
              top: topOne,
              widget: BackgrounBlurView(
                imageUrl: imageUrlList[currentIndex],
              ),
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
                                  text: 'Ciroc Brunch',
                                  fontSize: 27.sp,
                                  color: Colors.white),
                              5.ph,
                              paragraph(
                                  text: 'Kampala, Uganda',
                                  fontSize: 20.sp,
                                  color: Colors.grey),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              heading(
                                  text: 'Bar & Restarant',
                                  fontSize: 27.sp,
                                  color: Colors.white),
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
                                      text: '3.0',
                                      fontSize: 20.sp,
                                      color: Colors.white),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      20.ph,
                      paragraph(
                          text:
                              'Soft ambiance and wow factor, serene beauty perfect for outdoor experiences',
                          fontSize: 19.sp,
                          color: Colors.white),
                      10.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                ScreenOverlay.showAppSheet(context,
                                    sheet: PlaceReviewSheet());
                              },
                              icon: Icon(LucideIcons.quote,
                                  color: Colors.white, size: 30.w)),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(LineIcons.alternateMapMarked,
                                  color: Colors.white, size: 30.w)),
                          IconButton(
                              onPressed: () {
                                ScreenOverlay.showAppSheet(context,
                                    sheet: MenuActivitySheet(
                                        menuItems: menuItems));
                              },
                              icon: Icon(Icons.restaurant_menu,
                                  color: Colors.white, size: 30.w)),
                          IconButton(
                              onPressed: () {
                                ScreenOverlay.showAppSheet(context,
                                    sheet: VirtualTourSheet(
                                        webViewController: webViewController));
                              },
                              icon: Icon(Icons.threed_rotation,
                                  color: Colors.white, size: 30.w)),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(LineIcons.heart,
                                  color: Colors.white, size: 30.w)),
                          IconButton(
                              onPressed: () {
                                ScreenOverlay.showAppSheet(context,
                                    sheet: ShareSheet());
                              },
                              icon: Icon(LineIcons.share,
                                  color: Colors.white, size: 30.w)),
                        ],
                      ),
                      20.ph,
                      heading(
                          text: 'Activites',
                          fontSize: 27.sp,
                          color: Colors.white),
                      15.ph,
                      SizedBox(
                        height: 240.h,
                        child: ListView.builder(
                            controller: activityScrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: OctoImage(
                                        height: 200.h,
                                        width: 200.w,
                                        placeholderBuilder:
                                            OctoBlurHashFix.placeHolder(
                                                'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                                        errorBuilder:
                                            OctoError.icon(color: Colors.red),
                                        image: CachedNetworkImageProvider(
                                          imageUrlList[index],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    10.ph,
                                    paragraph(
                                        text: 'Camping',
                                        fontSize: 20.sp,
                                        color: Colors.white),
                                  ],
                                ),
                              );
                            }),
                      ),
                      20.ph,
                      heading(
                          text: 'What to expect',
                          fontSize: 27.sp,
                          color: Colors.white),
                      35.ph,
                      GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: placeAmenities.length,
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
                                      color: Colors.white, size: 30.w),
                                  10.ph,
                                  paragraph(
                                      text: placeAmenities[index]['label'],
                                      fontSize: 20.sp,
                                      color: Colors.white54,
                                      textAlign: TextAlign.center)
                                ],
                              )),
                      20.ph,
                      heading(
                          text: 'Extra Information',
                          fontSize: 27.sp,
                          color: Colors.white),
                      15.ph,
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 15.h),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Row(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              paragraph(
                                  text: 'Open 24/7, Everyday',
                                  fontSize: 20.sp,
                                  color: Colors.white54),
                              10.ph,
                              paragraph(
                                  text: 'Closes at 10:00 PM',
                                  fontSize: 20.sp,
                                  color: Colors.white54),
                              10.ph,
                              paragraph(
                                  text:
                                      'High traffic during holidays and weekends',
                                  fontSize: 20.sp,
                                  color: Colors.white54),
                              15.ph,
                              Row(
                                children: [
                                  FilledButton.tonalIcon(
                                      onPressed: () {},
                                      icon: const Icon(LucideIcons.search),
                                      label: label(
                                          text: 'Search Offers',
                                          color: Colors.black)),
                                ],
                              ),
                            ],
                          ),
                          
                        ]),
                      ),
                       20.ph,
                      heading(
                          text: 'What is the neigbhourhood',
                          fontSize: 27.sp,
                          color: Colors.white),
                      15.ph,
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 15.h),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Row(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              paragraph(
                                  text: 'Open 24/7, Everyday',
                                  fontSize: 20.sp,
                                  color: Colors.white54),
                              10.ph,
                              paragraph(
                                  text: 'Closes at 10:00 PM',
                                  fontSize: 20.sp,
                                  color: Colors.white54),
                              10.ph,
                              paragraph(
                                  text:
                                      'High traffic during holidays and weekends',
                                  fontSize: 20.sp,
                                  color: Colors.white54),
                              15.ph,
                              Row(
                                children: [
                                  FilledButton.tonalIcon(
                                      onPressed: () {},
                                      icon: const Icon(LucideIcons.search),
                                      label: label(
                                          text: 'Search Offers',
                                          color: Colors.black)),
                                ],
                              ),
                            ],
                          ),
                          
                        ]),
                      ),
                     
                     
                     
                      100.ph,
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: topOne != 0 ? 54.h:60.h,
              left:topOne != 0 ? 16.w: 20.w,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: topOne != 0 ? ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        
                        color: Colors.black26
                      ),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.arrow_left,
                              color: Colors.white, size: 30.w),
                          20.pw,
                          heading(text: 'Back', fontSize: 30.sp, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ): Row(
                        children: [
                          Icon(CupertinoIcons.arrow_left,
                              color: Colors.white, size: 30.w),
                          20.pw,
                          heading(text: 'Back', fontSize: 30.sp, color: Colors.white),
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
