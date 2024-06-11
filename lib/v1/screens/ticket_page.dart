import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/constants/strings.dart';
import 'package:zula/v1/controllers/ticket_controller.dart';
import 'package:zula/v1/screens/dicover_page.dart';
import 'package:zula/v1/screens/notification_center.dart';
import 'package:zula/v1/screens/ticket_page_detail.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/event_ticket_widget.dart';
import 'package:zula/v1/widgets/screen_helpers.dart';
import 'package:zula/v1/widgets/screen_overlay.dart';

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

  SliverAppBar _appBar(BuildContext context) {
    return SliverAppBar(
      centerTitle: false,
      expandedHeight: 140.h,
      pinned: true,
      stretch: true,
      floating: true,
      backgroundColor: Colors.white,
      surfaceTintColor: brandPrimaryColor.withOpacity(0.2),
      actions: [
        IconButton(
          tooltip: 'Discover',
          icon: Icon(
            LineIcons.compass,
            color: brandPrimaryColor,
            size: 40.w,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const DiscoverPage()));
          },
        ),
        IconButton(
          tooltip: 'Notifications',
          icon: Icon(
            LineIcons.bell,
            color: brandPrimaryColor,
            size: 40.w,
          ),
          onPressed: () {
            ScreenOverlay.showAppSheet(context,
                sheet: const NotificationCenter());
          },
        ),
      ],
      title: title(
          text: 'Experiences',
          fontSize: 46.sp,
          color: brandPrimaryColor,
          fontFamily: 'TypoGraphica',
          textAlign: TextAlign.center),
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(74),
          child: TabBar(
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
                HapticFeedback.lightImpact();
                tickerController.filterEventCategory(tabIndex);
              })),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return Stack(
          children: [
            CustomScrollView(
              slivers: [
                _appBar(context),
                SliverPadding(
                  padding: EdgeInsets.only(
                      top: 25.h, bottom: 90.h, left: 20.w, right: 20.w),
                  sliver: tickerController.filteredEventTickets.isEmpty
                      ? const SliverFillRemaining(
                          hasScrollBody: false,
                          child: NoContentWidget(
                              label:
                                  'No Events found\nCheck your internet or Refresh'),
                        )
                      : SliverList.builder(
                          itemCount:
                              tickerController.filteredEventTickets.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                    onTap: () {
                                      HapticFeedback.lightImpact();
                                      tickerController.ticketsToBuy.value =
                                          List.filled(
                                              tickerController
                                                  .filteredEventTickets[index]
                                                  .ticketCategory
                                                  .length,
                                              0);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TicketPageDetail(
                                                  ticketData: tickerController
                                                          .filteredEventTickets[
                                                      index])));
                                    },
                                    child: Hero(
                                      tag: tickerController
                                          .filteredEventTickets[index]
                                          .eventTitle,
                                      child: EventTicketWidget(
                                          ticketData: tickerController
                                              .filteredEventTickets[index]),
                                    ))
                                .animate()
                                .slideY(begin: 0.2, end: 0.0, duration: 150.ms)
                                .fade(duration: 500.ms);
                          }),
                )
              ],
            ),
          ],
        );
      }),
    );
  }
}
