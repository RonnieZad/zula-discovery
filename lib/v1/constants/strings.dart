import 'package:flutter/cupertino.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:vybe/v1/models/dish_menu_model.dart';

List<String> imageUrlList = [
  "https://ik.imagekit.io/ecjzuksxj/TravelBuddy/Instagram%20Photo%2020240204%20(1).jpg?updatedAt=1707042078279",
  "https://ik.imagekit.io/ecjzuksxj/TravelBuddy/Instagram%20Photo.jpg?updatedAt=1707042078319",
  "https://ik.imagekit.io/ecjzuksxj/TravelBuddy/Instagram%20(1).jpg?updatedAt=1707042078312",
  "https://ik.imagekit.io/ecjzuksxj/TravelBuddy/Instagram%20Photo%2020240204.jpg?updatedAt=1707042078234",
  "https://ik.imagekit.io/ecjzuksxj/TravelBuddy/Instagram%20Photo%20202.jpg?updatedAt=1707042076864",
  "https://ik.imagekit.io/ecjzuksxj/TravelBuddy/Instagram.jpg?updatedAt=1707042077364"
];

final List<Dish> menuItems = [
  Dish(
      name: 'Spaghetti Bolognese',
      description: 'Classic Italian pasta with meat sauce',
      price: 12.99,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwbbZ1YdzAYT5tWHjtW4OZjH1T_tyyXt-Oag&usqp=CAU'),
  Dish(
    name: 'Chicken Caesar Salad',
    description: 'Fresh salad with grilled chicken and Caesar dressing',
    price: 10.99,
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP8Sdinscjwk3lKmWzw8eT6bz4kBKz5D0ysw&usqp=CAU',
  ),
  Dish(
    name: 'Margherita Pizza',
    description: 'Traditional Italian pizza with tomato, mozzarella, and basil',
    price: 14.99,
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQR0Q-VH2mXymx1qVHb9Xn--wMULrHfYDrGgA&usqp=CAU',
  ),
  // Add more dishes as needed
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

List<Map<String, dynamic>> videoAssets = [
  {
    'title': 'TheLawns',
    'description':
        'World class bar and cafeteria, rated five star and award winning',
    'url':
        'https://ik.imagekit.io/ecjzuksxj/TravelBuddy/Instagram%20Reels%20HD.mp4?updatedAt=1707012978093'
  },
  {
    'title': 'Pearl Marina',
    'description':
        'Soft ambiance and wow factor, serene beauty perfect for outdoor experiences',
    'url':
        'https://ik.imagekit.io/ecjzuksxj/TravelBuddy/Instagram.mp4?updatedAt=1707012960014'
  },
  {
    'title': 'The Sky Lounge',
    'description': 'Try to believe',
    'url':
        'https://ik.imagekit.io/ecjzuksxj/TravelBuddy/Instagram%20(1).mp4?updatedAt=1707012958634'
  }
];

List<Map<String, dynamic>> bottomNavbar = [
  {'icon': CupertinoIcons.collections, 'label': 'Home'},
  {'icon': CupertinoIcons.compass, 'label': 'Zula'},
  {'icon': CupertinoIcons.gear, 'label': 'Settings'}
];
