

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zula/v1/models/location_model.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';

class PlaceReviewSheet extends StatelessWidget {
  const PlaceReviewSheet({
    super.key, required this.locationReviews,
  });

  final List<LocationReview> locationReviews;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          heading(
              text: 'Reviews and Ratings',
              fontSize: 27.sp,
              color: Colors.white),
          20.ph,
          paragraph(
              text: 'Recent Reviews',
              fontSize: 20.sp,
              color: Colors.white),
          30.ph,
          SizedBox(
            height: 0.65.sh,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: locationReviews.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      locationReviews[index].locationReviewContactPreview
                        ),
                  ),
                  title: heading(
                      text: 'John Doe',
                      fontSize: 20.sp,
                      color: Colors.white),
                  subtitle: paragraph(
                      text:
                          locationReviews[index].locationReviewContactReview,
                      fontSize: 20.sp,
                      color: Colors.white),
                  trailing: paragraph(
                      text: locationReviews[index].locationReviewDate,
                      fontSize: 19.sp,
                      color: Colors.white),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}


