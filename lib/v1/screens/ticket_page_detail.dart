import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zula/v1/controllers/ticket_controller.dart';
import 'package:zula/v1/models/ticket_model.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/app_background.dart';

import 'package:zula/v1/widgets/event_ticket_widget.dart';

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
    return Scaffold(
      body: Stack(
        children: [
          const AppBackground(),
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 60.h, left: 20.w, right: 20.w),
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: Hero(
                    tag: widget.ticketData.eventTitle,
                    child: EventTicketWidget(
                      ticketData: widget.ticketData,
                      showTicketDetails: true,
                    )),
              )
            ],
          ),
          Positioned(
            bottom: 30.h,
            left: 120.0,
            right: 120.0,
            child: FilledButton.icon(
              style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 15)),
                  backgroundColor: MaterialStatePropertyAll(Colors.white30)),
              label: paragraph(text: 'Close', color: Colors.white),
              icon: const Icon(
                CupertinoIcons.multiply,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
