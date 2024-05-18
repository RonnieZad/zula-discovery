import 'dart:ui';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:octo_image/octo_image.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:zula/v1/models/ticket_model.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/helper.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/image_blur_backdrop.dart';
import 'package:zula/v1/widgets/screen_overlay.dart';
import 'package:zula/v1/widgets/sheets/purchase_ticket_sheet.dart';

class EventTicketWidget extends StatefulWidget {
  const EventTicketWidget({
    super.key,
    this.showTicketDetails = false,
    required this.ticketData,
  });

  final Ticket ticketData;
  final bool? showTicketDetails;

  @override
  State<EventTicketWidget> createState() => _EventTicketWidgetState();
}

class _EventTicketWidgetState extends State<EventTicketWidget> {
  @override
  Widget build(BuildContext context) {
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
              height: widget.showTicketDetails! ? 730.h : 590.h,
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
                      bottom: 10.0,
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
                          if (widget.showTicketDetails == true) ...[
                            paragraph(
                                text:
                                    'From USh ${Helper.getTextDigit(widget.ticketData.ticketCategory[0].ticketPrice.toString())}',
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
            widget.showTicketDetails == false
                ? const SizedBox.shrink()
                : Positioned(
                    top: 20.h,
                    right: 15.w,
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        ScreenOverlay.showAppSheet(context,
                            sheet: PurchaseTicketSheet(
                                ticketData: widget.ticketData));
                      },
                      child: Container(
                        decoration:  BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r),
                          border: Border.all(color: Colors.white, width: 2.w),
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
