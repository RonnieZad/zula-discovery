

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vybe/v1/utils/extensions.dart';
import 'package:vybe/v1/utils/typography.dart';

class PlaceReviewSheet extends StatelessWidget {
  const PlaceReviewSheet({
    super.key,
  });

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
              itemCount: 14,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://ik.imagekit.io/ecjzuksxj/TravelBuddy/Instagram%20Photo%2020240204%20(1).jpg?updatedAt=1707042078279'),
                  ),
                  title: heading(
                      text: 'John Doe',
                      fontSize: 20.sp,
                      color: Colors.white),
                  subtitle: paragraph(
                      text:
                          'The place is amazing, I had a great time',
                      fontSize: 20.sp,
                      color: Colors.white),
                  trailing: paragraph(
                      text: '3rd Feb',
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


