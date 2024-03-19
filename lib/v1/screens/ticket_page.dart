import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zula/v1/controllers/ticket_controller.dart';
import 'package:zula/v1/screens/ticket_page_detail.dart';
import 'package:zula/v1/widgets/app_background.dart';
import 'package:zula/v1/widgets/event_ticket_widget.dart';
import 'package:zula/v1/widgets/header.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  TickerController tickerController = Get.find();

     @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // add setCurrentScreeninstead of initState because might not always give you the
    // expected results because initState() is called before the widget
    // is fully initialized, so the screen might not be visible yet.
    FirebaseAnalytics.instance.logScreenView(screenName: "Ticket Page Screen");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Stack(
          children: [
            const AppBackground(),
            ListView.builder(
                padding: EdgeInsets.only(
                    top: 160.h, bottom:90.0, left: 20.w, right: 20.w),
                itemCount: tickerController.retrievedEvnetTickets.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        // ScreenOverlay.showAppSheet(context,
                        //     sheet: );
                        tickerController.ticketsToBuy.value = List.filled(
                            tickerController.retrievedEvnetTickets[index]
                                .ticketCategory.length,
                            1);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TicketPageDetail(
                                    ticketData: tickerController
                                        .retrievedEvnetTickets[index])));
                      },
                      child: Hero(
                        tag: tickerController
                            .retrievedEvnetTickets[index].eventTitle,
                        child: EventTicketWidget(
                            ticketData:
                                tickerController.retrievedEvnetTickets[index]),
                      ));
                }),
            const Header(
              titleText: 'Events',
              headingText: 'Tickets and more',
            )
          ],
        );
      }),
    );
  }
}
