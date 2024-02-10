import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vybe/v1/models/dish_menu_model.dart';
import 'package:vybe/v1/screens/explore_page.dart';
import 'package:vybe/v1/utils/extensions.dart';
import 'package:vybe/v1/utils/typography.dart';

class MenuActivitySheet extends StatelessWidget {
  const MenuActivitySheet({
    super.key,
    required this.menuItems,
  });

  final List<Dish> menuItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 20.w),
          child: heading(
              text: 'Menu',
              fontSize: 27.sp,
              color: Colors.white),
        ),
        20.ph,
        // Add your menu items here of dishes, put pictures, name, description and price
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: ClipRRect(
                borderRadius:
                    BorderRadius.circular(6.r),
                child: Image.network(
                  menuItems[index].imageUrl,
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.cover,
                ),
              ),
              title: heading(
                  text: menuItems[index].name,
                  fontSize: 21.sp,
                  color: Colors.white),
              subtitle: paragraph(
                  text: menuItems[index]
                      .description,
                  color: Colors.white54,
                  fontSize: 19.sp),
              trailing: heading(
                  text:
                      '\$${menuItems[index].price.toStringAsFixed(2)}',
                  fontSize: 20.sp,
                  color: Colors.white),
            );
          },
        )
      ],
    );
  }
}

