import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_player/video_player.dart';
import 'package:zula/v1/models/location_category.dart';
import 'package:zula/v1/models/location_model.dart';
import 'package:zula/v1/services/api_service.dart';
import 'package:zula/v1/widgets/screen_overlay.dart';

class LocationController extends GetxController {
  var currentPageIndex = 0.obs;

  late List<VideoPlayerController> videoPlayerControllers;

  final _locationCategories = <LocationCategory>[].obs;
  final _locations = <Location>[].obs;
  final _savedLocations = <Location>[].obs;

  final _locationSearches = <Location>[].obs;
  List<Location> get retrievedLocations => _locations;
  List<Location> get retrievedLocationSearches => _locationSearches;
  List<Location> get retrievedSavedLocations => _savedLocations;
  List<LocationCategory> get retrievedLocationCategories => _locationCategories;

  var discoverViewIsLoading = true.obs;
  var savedLocationLoading = true.obs;

  var homePageViewIsLoading = true.obs;
  var searchPageViewIsLoading = true.obs;
  int currentVideoFrameIndex = 0;

  @override
  onInit() {
    getLocations();

    super.onInit();
  }

  pauseAllVideoPlayback() {
    if (videoPlayerControllers.isNotEmpty) {
      videoPlayerControllers.forEach((element) {
        element.pause();
      });
    }
  }

  resumeFramePlay() {
    if (currentPageIndex.value == 0) {
      videoPlayerControllers[currentVideoFrameIndex].play();
    }
  }

  Future<int?> favoriteLocation({required String locationId}) {
    print(locationId);
    return ApiService.postRequest(
        endPoint: '/favorite_location',
        service: Services.application,
        body: {
          'user_id': GetStorage().read('user_id') ??
              '5248a3fa-81c3-4170-b136-34c0f0a54ef2',
          'location_id': locationId
        }).then((response) {
      print(response);
      if (response['payload']['status'] >= 200 &&
          response['payload']['status'] < 300) {
        return response['payload']['updated_count_like'];
      }
      return null;
    });
  }

  getUserSavedLocations() {
    ApiService.getRequest(
            endPoint:
                '/get_saved_locations/${GetStorage().read('user_id') ?? '5248a3fa-81c3-4170-b136-34c0f0a54ef2'}',
            service: Services.application)
        .then((response) {
      if (response['payload']['status'] >= 200 &&
          response['payload']['status'] < 300) {
        if (response['payload']['locations'] != null) {
          _savedLocations.value = (response['payload']['locations'] as List)
              .map((e) => Location.fromJson(e))
              .toList();
        } else {
          _savedLocations.clear();
        }
      }
      savedLocationLoading(false);
    });
  }

  getLocations() {
    ApiService.getRequest(
            endPoint: '/get_locations', service: Services.application)
        .then((response) {
      if (response['payload']['status'] >= 200 &&
          response['payload']['status'] < 300) {
        _locations.value = (response['payload']['locations'] as List)
            .map((e) => Location.fromJson(e))
            .toList();
        initializeVideoPlayers();
      }
      homePageViewIsLoading(false);
      print(homePageViewIsLoading.value);
      getLocationCategories();
    });
  }

  locationSearchByCategory({required String category}) {
    searchPageViewIsLoading(true);
    _locationSearches.clear();
    ApiService.getRequest(
            endPoint: '/get_locations_by_category/$category',
            service: Services.application)
        .then((response) {
      searchPageViewIsLoading(false);
      if (response['payload']['status'] >= 200 &&
          response['payload']['status'] < 300) {
        _locationSearches.value = (response['payload']['locations'] as List)
            .map((e) => Location.fromJson(e))
            .toList();
      }
    });
  }

  locationSearchByQuery({required String query}) {
    log('-->> $query');
    searchPageViewIsLoading(true);
    _locationSearches.clear();
    ApiService.getRequest(
            endPoint: '/search_location_by_name/$query',
            service: Services.application)
        .then((response) {
      if (response['payload']['status'] >= 200 &&
          response['payload']['status'] < 300) {
        searchPageViewIsLoading(false);
        print(response['payload']['locations']);
        _locationSearches.value = (response['payload']['locations'] as List)
            .map((e) => Location.fromJson(e))
            .toList();
      }
    });
  }

  getLocationCategories() {
    searchPageViewIsLoading(true);
    ApiService.getRequest(
            endPoint: '/get_location_categories', service: Services.application)
        .then((response) {
      if (response['payload']['status'] >= 200 &&
          response['payload']['status'] < 300) {
        _locationCategories.value =
            (response['payload']['location_counts'] as List)
                .map((e) => LocationCategory.fromJson(e))
                .toList();
      }
      discoverViewIsLoading(false);
    });
  }

  void initializeVideoPlayers() {
    videoPlayerControllers = _locations.map((location) {
      return VideoPlayerController.networkUrl(
          Uri.parse(location.videoPreviewUrl));
    }).toList();

    // Initialize all video controllers asynchronously
    Future.wait(
            videoPlayerControllers.map((controller) => controller.initialize()))
        .then((_) {
      for (var controller in videoPlayerControllers) {
        // Start playing the video
        // controller.play();
        controller.setLooping(true);
      }
    });
  }

  @override
  void onClose() {
    for (var controller in videoPlayerControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
