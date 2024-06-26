import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gallery_3d/gallery3d.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:octo_image/octo_image.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/constants/strings.dart';
import 'package:zula/v1/controllers/location_controller.dart';
import 'package:zula/v1/models/location_model.dart';
import 'package:zula/v1/screens/context_ai.dart';
import 'package:zula/v1/screens/ticket_page_detail.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/link_parser.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/app_button.dart';
import 'package:zula/v1/widgets/image_blur_backdrop.dart';
import 'package:zula/v1/widgets/parallax_widget.dart';
import 'package:zula/v1/widgets/screen_overlay.dart';
import 'package:zula/v1/widgets/sheets/menu_activity_sheet.dart';
import 'package:zula/v1/widgets/sheets/place_review_sheet.dart';
import 'package:zula/v1/widgets/sheets/share_sheet.dart';
import 'package:zula/v1/widgets/sheets/virtual_tour_sheet.dart';

class ExploreDetails extends StatefulWidget {
  const ExploreDetails({
    super.key,
    required this.locationDetails,
  });

  final Location locationDetails;

  @override
  State<ExploreDetails> createState() => _ExploreDetailsState();
}

class _ExploreDetailsState extends State<ExploreDetails>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  double topOne = 0;
  double topTwo = 0;

  LocationController locationController = Get.find();

  late Gallery3DController controller;

  ScrollController activityScrollController = ScrollController();
  List<bool> extraInfoState = [false];

  MapController controllerz = MapController();
  PageController galleryPageController = PageController(viewportFraction: 0.9);
  late AnimationController likeAnimationController;
  final DatePickerController dateController = DatePickerController();
  final ScrollController _scrollController = ScrollController();
  bool _showAppBar = false;
  @override
  void initState() {
    likeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _scrollController.addListener(() {
      double currentOffset = _scrollController.offset;

      if (currentOffset > 600) {
        // User is scrolling down
        setState(() {
          _showAppBar = true;
        });
      } else if (currentOffset < 600) {
        // User is scrolling up
        setState(() {
          _showAppBar = false;
        });
      }
    });

    controller = Gallery3DController(
        itemCount: widget.locationDetails.locationPicture.length,
        autoLoop: true,
        minScale: 0.84);
    super.initState();
  }

  Widget buildGallery3D() {
    return Gallery3D(
        controller: controller,
        itemConfig: GalleryItemConfig(
            width: 380.w,
            height: 600,
            radius: 15.r,
            shadows: [
              BoxShadow(
                  color: brandPrimaryColor.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 3)
            ]),
        width: MediaQuery.of(context).size.width,
        height: 600.h,
        isClip: false,
        onClickItem: (currentIndex) {
          ScreenOverlay.showAppSheet(context,
              playHomeVideoFrame: false,
              sheet: SizedBox(
                height: 760.h,
                child: PageView.builder(
                  controller: galleryPageController,
                  itemCount: widget.locationDetails.locationPicture.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 15.h),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: OctoImage(
                              width: double.infinity,
                              height: double.infinity,
                              placeholderBuilder: OctoBlurHashFix.placeHolder(
                                  'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                              errorBuilder: OctoError.icon(color: Colors.red),
                              image: CachedNetworkImageProvider(
                                widget.locationDetails.locationPicture[index]
                                    .locationPictureUrl,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 10.0,
                            right: 10.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 40.0, sigmaY: 40.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 15.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: Colors.black38),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      paragraph(
                                          text:
                                              '${index + 1} out of ${widget.locationDetails.locationPicture.length}',
                                          color: Colors.white),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ));
        },
        itemBuilder: (context, index) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              OctoImage(
                width: 420.w,
                height: 600.h,
                placeholderBuilder:
                    OctoBlurHashFix.placeHolder('LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                errorBuilder: OctoError.icon(color: Colors.red),
                image: CachedNetworkImageProvider(
                  widget.locationDetails.locationPicture[index]
                      .locationPictureUrl,
                ),
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 10.0,
                right: 10.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.black38),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          paragraph(
                              text:
                                  '${index + 1} out of ${widget.locationDetails.locationPicture.length}',
                              color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // add setCurrentScreeninstead of initState because might not always give you the
    // expected results because initState() is called before the widget
    // is fully initialized, so the screen might not be visible yet.
    FirebaseAnalytics.instance
        .logScreenView(screenName: "LocationDetailScreen");
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
            CustomScrollView(
                shrinkWrap: true,
                controller: _scrollController,
                slivers: [
               if(_showAppBar)...[
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverAppBarDelegate(
                        minHeight: Platform.isAndroid ? 100.h : 120.h,
                        maxHeight: Platform.isAndroid ? 110.h : 140.h,
                        showAppBar: _showAppBar,
                        child: AppBar(
                          
                          backgroundColor: Colors.white,
                          surfaceTintColor: brandPrimaryColor.withOpacity(0.2),
                          automaticallyImplyLeading: false,
                          centerTitle: false,
                          title: title(
                            text: widget.locationDetails.locationName,
                            fontSize: 30.sp,
                            color: brandPrimaryColor,
                          ),
                          actions: [
                            GestureDetector(
                              onTap: () {
                                ScreenOverlay.showAppSheet(context,
                                    playHomeVideoFrame: false,
                                    sheet: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 25.w),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          title(
                                              text: 'Check Availabilty',
                                              fontSize: 46.sp,
                                              color: brandPrimaryColor,
                                              textAlign: TextAlign.center),
                                          30.ph,
                                          paragraph(
                                              text:
                                                  'What date spot would you like to check'),
                                          20.ph,
                                          SizedBox(
                                              height: 200.h,
                                              child: CupertinoDatePicker(
                                                  initialDateTime: DateTime(
                                                      DateTime.now().year,
                                                      DateTime.now().month,
                                                      DateTime.now().day,
                                                      DateTime.now().hour,
                                                      (DateTime.now().minute %
                                                              60 *
                                                              60)
                                                          .toInt()),
                                                  minuteInterval: 60,
                                                  onDateTimeChanged: (newDate) {
                                                    locationController
                                                            .availabilityDateToCheck =
                                                        newDate.toString();
                                                  })),
                                          15.ph,
                                          Row(
                                            children: [
                                              heading(
                                                  text: 'Number of Travellers'),
                                              const Spacer(),
                                              Obx(() {
                                                return heading(
                                                  text:
                                                      '${locationController.numberOfGuests}',
                                                );
                                              }),
                                              15.pw,
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      locationController
                                                          .incrementNumberOfTravellers();
                                                    },
                                                    child: Container(
                                                      width: 59.w,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              brandPrimaryColor
                                                                  .withOpacity(
                                                                      0.4),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.r)),
                                                      child: const Icon(
                                                          LucideIcons.chevronUp,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  5.ph,
                                                  GestureDetector(
                                                    onTap: () {
                                                      locationController
                                                          .decrementNumberOfTravellers();
                                                    },
                                                    child: Container(
                                                      width: 59.w,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              brandPrimaryColor
                                                                  .withOpacity(
                                                                      0.4),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.r)),
                                                      child: const Icon(
                                                          LucideIcons
                                                              .chevronDown,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          30.ph,
                                          AppTextBox(
                                              maxLines: 2,
                                              hintText:
                                                  'Enter optional message or inquiry',
                                              textEditingController:
                                                  locationController
                                                      .locationCheckAvailabiltyTextController),
                                          30.ph,
                                          AppButton(
                                              hasPadding: false,
                                              labelText: 'Submit Now',
                                              action: () {}),
                                          30.ph
                                        ],
                                      ),
                                    ));
                                FirebaseAnalytics.instance
                                    .logEvent(name: 'LocationCheckAvailabilty');
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 20.w),
                                decoration: BoxDecoration(
                                  color: brandPrimaryColor.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(50.r),
                                  border: Border.all(
                                      color: brandPrimaryColor.withOpacity(0.4),
                                      width: 0.6),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.white38,
                                        blurRadius: 20.0,
                                        spreadRadius: 1)
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.r),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 30.0, sigmaY: 30.0),
                                    child: Container(
                                        padding: EdgeInsets.all(10.w),
                                        decoration: const BoxDecoration(
                                            color: Colors.white60),
                                        child:
                                            label(text: 'Check Availabilty')),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
               ],
               
                  SliverList(
                      delegate: SliverChildListDelegate(
                    [
                    90.ph,
                      buildGallery3D(),
                      35.ph,
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
                                        text:
                                            widget.locationDetails.locationName,
                                        fontSize: 27.sp,
                                        color: brandPrimaryColor),
                                    5.ph,
                                    paragraph(
                                        text:
                                            widget.locationDetails.locationCity,
                                        fontSize: 20.sp,
                                        color: brandPrimaryColor),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    heading(
                                        text: widget
                                            .locationDetails.locationCategory,
                                        fontSize: 27.sp,
                                        color: brandPrimaryColor),
                                    5.ph,
                                    Row(
                                      children: [
                                        paragraph(
                                            text:
                                                '${widget.locationDetails.locationRating}',
                                            fontSize: 20.sp,
                                            color: brandPrimaryColor),
                                        5.pw,
                                        Icon(
                                          Icons.star,
                                          size: 25.w,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            20.ph,
                            paragraph(
                                text: widget
                                    .locationDetails.locationFullDescription,
                                fontSize: 21.sp,
                                color: brandPrimaryColor),
                            10.ph,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  tooltip: 'AI',
                                    onPressed: () {
                                      ScreenOverlay.showAppSheet(context,
                                          playHomeVideoFrame: false,
                                          sheet: const ContextAi());
                                    },
                                    icon: Icon(CupertinoIcons.sparkles,
                                        color: brandPrimaryColor, size: 30.w)),
                                IconButton(
                                  tooltip: 'Vitual Walkthrough',
                                    onPressed: () {
                                      ScreenOverlay.showAppSheet(context,
                                          playHomeVideoFrame: false,
                                          sheet: VirtualTourSheet(
                                              virtualTourPreviewUrl: widget
                                                  .locationDetails
                                                  .virtualTourPreviewUrl));
                                    },
                                    icon: Icon(Icons.threed_rotation,
                                        color: brandPrimaryColor, size: 30.w)),
                                IconButton(
                                  tooltip: 'Reviews',
                                    onPressed: () {
                                      ScreenOverlay.showAppSheet(context,
                                          playHomeVideoFrame: false,
                                          sheet: PlaceReviewSheet(
                                            locationReviews: widget
                                                .locationDetails.locationReview,
                                          ));
                                    },
                                    icon: Icon(LucideIcons.quote,
                                        color: brandPrimaryColor, size: 30.w)),
                                IconButton(
                                  tooltip: 'Map Location',
                                    onPressed: () {
                                      ScreenOverlay.showAppSheet(
                                        context,
                                        playHomeVideoFrame: false,
                                        sheet: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 30.h,
                                              left: 10.w,
                                              right: 10.w),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15.r),
                                                border: Border.all(
                                                    color: Colors.black26,
                                                    width: 0.6)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                              child: SizedBox(
                                                width: 400.w,
                                                height: 730.h,
                                                child: FlutterMap(
                                                  options: MapOptions(
                                                      minZoom: 5,
                                                      maxZoom: 20,
                                                      zoom: 17,
                                                      center: LatLng(
                                                          widget.locationDetails
                                                              .locationLatCoordinate,
                                                          widget.locationDetails
                                                              .locationLongCoordinate)),
                                                  children: [
                                                    TileLayer(
                                                      maxNativeZoom: 30,
                                                      retinaMode: true,
                                                      maxZoom: 30,
                                                      tileProvider:
                                                          NetworkTileProvider(),
                                                      urlTemplate:
                                                          'https://api.mapbox.com/styles/v1/ronzad/clglfccmb00ae01qtb0fy495p/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoicm9uemFkIiwiYSI6ImNsZ2wzdDUxNTB5Y3AzaWx2NmMxcWFhdzQifQ.747vVY_HUA_gHolQnWrx3A',
                                                    ),
                                                    MarkerLayer(
                                                      markers: [
                                                        Marker(
                                                          width: 180.0,
                                                          height: 50.0,
                                                          point: LatLng(
                                                              widget
                                                                  .locationDetails
                                                                  .locationLatCoordinate,
                                                              widget
                                                                  .locationDetails
                                                                  .locationLongCoordinate), // Set the marker position
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              ScreenOverlay.showConfirmationDialog(
                                                                  context,
                                                                  titleText:
                                                                      'Open Maps',
                                                                  description:
                                                                      'This will open another applicaiton to navigate to this location',
                                                                  action: () {
                                                                LinkParser.launchGoolgeMapsNavigation(
                                                                    widget
                                                                        .locationDetails
                                                                        .locationLatCoordinate,
                                                                    widget
                                                                        .locationDetails
                                                                        .locationLongCoordinate);
                                                              });
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      brandPrimaryColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.r)),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  label(
                                                                      text:
                                                                          'Go to Location',
                                                                      color: Colors
                                                                          .white),
                                                                  10.pw,
                                                                  Icon(
                                                                    LucideIcons
                                                                        .locateFixed,
                                                                    color: Colors
                                                                        .white, // Customize the marker color
                                                                    size: 30.w,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(LineIcons.map,
                                        color: brandPrimaryColor, size: 30.w)),
                                IconButton(
                                  tooltip: 'Activity Listing',
                                    onPressed: () {
                                      ScreenOverlay.showAppSheet(context,
                                          playHomeVideoFrame: false,
                                          sheet: MenuActivitySheet(
                                              locationMenuActivity: widget
                                                  .locationDetails
                                                  .locationMenuActivity));
                                    },
                                    icon: Icon(Icons.restaurant,
                                        color: brandPrimaryColor, size: 30.w)),
                                IconButton(
                                  tooltip: 'Share',
                                    onPressed: () {
                                      ScreenOverlay.showAppSheet(context,
                                          playHomeVideoFrame: false,
                                          sheet: ShareSheet(
                                            imagePath: widget
                                                .locationDetails
                                                .locationPicture
                                                .first
                                                .locationPictureUrl,
                                            postTitle: widget
                                                .locationDetails.locationName,
                                            postDescription: widget
                                                .locationDetails
                                                .locationDescription,
                                          ));
                                    },
                                    icon: Icon(LineIcons.share,
                                        color: brandPrimaryColor, size: 30.w)),
                                GestureDetector(
                                  
                                  onTap: () {
                                    HapticFeedback.selectionClick();
                                    likeAnimationController.forward();

                                    locationController
                                        .favoriteLocation(
                                            locationId:
                                                widget.locationDetails.id)
                                        .then((updatedCountLike) {
                                      HapticFeedback.selectionClick();
                                      likeAnimationController.reset();
                                      if (updatedCountLike != null) {
                                        setState(() {
                                          widget.locationDetails.likeCount =
                                              updatedCountLike;
                                        });
                                      }
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 4),
                                    decoration: BoxDecoration(
                                        color: Colors.red[300],
                                        border: Border.all(
                                            width: 0.6, color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(LineIcons.heart,
                                                color: Colors.white, size: 24.w)
                                            .animate(
                                              autoPlay: false,
                                              controller:
                                                  likeAnimationController,
                                              onComplete: (animController) {
                                                animController.repeat();
                                              },
                                            )
                                            .scaleXY(begin: 1.0, end: 0.6),
                                        paragraph(
                                            text:
                                                '${widget.locationDetails.likeCount}',
                                            fontSize: 22.sp,
                                            color: Colors.white),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            20.ph,
                            heading(
                                text: 'Activites',
                                fontSize: 27.sp,
                                color: brandPrimaryColor),
                            15.ph,
                            SizedBox(
                              height: 245.h,
                              child: ListView.builder(
                                  controller: activityScrollController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget
                                      .locationDetails.locationActivity.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        ScreenOverlay.showAppSheet(context,
                                            playHomeVideoFrame: false,
                                            sheet: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 30.h,
                                                  bottom: 30.h,
                                                  left: 10.w,
                                                  right: 10.w),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    child: OctoImage(
                                                      height: 690.h,
                                                      width: double.infinity,
                                                      placeholderBuilder:
                                                          OctoBlurHashFix
                                                              .placeHolder(
                                                                  'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                                                      errorBuilder:
                                                          OctoError.icon(
                                                              color:
                                                                  Colors.red),
                                                      image:
                                                          CachedNetworkImageProvider(
                                                        widget
                                                            .locationDetails
                                                            .locationActivity[
                                                                index]
                                                            .locationActivityPictureUrl,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  10.ph,
                                                  heading(
                                                      text: widget
                                                          .locationDetails
                                                          .locationActivity[
                                                              index]
                                                          .locationActivityName)
                                                ],
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
                                                width: 140.w,
                                                placeholderBuilder:
                                                    OctoBlurHashFix.placeHolder(
                                                        'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                                                errorBuilder: OctoError.icon(
                                                    color: Colors.red),
                                                image:
                                                    CachedNetworkImageProvider(
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
                                itemCount: widget
                                    .locationDetails.locationAmenity.length,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 10.0,
                                  crossAxisSpacing: 10.0,
                                  crossAxisCount: 3,
                                ),
                                itemBuilder: (context, index) => Column(
                                      children: [
                                        Icon(placeAmenities[index]['icon'],
                                            color: brandPrimaryColor,
                                            size: 30.w),
                                        10.ph,
                                        paragraph(
                                            text: widget
                                                .locationDetails
                                                .locationAmenity[index]
                                                .locationAmenityName,
                                            fontSize: 20.sp,
                                            color: brandPrimaryColor
                                                .withOpacity(0.8),
                                            textAlign: TextAlign.center)
                                      ],
                                    )),
                            heading(
                                text: 'Extra Information',
                                fontSize: 27.sp,
                                color: brandPrimaryColor),
                            35.ph,
                            GestureDetector(
                              onTap: () {
                                HapticFeedback.selectionClick();
                                setState(() {
                                  extraInfoState[0] = !extraInfoState[0];
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
                                        width: 0.6, color: Colors.black26),
                                    color: extraInfoState[0]
                                        ? brandPrimaryColor.withOpacity(0.2)
                                        : brandPrimaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: extraInfoState[0]
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
                                              text: widget
                                                  .locationDetails
                                                  .locationExtraInfo
                                                  .description,
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
                            ),
                            120.ph,
                          ],
                        ),
                      ),
                      40.ph
                    ]
                        .animate(interval: 250.ms)
                        .blurXY(duration: 900.ms, begin: 1, end: 0)
                        .slideY(
                            duration: 550.ms,
                            begin: 0.01,
                            end: 0.0,
                            curve: Curves.decelerate)
                        .fade(duration: 500.ms),
                  ))
                ]),
            Positioned(
              bottom: 30.h,
              left: 120.0,
              right: 120.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  HapticFeedback.selectionClick();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60.r),
                    border: Border.all(color: Colors.white60, width: 0.8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60.r),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60.r),
                            color: Colors.black38),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            paragraph(text: 'Close', color: Colors.white),
                            10.pw,
                            const Icon(
                              CupertinoIcons.multiply,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
