import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:octo_image/octo_image.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:zula/v1/controllers/ticket_controller.dart';
import 'package:zula/v1/screens/ticket_page_detail.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/app_background.dart';
import 'package:zula/v1/widgets/header.dart';
import 'package:zula/v1/widgets/image_blur_backdrop.dart';
import 'package:zula/v1/widgets/screen_overlay.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  TickerController tickerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Stack(
          children: [
            const AppBackground(),
            ListView.builder(
                padding: EdgeInsets.only(
                    top: 160.h, bottom: 100.0, left: 20.w, right: 20.w),
                itemCount: tickerController.retrievedEvnetTickets.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        ScreenOverlay.showAppSheet(context,
                            sheet: TicketPageDetail(
                                ticketData: tickerController
                                    .retrievedEvnetTickets[index]));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: TicketWidget(
                          color: Colors.black,
                          isCornerRounded: true,
                          width: 350,
                          height: 590.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.r),
                            child: Stack(
                              children: [
                                SizedBox(
                                    height: 440.h,
                                    width: double.infinity,
                                    child: OctoImage(
                                      placeholderBuilder:
                                          OctoBlurHashFix.placeHolder(
                                              'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                                      errorBuilder:
                                          OctoError.icon(color: Colors.red),
                                      image: CachedNetworkImageProvider(
                                        tickerController
                                            .retrievedEvnetTickets[index]
                                            .artworkPictureUrl,
                                      ),
                                      fit: BoxFit.cover,
                                    )),
                                Positioned(
                                  bottom: 0.0,
                                  left: 20.w,
                                  right: 20.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      heading(
                                        text: tickerController
                                            .retrievedEvnetTickets[index]
                                            .eventTitle,
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
                                            text: tickerController
                                                .retrievedEvnetTickets[index]
                                                .eventLocation,
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
                                            text: tickerController
                                                .retrievedEvnetTickets[index]
                                                .eventDate,
                                            color: Colors.white60,
                                          ),
                                        ],
                                      ),
                                      10.ph,
                                      // paragraph(
                                      //     text: 'From USh100,000',
                                      //     color: Colors.white,
                                      //     fontSize: 25.sp),
                                      // 15.ph,
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
                }),
            const Header(
              titleText: 'Events',
              headingText: 'Tickets and more',
            ),
          ],
        );
      }),
    );
  }
}
