class Location {
  String id;
  String locationName;
  String locationDescription;
  String videoPreviewUrl;
  String locationCategory;
  String locationCity;
  int locationRating;
  String locationFullDescription;
  String virtualTourPreviewUrl;
  int likeCount;
  double locationLatCoordinate;
  double locationLongCoordinate;
  List<LocationPicture> locationPicture;
  List<LocationActivity> locationActivity;
  List<LocationAmenity> locationAmenity;
  List<LocationReview> locationReview;
  List<LocationMenuActivity> locationMenuActivity;
  LocationExtraInfo locationExtraInfo;

  Location({
    required this.id,
    required this.locationName,
    required this.locationDescription,
    required this.videoPreviewUrl,
    required this.locationCategory,
    required this.locationCity,
    required this.locationRating,
    required this.locationFullDescription,
    required this.virtualTourPreviewUrl,
    required this.likeCount,
    required this.locationLatCoordinate,
    required this.locationLongCoordinate,
    required this.locationPicture,
    required this.locationMenuActivity,
    required this.locationActivity,
    required this.locationAmenity,
    required this.locationReview,
    required this.locationExtraInfo,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      locationName: json['location_name'],
      locationDescription: json['location_description'],
      videoPreviewUrl: json['video_preview_url'],
      locationCategory: json['location_category'],
      locationCity: json['location_city'],
      locationRating: json['location_rating'],
      locationFullDescription: json['location_full_description'],
      virtualTourPreviewUrl: json['virtual_tour_preview_url'],
      likeCount: json['like_count'],
      locationLatCoordinate: json['location_lat_coordinate'].toDouble(),
      locationLongCoordinate: json['location_long_coordinate'].toDouble(),
      locationPicture: (json['location_picture'] as List)
          .map((picture) => LocationPicture.fromJson(picture))
          .toList(),
      locationMenuActivity: (json['location_menu_activity'] as List)
          .map((picture) => LocationMenuActivity.fromJson(picture))
          .toList(),
      locationActivity: (json['location_activity'] as List)
          .map((activity) => LocationActivity.fromJson(activity))
          .toList(),
      locationAmenity: (json['location_amenity'] as List)
          .map((amenity) => LocationAmenity.fromJson(amenity))
          .toList(),
      locationReview: (json['location_review'] as List)
          .map((review) => LocationReview.fromJson(review))
          .toList(),
      locationExtraInfo:
          LocationExtraInfo.fromJson(json['location_extra_info']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'location_name': locationName,
      'location_description': locationDescription,
      'video_preview_url': videoPreviewUrl,
      'location_category': locationCategory,
      'location_city': locationCity,
      'location_rating': locationRating,
      'location_full_description': locationFullDescription,
      'virtual_tour_preview_url': virtualTourPreviewUrl,
      'like_count': likeCount,
      'location_lat_coordinate': locationLatCoordinate,
      'location_long_coordinate': locationLongCoordinate,
      'location_picture':
          locationPicture.map((picture) => picture.toMap()).toList(),
      'location_activity':
          locationActivity.map((activity) => activity.toMap()).toList(),
      'location_amenity':
          locationAmenity.map((amenity) => amenity.toMap()).toList(),
      'location_review':
          locationReview.map((review) => review.toMap()).toList(),
      'location_extra_info': locationExtraInfo.toMap(),
    };
  }
}

class LocationPicture {
  String id;
  String locationPictureUrl;

  LocationPicture({
    required this.id,
    required this.locationPictureUrl,
  });

  factory LocationPicture.fromJson(Map<String, dynamic> json) {
    return LocationPicture(
      id: json['id'],
      locationPictureUrl: json['location_picture_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'location_picture_url': locationPictureUrl,
    };
  }
}

class LocationActivity {
  String id;
  String locationActivityPictureUrl;
  String locationActivityName;

  LocationActivity({
    required this.id,
    required this.locationActivityPictureUrl,
    required this.locationActivityName,
  });

  factory LocationActivity.fromJson(Map<String, dynamic> json) {
    return LocationActivity(
      id: json['id'],
      locationActivityPictureUrl: json['location_activity_picture_url'],
      locationActivityName: json['location_activity_name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'location_activity_picture_url': locationActivityPictureUrl,
      'location_activity_name': locationActivityName,
    };
  }
}

class LocationMenuActivity {
  String id;
  String locationMenuActivityPictureUrl;
  String locationMenuActivityTitle;
  String locationMenuActivityDescription;
  int locationMenuActivityPrice;

  LocationMenuActivity(
      {required this.id,
      required this.locationMenuActivityDescription,
      required this.locationMenuActivityPictureUrl,
      required this.locationMenuActivityPrice,
      required this.locationMenuActivityTitle});

  factory LocationMenuActivity.fromJson(Map<String, dynamic> json) {
    return LocationMenuActivity(
      id: json['id'],
      locationMenuActivityPictureUrl:
          json['location_menu_activity_picture_url'],
      locationMenuActivityDescription:
          json['location_menu_activity_description'],
      locationMenuActivityPrice: json['location_menu_activity_price'],
      locationMenuActivityTitle: json['location_menu_activity_title'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'location_menu_activity_title': locationMenuActivityTitle,
      'location_menu_activity_description': locationMenuActivityDescription,
      'location_menu_activity_price': locationMenuActivityPrice,
      'location_menu_activity_picture_url': locationMenuActivityPictureUrl,
    };
  }
}

class LocationAmenity {
  String id;
  String locationAmenityName;

  LocationAmenity({
    required this.id,
    required this.locationAmenityName,
  });

  factory LocationAmenity.fromJson(Map<String, dynamic> json) {
    return LocationAmenity(
      id: json['id'],
      locationAmenityName: json['location_amenity_name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'location_amenity_name': locationAmenityName,
    };
  }
}

class LocationReview {
  String id;
  String locationReviewContactName;
  String locationReviewContactPreview;
  String locationReviewContactReview;
  String locationReviewDate;

  LocationReview({
    required this.id,
    required this.locationReviewContactName,
    required this.locationReviewContactPreview,
    required this.locationReviewContactReview,
    required this.locationReviewDate,
  });

  factory LocationReview.fromJson(Map<String, dynamic> json) {
    return LocationReview(
      id: json['id'],
      locationReviewContactName: json['location_review_contact_name'],
      locationReviewContactPreview: json['location_review_contact_preview'],
      locationReviewContactReview: json['location_review_contact_review'],
      locationReviewDate: json['location_review_date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'location_review_contact_name': locationReviewContactName,
      'location_review_contact_preview': locationReviewContactPreview,
      'location_review_contact_review': locationReviewContactReview,
      'location_review_date': locationReviewDate,
    };
  }
}

class LocationExtraInfo {
  String id;
  String openingTime;
  String closingTime;
  String description;

  LocationExtraInfo({
    required this.id,
    required this.openingTime,
    required this.closingTime,
    required this.description,
  });

  factory LocationExtraInfo.fromJson(Map<String, dynamic> json) {
    return LocationExtraInfo(
      id: json['id'],
      openingTime: json['opening_time'],
      closingTime: json['closing_time'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'opening_time': openingTime,
      'closing_time': closingTime,
      'description': description,
    };
  }
}
