import 'dart:ui';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:lucide_icons/lucide_icons.dart';
import 'package:octo_image/octo_image.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/controllers/ticket_controller.dart';
import 'package:zula/v1/models/ticket_model.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/helper.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/image_blur_backdrop.dart';
import 'package:zula/v1/widgets/screen_overlay.dart';

class EventTicketWidget extends StatelessWidget {
  const EventTicketWidget({
    super.key,
    this.showTicketDetails = false,
    required this.ticketData,
  });

  final Ticket ticketData;
  final bool? showTicketDetails;

  @override
  Widget build(BuildContext context) {
    TickerController tickerController = Get.find();
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            TicketWidget(
              color: Colors.black,
              isCornerRounded: true,
              width: double.infinity,
              height: showTicketDetails! ? 730.h : 590.h,
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
                            ticketData.artworkPictureUrl,
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
                            text: ticketData.eventTitle,
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
                                text: ticketData.eventLocation,
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
                                text: ticketData.eventDate,
                                color: Colors.white60,
                              ),
                            ],
                          ),
                          10.ph,
                          if (showTicketDetails == true) ...[
                            paragraph(
                                text:
                                    'From USh ${ticketData.ticketCategory[0].ticketPrice}',
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
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            showTicketDetails == false
                ? const SizedBox.shrink()
                : Positioned(
                    top: 20.h,
                    right: 15.w,
                    child: GestureDetector(
                      onTap: () {
                        ScreenOverlay.showAppSheet(context,
                            sheet: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  title(
                                      text: 'Choose your Tickets',
                                      fontSize: 46.sp,
                                      color: Colors.white,
                                      fontFamily: 'Broncks',
                                      textAlign: TextAlign.center),
                                  20.ph,
                                  paragraph(
                                      text:
                                          'Select ticket type you wish to purchase below.',
                                      color: Colors.white54),
                                  30.ph,
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemCount: ticketData.ticketCategory.length,
                                    itemBuilder: (contex, index) {
                                      return Container(
                                          margin: EdgeInsets.only(bottom: 10.h),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
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
                                                          text:
                                                              '${ticketData.ticketCategory[index].ticketName} - Ugx ${Helper.getTextDigit((ticketData.ticketCategory[index].ticketPrice.toString()))}',
                                                          color:
                                                              Colors.white70),
                                                      5.ph,
                                                      Obx(() {
                                                        return paragraph(
                                                            text:
                                                                'Ugx ${Helper.getTextDigit((ticketData.ticketCategory[index].ticketPrice * tickerController.ticketsToBuy[index]).toString())} + Ugx ${Helper.getTextDigit((1000 * tickerController.ticketsToBuy[index]).toString())}',
                                                            color:
                                                                Colors.white54);
                                                      })
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Obx(() {
                                                        return heading(
                                                            text:
                                                                '${tickerController.ticketsToBuy[index]}',
                                                            color:
                                                                Colors.white);
                                                      }),
                                                      15.pw,
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              HapticFeedback
                                                                  .selectionClick();
                                                              tickerController
                                                                  .incrementTickets(
                                                                      index,
                                                                      ticketData
                                                                          .ticketCategory);
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
                                                              child: const Icon(
                                                                  LucideIcons
                                                                      .chevronUp,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          5.ph,
                                                          GestureDetector(
                                                            onTap: () {
                                                              HapticFeedback
                                                                  .selectionClick();
                                                              tickerController
                                                                  .decrementTickets(
                                                                      index,
                                                                      ticketData
                                                                          .ticketCategory);
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
                                                              child: const Icon(
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
                                  Obx(() {
                                    return title(
                                        color: Colors.white60,
                                        fontSize: 34.sp,
                                        text:
                                            'Total: Ugx ${Helper.getTextDigit(tickerController.totalAmount.value.toString())}');
                                  }),
                                  30.ph,
                                  SizedBox(
                                    height: 64.h,
                                    width: double.infinity,
                                    child: CupertinoButton(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        color:
                                            brandPrimaryColor.withOpacity(0.7),
                                        child: label(text: 'Continue'),
                                        onPressed: () {
                                          if (tickerController
                                                  .totalAmount.value !=
                                              0) {
                                            ScreenOverlay.showConfirmationDialog(
                                                context,
                                                titleText: 'Confirm Payment',
                                                description:
                                                    'Confirm your payment of UGX${Helper.getTextDigit(tickerController.totalAmount.value.toString())} on your mobile money account',
                                                showTextBox: true,
                                                textEditingController:
                                                    tickerController
                                                        .phoneNumberTextEditingController,
                                                action: () {
                                                  if(tickerController
                                                        .phoneNumberTextEditingController.text.length == 9){
                                                          tickerController.showPaymentProcessing(true);
                                                        }
                                                });
                                          } else {}
                                        }).animate()
                    .then(delay: 940.ms)
                   .slideY(begin: 0.12, end: 0, delay: 600.ms, duration: 7800.ms, curve: Curves.elasticInOut),
                                  ),
                                  30.ph,
                                ] .animate(interval: 100.ms).then(delay: 240.ms) .blurXY(begin: 1, end: 0)
                    .slideY(begin: 0.2, end: 0.0)
                    .fade(duration: 500.ms),
                              ),
                            ));
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
                                decoration:
                                    const BoxDecoration(color: Colors.white60),
                                child: label(text: 'Purchase Ticket')),
                          ),
                        ),
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}
