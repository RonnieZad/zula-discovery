import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/controllers/ticket_controller.dart';
import 'package:zula/v1/models/ticket_model.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/helper.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/screen_overlay.dart';

class PurchaseTicketSheet extends StatelessWidget {
  const PurchaseTicketSheet({
    super.key,
    required this.ticketData,
  });

  final Ticket ticketData;

  @override
  Widget build(BuildContext context) {
    TickerController ticketController = Get.find();
    // ticketController.ticketsToBuy.value = [];
    return Padding(
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
              text: 'Select ticket type you wish to purchase below.',
              color: Colors.white54),
          30.ph,
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: ticketData.ticketCategory.length,
            itemBuilder: (contex, index) {
              return Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white10),
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              heading(
                                  text:
                                      '${ticketData.ticketCategory[index].ticketName} - Ugx ${Helper.getTextDigit((ticketData.ticketCategory[index].ticketPrice.toString()))}',
                                  color: Colors.white70),
                              5.ph,
                              Obx(() {
                                return paragraph(
                                    text:
                                        'Ugx ${Helper.getTextDigit((ticketData.ticketCategory[index].ticketPrice * ticketController.ticketsToBuy[index]).toString())} + Ugx ${Helper.getTextDigit((1000 * ticketController.ticketsToBuy[index]).toString())}',
                                    color: Colors.white54);
                              })
                            ],
                          ),
                          Row(
                            children: [
                              Obx(() {
                                return heading(
                                    text:
                                        '${ticketController.ticketsToBuy[index]}',
                                    color: Colors.white);
                              }),
                              15.pw,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      HapticFeedback.selectionClick();
                                      ticketController.incrementTickets(
                                          index, ticketData.ticketCategory);
                                    },
                                    child: Container(
                                      width: 59.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white30,
                                          borderRadius:
                                              BorderRadius.circular(4.r)),
                                      child: const Icon(LucideIcons.chevronUp,
                                          color: Colors.white),
                                    ),
                                  ),
                                  5.ph,
                                  GestureDetector(
                                    onTap: () {
                                      HapticFeedback.selectionClick();
                                      ticketController.decrementTickets(
                                          index, ticketData.ticketCategory);
                                    },
                                    child: Container(
                                      width: 59.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white30,
                                          borderRadius:
                                              BorderRadius.circular(4.r)),
                                      child: const Icon(LucideIcons.chevronDown,
                                          color: Colors.white),
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
                        text: 'Sales Close 29 February 2024',
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
                    'Total: Ugx ${Helper.getTextDigit(ticketController.totalAmount.value.toString())}');
          }),
          30.ph,
          SizedBox(
            height: 64.h,
            width: double.infinity,
            child: CupertinoButton(
                    borderRadius: BorderRadius.circular(50.0),
                    color: brandPrimaryColor.withOpacity(0.7),
                    child: label(text: 'Continue'),
                    onPressed: () {
                      if (ticketController.totalAmount.value != 0) {
                        ScreenOverlay.showConfirmationDialog(context,
                            titleText: 'Confirm Payment',
                            description:
                                'Confirm your payment of UGX${Helper.getTextDigit(ticketController.totalAmount.value.toString())} on your mobile money account',
                            showTextBox: true,
                            textEditingController: ticketController
                                .phoneNumberTextEditingController, action: () {
                          if (ticketController.phoneNumberTextEditingController
                                  .text.length ==
                              9) {
                            ticketController.showPaymentProcessing(true);
                          }
                        });
                      } else {}
                    })
                .animate()
                .then(delay: 940.ms)
                .slideY(
                    begin: 0.12,
                    end: 0,
                    delay: 600.ms,
                    duration: 7800.ms,
                    curve: Curves.elasticInOut),
          ),
          30.ph,
        ]
            .animate(interval: 100.ms)
            .then(delay: 240.ms)
            .blurXY(begin: 1, end: 0)
            .slideY(begin: 0.2, end: 0.0)
            .fade(duration: 500.ms),
      ),
    );
  }
}