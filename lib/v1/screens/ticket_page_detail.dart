import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/controllers/ticket_controller.dart';
import 'package:zula/v1/models/ticket_model.dart';
import 'package:zula/v1/utils/typography.dart';
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 70.0,
            left: 20.0,
            right: 20.0,
            
            child: Hero(
                tag: widget.ticketData.eventTitle,
                child: EventTicketWidget(
                  ticketData: widget.ticketData,
                  showTicketDetails: true,
                )).animate().then(delay: 240.ms).shakeX().shakeY(),
          ),
          Positioned(
            bottom: 30.h,
            left: 120.0,
            right: 120.0,
            child: FilledButton.icon(
              style: ButtonStyle(
                  padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 15)),
                  backgroundColor: MaterialStatePropertyAll(
                      brandPrimaryColor.withOpacity(0.1))),
              label: paragraph(text: 'Close', color: brandPrimaryColor),
              icon: Icon(
                CupertinoIcons.multiply,
                color: brandPrimaryColor,
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
