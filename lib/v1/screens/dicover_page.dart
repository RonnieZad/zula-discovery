import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:octo_image/octo_image.dart';
import 'package:vybe/v1/screens/search_result_page.dart';
import 'package:vybe/v1/utils/extensions.dart';
import 'package:vybe/v1/utils/typography.dart';
import 'package:vybe/v1/widgets/app_background.dart';
import 'package:vybe/v1/widgets/screen_overlay.dart';

class OctoBlurHashFix {
  static OctoPlaceholderBuilder placeHolder(String hash, {BoxFit? fit}) {
    return (context) => SizedBox.expand(
          child: Image(
            image: BlurHashImage(hash),
            fit: fit ?? BoxFit.cover,
          ),
        );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // Build the actions for the AppBar (e.g., clear query button).
    return [
      IconButton(
        icon: Icon(Icons.clear),
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
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement your search results view here.
    return Container(
      padding: EdgeInsets.all(16.0),
      child: paragraph(text: 'Search results for: $query'),
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
            close(context, filteredSuggestions[index]);
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
  List<Map<String, dynamic>> discoverCategories = [
    {
      'title': 'Restaurants',
      'icon': LucideIcons.plane,
      'asset':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ef/Restaurant_N%C3%A4sinneula.jpg/640px-Restaurant_N%C3%A4sinneula.jpg'
    },
    {
      'title': 'Hotels',
      'icon': LucideIcons.bed,
      'asset':
          'https://static.leonardo-hotels.com/image/leonardohotelbucharestcitycenter_room_comfortdouble2_2022_4000x2600_7e18f254bc75491965d36cc312e8111f_1200x780_mobile_3.jpeg'
    },
    {
      'title': 'Bars',
      'icon': LineIcons.glassWhiskey,
      'asset':
          'https://images.squarespace-cdn.com/content/v1/60146ec5ca0b337ce6a69312/4dec25e3-de4b-44fd-9ef6-11d4a44d3cfa/dtp_roxy2019_202.jpg'
    },
    {
      'title': 'Clubs',
      'icon': LucideIcons.music,
      'asset':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSim5yF3-HWGNYBuH_K80yi6lCx6ciLANHqpw&usqp=CAU'
    },
    {
      'title': 'Parks',
      'icon': LineIcons.tree,
      'asset':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxMwCdqKnAjOhNBQDhQCOqFctlodwYp4NV9A&usqp=CAU'
    },
    {
      'title': 'Beaches',
      'icon': LucideIcons.sun,
      'asset':
          'https://cdn.mos.cms.futurecdn.net/wtqqnkYDYi2ifsWZVW2MT4-1200-80.jpg'
    },
    {
      'title': 'Museums',
      'icon': LucideIcons.book,
      'asset':
          'https://cdn.britannica.com/51/194651-050-747F0C18/Interior-National-Gallery-of-Art-Washington-DC.jpg'
    },
    {
      'title': 'Cinemas',
      'icon': LucideIcons.video,
      'asset':
          'https://m.economictimes.com/thumb/msid-104359417,width-1200,height-900,resizemode-4,imgsize-54656/cinema-halls1.jpg'
    },
    {
      'title': 'Gyms',
      'icon': LucideIcons.dumbbell,
      'asset':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTO23iSHwKCYVROiFUCNhs_HUxLiMkTvtooKg&usqp=CAU'
    },
    {
      'title': 'Spas',
      'icon': LucideIcons.leaf,
      'asset':
          'https://wanderingcarol.com/wp-content/uploads/2021/11/types-of-spas.jpg'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                            context: context, delegate: CustomSearchDelegate());
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
                                      Icon(
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
                                            width: 0.4, color: Colors.white60)),
                                    child: TextFormField(
                                      maxLines: 5,
                                      decoration: InputDecoration(
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
                                          color: Colors.black26,
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
            child: GridView.builder(
                padding: EdgeInsets.only(bottom: 120.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 15.w,
                    crossAxisSpacing: 15.h,
                    crossAxisCount: 2),
                itemCount: discoverCategories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchResultPage()));
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: SizedBox(
                            // height: 1.45.sw,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                OctoImage(
                                  width: double.infinity,
                                  height: double.infinity,
                                  placeholderBuilder:
                                      OctoBlurHashFix.placeHolder(
                                          'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                                  errorBuilder:
                                      OctoError.icon(color: Colors.red),
                                  image: CachedNetworkImageProvider(
                                    discoverCategories[index]['asset'],
                                  ),
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
                                          text: discoverCategories[index]
                                              ['title'],
                                          fontSize: 25.sp,
                                          color: Colors.white),
                                      8.ph,
                                      paragraph(
                                          text: '234 places',
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
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
