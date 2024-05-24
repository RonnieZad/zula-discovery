import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:octo_image/octo_image.dart';
import 'package:timelines/timelines.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/controllers/ticket_controller.dart';
import 'package:zula/v1/models/ticket_model.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/link_parser.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/app_button.dart';
import 'package:zula/v1/widgets/event_ticket_widget.dart';
import 'package:zula/v1/widgets/image_blur_backdrop.dart';
import 'package:zula/v1/widgets/screen_overlay.dart';
import 'package:zula/v1/widgets/sheets/purchase_ticket_sheet.dart';
import 'package:zula/v1/widgets/sheets/share_sheet.dart';

class TicketPageDetail extends StatefulWidget {
  const TicketPageDetail({super.key, required this.ticketData});
  final Ticket ticketData;

  @override
  State<TicketPageDetail> createState() => _TicketPageDetailState();
}

class _TicketPageDetailState extends State<TicketPageDetail>
    with SingleTickerProviderStateMixin {
  TickerController tickerController = Get.find();
  List<bool> extraInfoState = [false, false];
  PageController galleryPageController = PageController(viewportFraction: 0.9);

  late AnimationController likeAnimationController;

  @override
  void initState() {
    likeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0.0,
            left: 20.w,
            right: 20.w,
            bottom: 0.0,
            child: ListView(
              padding: EdgeInsets.only(top: 70.h),
              shrinkWrap: true,
              children: [
                Hero(
                        tag: widget.ticketData.eventTitle,
                        child: EventTicketWidget(
                          ticketData: widget.ticketData,
                          showTicketDetails: true,
                        ))
                    .animate()
                    .then(delay: 240.ms)
                    .shakeX()
                    .shakeY()
                    .animate(onPlay: (controller) => controller.repeat())
                    .then(delay: 940.ms)
                    .shimmer(
                        delay: 700.ms,
                        duration: 2000.ms,
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.3)),
                10.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    heading(
                        text: 'About',
                        fontSize: 27.sp,
                        color: brandPrimaryColor),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // IconButton(
                        //     onPressed: () {},
                        //     icon: Icon(Icons.threed_rotation,
                        //         color: brandPrimaryColor, size: 30.w)),
                        // IconButton(
                        //     onPressed: () {},
                        //     icon: Icon(LucideIcons.quote,
                        //         color: brandPrimaryColor, size: 30.w)),
                        IconButton(
                                onPressed: () {
                                  likeAnimationController.forward();
                                  HapticFeedback.selectionClick();
                                  tickerController
                                      .favoriteEventTicket(
                                          eventId: widget.ticketData.id)
                                      .then((updatedCountLike) {
                                    likeAnimationController.reset();
                                    if (updatedCountLike != null) {
                                      setState(() {
                                        widget.ticketData.interestedCount =
                                            updatedCountLike;
                                      });
                                    }
                                  });
                                  ;
                                },
                                icon: Icon(LineIcons.heart,
                                    color: brandPrimaryColor, size: 30.w))
                            .animate(
                              autoPlay: false,
                              controller: likeAnimationController,
                              onComplete: (animController) {
                                animController.repeat();
                              },
                            )
                            .scaleXY(begin: 1.0, end: 0.6),
                        IconButton(
                            onPressed: () {
                              ScreenOverlay.showAppSheet(context,
                                  playHomeVideoFrame: false,
                                  sheet: const ShareSheet());
                            },
                            icon: Icon(LineIcons.share,
                                color: brandPrimaryColor, size: 30.w)),
                      ],
                    ),
                  ],
                ),
                10.ph,
                Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.red, size: 30.w),
                    10.pw,
                    label(
                        text:
                            '${widget.ticketData.interestedCount} people like this'),
                  ],
                ),
                15.ph,
                Row(
                  children: [
                    Icon(LucideIcons.building, size: 28.w),
                    10.pw,
                    label(text: widget.ticketData.organiserName),
                  ],
                ),
                20.ph,
                paragraph(text: widget.ticketData.eventDescription),
                20.ph,
                heading(
                    text: 'Gallery', fontSize: 27.sp, color: brandPrimaryColor),
                15.ph,
                SizedBox(
                  height: 410.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: widget.ticketData.ticketEventAlbum.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                            crossAxisCount: 3,
                            mainAxisExtent: 200.h),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              ScreenOverlay.showAppSheet(context,
                                  playHomeVideoFrame: false,
                                  sheet: SizedBox(
                                    height: 760.h,
                                    child: PageView.builder(
                                      controller: galleryPageController,
                                      itemCount: widget
                                          .ticketData.ticketEventAlbum.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w, vertical: 15.h),
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16.r),
                                                child: OctoImage(
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                  placeholderBuilder:
                                                      OctoBlurHashFix.placeHolder(
                                                          'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                                                  errorBuilder: OctoError.icon(
                                                      color: Colors.red),
                                                  image:
                                                      CachedNetworkImageProvider(
                                                    widget
                                                        .ticketData
                                                        .ticketEventAlbum[index]
                                                        .assetUrl,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Positioned(
                                                top: 10.0,
                                                right: 10.0,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                  child: BackdropFilter(
                                                    filter: ImageFilter.blur(
                                                        sigmaX: 40.0,
                                                        sigmaY: 40.0),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 15.w),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                          color:
                                                              Colors.black38),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          paragraph(
                                                              text:
                                                                  '${index + 1} out of ${widget.ticketData.ticketEventAlbum.length}',
                                                              color:
                                                                  Colors.white),
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
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: OctoImage(
                                placeholderBuilder: OctoBlurHashFix.placeHolder(
                                    'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                                errorBuilder: OctoError.icon(color: Colors.red),
                                image: CachedNetworkImageProvider(
                                  widget.ticketData.ticketEventAlbum[index]
                                      .assetUrl,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                20.ph,
                heading(
                    text: 'Itenary', fontSize: 27.sp, color: brandPrimaryColor),
                15.ph,
                paragraph(text: widget.ticketData.meetUpInstructions),
                20.ph,
                Timeline.tileBuilder(
                  clipBehavior: Clip.none,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  builder: TimelineTileBuilder(
                    startConnectorBuilder: (context, index) {
                      return SolidLineConnector(
                        thickness: 5,
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(0.6),
                      );
                    },
                    endConnectorBuilder: (context, index) {
                      return SolidLineConnector(
                        thickness: 5,
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(0.6),
                      );
                    },
                    indicatorBuilder: (context, index) {
                      return Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: brandPrimaryColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            heading(
                                text: 'Day',
                                fontSize: 16.sp,
                                color: Colors.white),
                            paragraph(
                                text: '${index + 1}',
                                fontSize: 16.sp,
                                color: Colors.white)
                          ],
                        ),
                      );
                    },
                    contentsAlign: ContentsAlign.alternating,
                    oppositeContentsBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          captionBold(
                              text:
                                  widget.ticketData.eventItinerary[index].title,
                              fontSize: 17.sp),
                          paragraph(
                              text: widget
                                  .ticketData.eventItinerary[index].description,
                              fontSize: 17.sp),
                          4.ph,
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: OctoImage(
                              width: 90.w,
                              height: 90.w,
                              placeholderBuilder: OctoBlurHashFix.placeHolder(
                                  'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                              errorBuilder: OctoError.icon(color: Colors.red),
                              image: CachedNetworkImageProvider(widget
                                  .ticketData.eventItinerary[index].assetUrl),
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                      ),
                    ),
                    itemCount: widget.ticketData.eventItinerary.length,
                  ),
                ),
                35.ph,
                heading(
                    text: 'Extra Information',
                    fontSize: 27.sp,
                    color: brandPrimaryColor),
                15.ph,
                GestureDetector(
                  onTap: () {
                    setState(() {
                      // extraInfoState = [false, false];
                      extraInfoState[0] = !extraInfoState[0];
                    });
                  },
                  child: AnimatedContainer(
                    margin: EdgeInsets.only(bottom: 10.h),
                    duration: const Duration(milliseconds: 300),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: brandPrimaryColor.withOpacity(0.4)),
                        color: extraInfoState[0]
                            ? brandPrimaryColor.withOpacity(0.2)
                            : brandPrimaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: extraInfoState[0]
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  label(
                                      text: 'Things to do',
                                      color:
                                          brandPrimaryColor.withOpacity(0.8)),
                                  Icon(
                                    LucideIcons.chevronUp,
                                    color: brandPrimaryColor.withOpacity(0.8),
                                  )
                                ],
                              ),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding:
                                      EdgeInsets.only(left: 15.w, top: 10.h),
                                  itemCount:
                                      widget.ticketData.eventActivities.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: paragraph(
                                          fontSize: 19.5.sp,
                                          text:
                                              '- ${widget.ticketData.eventActivities[index].title}'),
                                    );
                                  }),
                              10.ph,
                              label(
                                  text: 'Things to carry',
                                  color: brandPrimaryColor.withOpacity(0.8)),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding:
                                      EdgeInsets.only(left: 15.w, top: 10.h),
                                  itemCount:
                                      widget.ticketData.thingsToCarry.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: paragraph(
                                          fontSize: 19.5.sp,
                                          text:
                                              '- ${widget.ticketData.thingsToCarry[index].title}'),
                                    );
                                  }),
                              10.ph,
                              label(
                                  text: 'What is provided',
                                  color: brandPrimaryColor.withOpacity(0.8)),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding:
                                      EdgeInsets.only(left: 15.w, top: 10.h),
                                  itemCount:
                                      widget.ticketData.whatIsProvided.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: paragraph(
                                          fontSize: 19.5.sp,
                                          text:
                                              '- ${widget.ticketData.whatIsProvided[index].title}'),
                                    );
                                  }),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  label(
                                      text: 'Things to do',
                                      color:
                                          brandPrimaryColor.withOpacity(0.8)),
                                  Icon(
                                    LucideIcons.chevronDown,
                                    color: brandPrimaryColor.withOpacity(0.8),
                                  )
                                ],
                              ),
                            ],
                          ),
                  ),
                ),
                20.ph,
                heading(
                    text: 'Map Location',
                    fontSize: 27.sp,
                    color: brandPrimaryColor),
                15.ph,
                paragraph(
                    text:
                        'Event location is accessbile with ample parking. Make sure to travel early to avoid traffic around this area'),
                15.ph,
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child:  SizedBox(
                    width: double.infinity,
                    height: 360.h,
                    child: FlutterMap(
                      
                      options: MapOptions(
                        onTap: (j,k){
                           HapticFeedback.selectionClick();
                    print('ddd');
                    ScreenOverlay.showAppSheet(
                      context,
                      playHomeVideoFrame: false,
                      sheet: Padding(
                        padding: EdgeInsets.only(
                            bottom: 30.h, left: 10.w, right: 10.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: SizedBox(
                            width: 400.w,
                            height: 710.h,
                            child: FlutterMap(
                              options: MapOptions(
                                  minZoom: 5,
                                  maxZoom: 20,
                                  zoom: 17,
                                  center: LatLng(
                                      widget.ticketData.locationLatCoordinate,
                                      widget
                                          .ticketData.locationLongCoordinate)),
                              children: [
                                TileLayer(
                                  maxNativeZoom: 30,
                                  retinaMode: true,
                                  maxZoom: 30,
                                  tileProvider: NetworkTileProvider(),
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
                                              .ticketData.locationLatCoordinate,
                                          widget.ticketData
                                              .locationLongCoordinate), // Set the marker position
                                      child: GestureDetector(
                                        onTap: () {
                                          ScreenOverlay.showConfirmationDialog(
                                              context,
                                              titleText: 'Open Maps',
                                              description:
                                                  'This will open another applicaiton to navigate to this location',
                                              action: () {
                                            LinkParser
                                                .launchGoolgeMapsNavigation(
                                                    widget.ticketData
                                                        .locationLatCoordinate,
                                                    widget.ticketData
                                                        .locationLongCoordinate);
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: brandPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10.r)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              label(
                                                  text: 'Go to Location',
                                                  color: Colors.white),
                                              10.pw,
                                              Icon(
                                                LucideIcons.locateFixed,
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
                    );
                                       
                                       
                        },
                        interactionOptions: const InteractionOptions(
                            flags: InteractiveFlag.doubleTapZoom),
                        minZoom: 5,
                        maxZoom: 20,
                        initialZoom: 17,
                        initialCenter: LatLng(
                            widget.ticketData.locationLatCoordinate,
                            widget.ticketData.locationLongCoordinate),
                      ),
                      children: [
                        TileLayer(
                          maxNativeZoom: 30,
                          retinaMode: true,
                          maxZoom: 30,
                          tileProvider: NetworkTileProvider(),
                          urlTemplate:
                              'https://api.mapbox.com/styles/v1/ronzad/clglfccmb00ae01qtb0fy495p/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoicm9uemFkIiwiYSI6ImNsZ2wzdDUxNTB5Y3AzaWx2NmMxcWFhdzQifQ.747vVY_HUA_gHolQnWrx3A',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              rotate: false,
                              width: 180.0,
                              height: 50.0,
                              point: LatLng(
                                  widget.ticketData.locationLatCoordinate,
                                  widget.ticketData
                                      .locationLongCoordinate), // Set the marker position
                              child: GestureDetector(
                                onTap: () {
                                  ScreenOverlay.showConfirmationDialog(
                                      context,
                                      titleText: 'Open Maps',
                                      description:
                                          'This will open another applicaiton to navigate to this location',
                                      action: () {
                                    LinkParser.launchGoolgeMapsNavigation(
                                        widget
                                            .ticketData.locationLatCoordinate,
                                        widget.ticketData
                                            .locationLongCoordinate);
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: brandPrimaryColor,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      label(
                                          text: 'Go to Location',
                                          color: Colors.white),
                                      10.pw,
                                      Icon(
                                        LucideIcons.locateFixed,
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
                30.ph,
                AppButton(
                        hasPadding: false,
                        labelText: 'Purchase Ticket',
                        action: () {
                          HapticFeedback.lightImpact();
                          ScreenOverlay.showAppSheet(context,
                              sheet: PurchaseTicketSheet(
                                  ticketData: widget.ticketData));
                        })
                    .animate()
                    .then(delay: 940.ms)
                    .slideY(
                        begin: 0.25,
                        end: 0,
                        delay: 600.ms,
                        duration: 7800.ms,
                        curve: Curves.elasticInOut),
                140.ph
              ],
            ),
          ),
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
    );
  }
}
