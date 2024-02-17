class LocationCategory {
  String categoryName;
  String categoryPictureUrl;
  int categoryCount;

  LocationCategory({
    required this.categoryName,
    required this.categoryPictureUrl,
    required this.categoryCount,
  });

  factory LocationCategory.fromJson(Map<String, dynamic> json) {
    return LocationCategory(
      categoryName: json['category'],
      categoryCount: json['count'] ?? 0,
      categoryPictureUrl: json['category_picture_url'],
    );
  }
}
