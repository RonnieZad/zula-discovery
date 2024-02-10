import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:vybe/v1/constants/strings.dart';
import 'package:vybe/v1/screens/explore_page.dart';
import 'package:vybe/v1/screens/notification_center.dart';
import 'package:vybe/v1/utils/extensions.dart';
import 'package:vybe/v1/utils/typography.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vybe/v1/widgets/app_background.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController(viewportFraction: 0.9);

  late List<VideoPlayerController> _videoPlayerControllers;

  @override
  void initState() {
    _videoPlayerControllers = List.generate(videoAssets.length, (index) {
      return VideoPlayerController.networkUrl(
          Uri.parse(videoAssets[index]['url']));
    });

    // Initialize all video controllers asynchronously
    Future.wait(_videoPlayerControllers
        .map((controller) => controller.initialize())).then((_) {
      setState(() {
        // Start playing the first video
        _videoPlayerControllers[0].play();
        _videoPlayerControllers[0].setLooping(true);
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    // Dispose all video controllers when the widget is disposed
    _videoPlayerControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
         const AppBackground(),
 
          Container(
            child: Positioned(
              top: 0.h,
              left: 0.0,
              right: 0.0,
              bottom: 90.h,
              child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: videoAssets.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        HapticFeedback.selectionClick();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ExploreDetails()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              bottom: 50.h,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.r),
                                    border: Border.all(
                                      color: Colors.white12,
                                    )),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.r),
                                  child: SizedBox(
                                    height: 1.39.sw,
                                    width: double.infinity,
                                    child: Stack(
                                      children: [
                                        _videoPlayerControllers.isNotEmpty
                                            ? VisibilityDetector(
                                                key: Key(videoAssets[index]
                                                    ['title']),
                                                onVisibilityChanged:
                                                    (visibilityInfo) {
                                                  var visiblePercentage =
                                                      visibilityInfo
                                                              .visibleFraction *
                                                          100;

                                                  if (visiblePercentage > 50) {
                                                    _videoPlayerControllers[
                                                            index]
                                                        .play();
                                                    _videoPlayerControllers[
                                                            index]
                                                        .setLooping(true);
                                                  } else {
                                                    _videoPlayerControllers[
                                                            index]
                                                        .pause();
                                                  }
                                                },
                                                child: VideoPlayer(
                                                    _videoPlayerControllers[
                                                        index]))
                                            : const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                        Container(
                                          decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                Colors.transparent,
                                                Colors.black87
                                              ])),
                                        ),
                                        Positioned(
                                          bottom: 65.h,
                                          left: 15.w,
                                          right: 15.w,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  heading(
                                                      text: videoAssets[index]
                                                          ['title'],
                                                      fontSize: 30.sp,
                                                      color: Colors.white),
                                                  10.pw,
                                                  Icon(
                                                    LucideIcons.badgeCheck,
                                                    color: Colors.white,
                                                    size: 20.w,
                                                  )
                                                ],
                                              ),
                                              10.ph,
                                              paragraph(
                                                  text: videoAssets[index]
                                                      ['description'],
                                                  fontSize: 20.sp,
                                                  color: Colors.white,
                                                  textAlign: TextAlign.center),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 18.h,
                              right: 120.w,
                              left: 120.w,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 17.h),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(20, 45, 66, 1),
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                child: Center(
                                    child: heading(
                                        text: 'Explore',
                                        color: Colors.white,
                                        fontSize: 24.sp)),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Positioned(
              top: 50.h,
              left: 20.w,
              right: 20.w,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/images/zula_logo.svg',
                          width: 100.w,
                          color: Colors.white,
                        ),
                        paragraph(
                            text: 'Discovering memories together',
                            color: Colors.white60,
                            fontSize: 19.sp)
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        LucideIcons.bellDot,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationCenter()));
                      },
                    ),
                  ])),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
