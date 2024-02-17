import 'package:flutter/cupertino.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:zula/v1/models/dish_menu_model.dart';

List<String> imageUrlList = [
  "https://ik.imagekit.io/ecjzuksxj/TravelBuddy/Instagram%20Photo%2020240204%20(1).jpg?updatedAt=1707042078279",
  "https://ik.imagekit.io/ecjzuksxj/TravelBuddy/Instagram%20Photo.jpg?updatedAt=1707042078319",
  "https://ik.imagekit.io/ecjzuksxj/TravelBuddy/Instagram%20(1).jpg?updatedAt=1707042078312",
  "https://ik.imagekit.io/ecjzuksxj/TravelBuddy/Instagram%20Photo%2020240204.jpg?updatedAt=1707042078234",
  "https://ik.imagekit.io/ecjzuksxj/TravelBuddy/Instagram%20Photo%20202.jpg?updatedAt=1707042076864",
  "https://ik.imagekit.io/ecjzuksxj/TravelBuddy/Instagram.jpg?updatedAt=1707042077364"
];



final List<Map<String, dynamic>> placeAmenities = [
  {
    'icon': LucideIcons.wifi,
    'label': 'Free Wifi',
  },
  {
    'icon': LineIcons.parking,
    'label': 'Parking',
  },
  {
    'icon': LucideIcons.nut,
    'label': 'Dinner Dates',
  },
  {
    'icon': LucideIcons.music,
    'label': 'Live Music',
  },
  {
    'icon': LucideIcons.sun,
    'label': 'Outdoor Seating',
  },
  {
    'icon': LucideIcons.wine,
    'label': 'Wine Tasting',
  },
  {
    'icon': LineIcons.glassWhiskey,
    'label': 'Cocktails',
  },
];

List<Map<String, dynamic>> bottomNavbar = [
  {'icon': CupertinoIcons.collections, 'label': 'Home'},
  {'icon': CupertinoIcons.compass, 'label': 'Zula'},
  {'icon': CupertinoIcons.gear, 'label': 'Settings'}
];
