import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:octo_image/octo_image.dart';
import 'package:zula/v1/controllers/location_controller.dart';
import 'package:zula/v1/screens/search_result_page.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/app_background.dart';
import 'package:zula/v1/widgets/image_blur_backdrop.dart';
import 'package:zula/v1/widgets/screen_overlay.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  LocationController locationController = Get.find();
  @override
  List<Widget> buildActions(BuildContext context) {
    // Build the actions for the AppBar (e.g., clear query button).
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          close(context, '');
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Build the leading icon for the AppBar (e.g., back button).
    return IconButton(
      icon: const Icon(LucideIcons.arrowLeft),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement your search results view here.
    return const SearchResultPage(
      hideBackButton: true,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement your suggestion list here.
    final List<String> suggestions = ['Restaurant', 'Club', 'Gardens'];

    final filteredSuggestions = query.isEmpty
        ? suggestions
        : suggestions
            .where((fruit) => fruit.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: filteredSuggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: paragraph(text: filteredSuggestions[index]),
          onTap: () {
            // You can handle the tap on a suggestion item.
            HapticFeedback.selectionClick();
            close(context, filteredSuggestions[index]);
            locationController.locationSearchByQuery(
                query: filteredSuggestions[index]);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SearchResultPage()));
          },
        );
      },
    );
  }
}

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  LocationController locationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            const AppBackground(),
            Positioned(
                top: 65.h,
                left: 20.w,
                right: 20.w,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      title(
                        text: 'Discover',
                        color: Colors.white,
                        fontSize: 40.sp,
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          LucideIcons.search,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showSearch(
                              context: context,
                              delegate: CustomSearchDelegate());
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          CupertinoIcons.sparkles,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          ScreenOverlay.showAppSheet(context,
                              sheet: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        heading(
                                            text: 'Search with Zula AI',
                                            color: Colors.white),
                                        10.pw,
                                        const Icon(
                                          CupertinoIcons.sparkles,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                    10.ph,
                                    Container(
                                      padding: EdgeInsets.all(8.w),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          border: Border.all(
                                              width: 0.4,
                                              color: Colors.white60)),
                                      child: TextFormField(
                                        maxLines: 5,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                'eg find me a cute cosy restaurant for a dinner date with ambient lighting, low noise and live band',
                                            hintStyle: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.white60)),
                                      ),
                                    ),
                                    10.ph,
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CupertinoButton(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            color: Colors.white54,
                                            child: label(text: 'Search'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ));
                        },
                      ),
                    ])),
            Positioned(
              top: 160.h,
              left: 20.w,
              right: 20.w,
              bottom: 0.0,
              child: locationController.discoverViewIsLoading.value
                  ? GridView.builder(
                          padding: EdgeInsets.only(bottom: 120.h),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 270,
                                  mainAxisSpacing: 15.w,
                                  crossAxisSpacing: 15.h,
                                  crossAxisCount: 2),
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(20.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.r),
                                  color: Colors.white24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        color: Colors.white30),
                                  ),
                                  10.ph,
                                  Container(
                                    width: 60,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        color: Colors.white30),
                                  )
                                ],
                              ),
                            );
                          })
                      .animate(onPlay: (controller) => controller.repeat())
                      .shimmer(
                        delay: 700.ms,
                        duration: 3000.ms,
                        color: Colors.black38,
                      )
                  : locationController.retrievedLocationCategories.isEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            heading(
                                text: 'It looks unsually empty here',
                                color: Colors.white30),
                            10.ph,
                            paragraph(
                                text: 'Check your internet or\ntry again later',
                                color: Colors.white30)
                          ],
                        )
                      : GridView.builder(
                          padding: EdgeInsets.only(bottom: 120.h),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 270,
                                  mainAxisSpacing: 15.w,
                                  crossAxisSpacing: 15.h,
                                  crossAxisCount: 2),
                          itemCount: locationController
                              .retrievedLocationCategories.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                locationController.locationSearchByCategory(
                                    category: locationController
                                        .retrievedLocationCategories[index]
                                        .categoryName);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SearchResultPage()));
                              },
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Stack(
                                        children: [
                                          OctoImage(
                                            width: double.infinity,
                                            height: double.infinity,
                                            placeholderBuilder:
                                                OctoBlurHashFix.placeHolder(
                                                    'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                                            errorBuilder: OctoError.icon(
                                                color: Colors.red),
                                            image: CachedNetworkImageProvider(
                                                locationController
                                                    .retrievedLocationCategories[
                                                        index]
                                                    .categoryPictureUrl),
                                            fit: BoxFit.cover,
                                          ),
                                          Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                  Colors.transparent,
                                                  Colors.black45
                                                ])),
                                          ),
                                          Positioned(
                                            bottom: 15.h,
                                            left: 15.w,
                                            right: 15.w,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                heading(
                                                    text: locationController
                                                        .retrievedLocationCategories[
                                                            index]
                                                        .categoryName,
                                                    fontSize: 25.sp,
                                                    color: Colors.white),
                                                8.ph,
                                                paragraph(
                                                    text:
                                                        '${locationController.retrievedLocationCategories[index].categoryCount} places',
                                                    fontSize: 18.sp,
                                                    color: Colors.white)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
            ),
          ],
        );
      }),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
