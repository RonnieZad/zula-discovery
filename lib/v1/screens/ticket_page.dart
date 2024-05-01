import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/constants/strings.dart';
import 'package:zula/v1/controllers/ticket_controller.dart';
import 'package:zula/v1/screens/ticket_page_detail.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/event_ticket_widget.dart';
import 'package:zula/v1/widgets/header.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage>
    with SingleTickerProviderStateMixin {
  TickerController tickerController = Get.find();
  late TabController experienceTabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FirebaseAnalytics.instance.logScreenView(screenName: "TicketPageScreen");
  }

  @override
  void initState() {
    tickerController.filteredEventTickets.value =
        tickerController.retrievedEventTickets;

    experienceTabController =
        TabController(length: experienceTabCategories.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return Stack(
          children: [
            tickerController.filteredEventTickets.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.imageMinus,
                          size: 120.w,
                        ),
                        15.ph,
                        heading(text: 'No events found')
                      ].animate(onPlay: (controller) => controller.repeat(),)
                    .then(delay: 440.ms)
                   .slideY(begin: 0.1, end: 0, delay: 600.ms, duration: 3800.ms, curve: Curves.elasticInOut),
                    ),
                  )
                : ListView.builder(
                        padding: EdgeInsets.only(
                            top: 245.h, bottom: 90.h, left: 20.w, right: 20.w),
                        itemCount: tickerController.filteredEventTickets.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                tickerController.ticketsToBuy.value =
                                    List.filled(
                                        tickerController
                                            .filteredEventTickets[index]
                                            .ticketCategory
                                            .length,
                                        1);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TicketPageDetail(
                                            ticketData: tickerController
                                                .filteredEventTickets[index])));
                              },
                              child: Hero(
                                tag: tickerController
                                    .filteredEventTickets[index].eventTitle,
                                child: EventTicketWidget(
                                    ticketData: tickerController
                                        .filteredEventTickets[index]),
                              ));
                        })
                    .animate()
                    .slideY(begin: 0.2, end: 0.0, duration: 150.ms)
                    .fade(duration: 500.ms),
            Header(
              titleText: 'Events',
              headingText: 'Experiences and Tickets',
              bottomWidget: TabBar(
                  indicatorColor: brandPrimaryColor,
                  unselectedLabelColor: brandPrimaryColor.withOpacity(0.7),
                  labelColor: brandPrimaryColor,
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  controller: experienceTabController,
                  tabs: experienceTabCategories
                      .map((tapItem) => Tab(
                            icon: Icon(tapItem['icon']),
                            text: tapItem['label'],
                          ))
                      .toList(),
                  onTap: (tabIndex) {
                    tickerController.filterEventCategory(tabIndex);
                  }),
            )
          ],
        );
      }),
    );
  }
}
