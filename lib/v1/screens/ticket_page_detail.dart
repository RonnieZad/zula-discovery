import 'dart:ui';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:octo_image/octo_image.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:zula/v1/controllers/ticket_controller.dart';
import 'package:zula/v1/models/ticket_model.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';

import 'package:zula/v1/widgets/image_blur_backdrop.dart';
import 'package:zula/v1/widgets/screen_overlay.dart';

class TicketPageDetail extends StatefulWidget {
  const TicketPageDetail({super.key, required this.ticketData});
  final Ticket ticketData;

  @override
  State<TicketPageDetail> createState() => _TicketPageDetailState();
}

class _TicketPageDetailState extends State<TicketPageDetail> {
  TickerController tickerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 60.h, left: 20.w, right: 20.w),
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: Stack(
                children: [
                  TicketWidget(
                    color: Colors.black,
                    isCornerRounded: true,
                    width: double.infinity,
                    height: 740.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: Stack(
                        children: [
                          SizedBox(
                              height: 440.h,
                              width: double.infinity,
                              child: OctoImage(
                                placeholderBuilder: OctoBlurHashFix.placeHolder(
                                    'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                                errorBuilder: OctoError.icon(color: Colors.red),
                                image: CachedNetworkImageProvider(
                                  widget.ticketData.artworkPictureUrl,
                                ),
                                fit: BoxFit.cover,
                              )),
                          Positioned(
                            bottom: 0.0,
                            left: 20.w,
                            right: 20.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                heading(
                                  text: widget.ticketData.eventTitle,
                                  color: Colors.white,
                                ),
                                10.ph,
                                Row(
                                  children: [
                                    Icon(
                                      LucideIcons.locate,
                                      size: 20.w,
                                      color: Colors.white60,
                                    ),
                                    10.pw,
                                    paragraph(
                                      text: widget.ticketData.eventLocation,
                                      color: Colors.white60,
                                    ),
                                  ],
                                ),
                                10.ph,
                                Row(
                                  children: [
                                    Icon(
                                      LucideIcons.calendar,
                                      size: 20.w,
                                      color: Colors.white60,
                                    ),
                                    10.pw,
                                    paragraph(
                                      text: widget.ticketData.eventDate,
                                      color: Colors.white60,
                                    ),
                                  ],
                                ),
                                10.ph,
                                paragraph(
                                    text:
                                        'From USh ${widget.ticketData.ticketCategory[0].ticketPrice}',
                                    color: Colors.white,
                                    fontSize: 25.sp),
                                15.ph,
                                BarcodeWidget(
                                  drawText: false,
                                  height: 85.h,
                                  color: Colors.white60,
                                  barcode: Barcode.code128(),
                                  data: 'VIP PASS',
                                ),
                                15.ph,
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: 20.h,
                      right: 20.w,
                      child: GestureDetector(
                        onTap: () {
                          ScreenOverlay.showAppSheet(context, sheet: Obx(() {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  heading(
                                      text: 'Choose your Tickets',
                                      color: Colors.white),
                                  20.ph,
                                  paragraph(
                                      text:
                                          'Select which ticket types you wish to purchase below.',
                                      color: Colors.white54),
                                  30.ph,
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemCount:
                                        widget.ticketData.ticketCategory.length,
                                    itemBuilder: (contex, index) {
                                      return AnimatedContainer(
                                          margin: EdgeInsets.only(bottom: 10.h),
                                          duration:
                                              const Duration(milliseconds: 300),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.w, vertical: 15.h),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white10),
                                              color:
                                                  Colors.white.withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(10.r)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      heading(
                                                          text: widget
                                                              .ticketData
                                                              .ticketCategory[
                                                                  index]
                                                              .ticketName,
                                                          color:
                                                              Colors.white70),
                                                      5.ph,
                                                      paragraph(
                                                          text:
                                                              'USh ${100000 * tickerController.ticketsToBuy.value} + USh ${1000 * tickerController.ticketsToBuy.value}',
                                                          color: Colors.white54)
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      heading(
                                                          text:
                                                              '${tickerController.ticketsToBuy.value}',
                                                          color: Colors.white),
                                                      15.pw,
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              if (tickerController
                                                                      .ticketsToBuy
                                                                      .value <
                                                                  20) {
                                                                tickerController
                                                                    .ticketsToBuy
                                                                    .value += 1;
                                                              }

                                                              HapticFeedback
                                                                  .selectionClick();
                                                            },
                                                            child: Container(
                                                              width: 59.w,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white30,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4.r)),
                                                              child: Icon(
                                                                  LucideIcons
                                                                      .chevronUp,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          5.ph,
                                                          GestureDetector(
                                                            onTap: () {
                                                              if (tickerController
                                                                      .ticketsToBuy
                                                                      .value >
                                                                  1) {
                                                                tickerController
                                                                    .ticketsToBuy
                                                                    .value -= 1;
                                                                HapticFeedback
                                                                    .selectionClick();
                                                              }
                                                            },
                                                            child: Container(
                                                              width: 59.w,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white30,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4.r)),
                                                              child: Icon(
                                                                  LucideIcons
                                                                      .chevronDown,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              15.ph,
                                              paragraphSmallItalic(
                                                text:
                                                    'Sales Close 29 February 2024',
                                                color: Colors.white54,
                                              )
                                            ],
                                          ));
                                    },
                                  ),
                                  20.ph,
                                  title(
                                      color: Colors.white60,
                                      fontSize: 34.sp,
                                      text:
                                          'Total: USh ${100000 * tickerController.ticketsToBuy.value + 1000 * tickerController.ticketsToBuy.value}'),
                                  30.ph,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CupertinoButton(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            color: Colors.white10,
                                            child: label(text: 'Continue'),
                                            onPressed: () {}),
                                      ),
                                    ],
                                  ),
                                  30.ph,
                                ],
                              ),
                            );
                          }));
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white38,
                                  blurRadius: 20.0,
                                  spreadRadius: 1)
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.r),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                              child: Container(
                                  padding: EdgeInsets.all(10.w),
                                  decoration: const BoxDecoration(
                                      color: Colors.white60),
                                  child: label(text: 'Purchase Ticket')),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
