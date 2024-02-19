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
  {'icon': CupertinoIcons.ticket, 'label': 'Events'},
  {'icon': CupertinoIcons.gear, 'label': 'Settings'}
];

String termsOfServie = '''

Welcome to Zula App! These Terms of Service ("Terms") govern your access to and use of Zula App, including any content, functionality, and services offered through the app. By accessing or using Zula App, you agree to be bound by these Terms.

1. Description of Service: Zula App provides a platform for discovering entertainment and tourism experiences, including restaurants, clubs, bars, parks, museums, and more. Users can search for experiences, view detailed information, and receive recommendations based on their preferences.

2. User Registration: In order to access certain features of Zula App, you may be required to register for an account. You agree to provide accurate and complete information during the registration process and to keep your account credentials secure.

3. Subscription Plans: Businesses in the entertainment and tourism industry can partner with Zula App by subscribing to our marketplace listing for a period of 4 months, 6 months, or a year. This subscription grants them access to our platform to showcase their offerings to our user base.

4. User Conduct: Users agree to use Zula App for lawful purposes and to abide by all applicable laws and regulations. Any misuse of the app, including but not limited to spamming, hacking, or uploading malicious content, is strictly prohibited.

5. Intellectual Property: All content and materials available on Zula App, including text, images, videos, and logos, are protected by copyright and other intellectual property laws. Users agree not to reproduce, distribute, or create derivative works without prior written consent from Zula App.

6. Privacy Policy: Zula App respects your privacy and is committed to protecting your personal information. Our Privacy Policy outlines how we collect, use, and disclose your data. By using Zula App, you consent to the terms of our Privacy Policy.

7. Limitation of Liability: Zula App strives to provide accurate and reliable information, but makes no warranties or representations regarding the accuracy, completeness, or reliability of any content on the app. Users use Zula App at their own risk.

8. Indemnification: Users agree to indemnify and hold harmless Zula App and its affiliates, officers, directors, employees, and agents from any claims, damages, liabilities, costs, or expenses arising out of their use of the app or violation of these terms.

9. Governing Law: These Terms shall be governed by and construed in accordance with the laws of Uganda. Any disputes arising out of these terms shall be resolved exclusively by the courts of Uganda.

10. Changes to Terms: Zula App reserves the right to modify or revise these Terms at any time without prior notice. Users are encouraged to review the terms regularly for any updates or changes.

By using Zula App, you acknowledge that you have read, understood, and agreed to these Terms. If you do not agree with any part of these Terms, please do not use Zula App.''';


String privacyPolicyText = '''

This Privacy Policy ("Policy") describes how Zula App collects, uses, and discloses your personal information when you use our app. By accessing or using Zula App, you agree to be bound by this Policy.

1. Information We Collect:
   - Personal Information: When you register for an account on Zula App, we may collect certain personal information such as your name, email address, and phone number.
   - Usage Information: We collect information about how you use Zula App, including your interactions with content and features.
   - Device Information: We may collect information about the device you use to access Zula App, such as your device type, operating system, and IP address.

2. How We Use Your Information:
   - Provide Services: We use your personal information to provide and improve Zula App's services, including offering personalized recommendations and experiences.
   - Communication: We may use your contact information to communicate with you about your account, updates, and promotional offers.
   - Analytics: We may use usage information and analytics to understand how users interact with Zula App and to improve our services.

3. Information Sharing:
   - We may share your personal information with third-party service providers who assist us in providing Zula App's services.
   - We may share aggregated or anonymized data with third parties for analytics, research, or marketing purposes.

4. Data Security:
   - We take reasonable measures to protect your personal information from unauthorized access, disclosure, alteration, or destruction.
   - However, no method of transmission over the internet or electronic storage is 100% secure, and we cannot guarantee absolute security.

5. Your Choices:
   - You can choose not to provide certain personal information, but it may limit your ability to use certain features of Zula App.
   - You can opt out of receiving promotional communications from us by following the instructions in the communication.

6. Children's Privacy:
   - Zula App is not intended for children under the age of 13, and we do not knowingly collect personal information from children under 13. If we become aware that we have collected personal information from a child under 13, we will take steps to delete it.

7. Changes to this Policy:
   - We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Policy on Zula App.
   - You are advised to review this Policy periodically for any changes.

8. Contact Us:
   - If you have any questions or concerns about this Privacy Policy, please contact us at [contact email or address].

By using Zula App, you acknowledge that you have read, understood, and agreed to this Privacy Policy. If you do not agree with any part of this Policy, please do not use Zula App.''';


String termsCondtionsText = '''
Welcome to Zula App! These Terms and Conditions ("Terms") govern your access to and use of Zula App, including any content, functionality, and services offered through the app. By accessing or using Zula App, you agree to be bound by these Terms.

1. Description of Service: Zula App provides a platform for discovering entertainment and tourism experiences, including restaurants, clubs, bars, parks, museums, and more. Users can search for experiences, view detailed information, and receive recommendations based on their preferences.

2. User Registration: In order to access certain features of Zula App, you may be required to register for an account. You agree to provide accurate and complete information during the registration process and to keep your account credentials secure.

3. Subscription Plans: Businesses in the entertainment and tourism industry can partner with Zula App by subscribing to our marketplace listing for a period of 4 months, 6 months, or a year. This subscription grants them access to our platform to showcase their offerings to our user base.

4. User Conduct: Users agree to use Zula App for lawful purposes and to abide by all applicable laws and regulations. Any misuse of the app, including but not limited to spamming, hacking, or uploading malicious content, is strictly prohibited.

5. Intellectual Property: All content and materials available on Zula App, including text, images, videos, and logos, are protected by copyright and other intellectual property laws. Users agree not to reproduce, distribute, or create derivative works without prior written consent from Zula App.

6. Privacy Policy: Zula App respects your privacy and is committed to protecting your personal information. Our Privacy Policy outlines how we collect, use, and disclose your data. By using Zula App, you consent to the terms of our Privacy Policy.

7. Limitation of Liability: Zula App strives to provide accurate and reliable information, but makes no warranties or representations regarding the accuracy, completeness, or reliability of any content on the app. Users use Zula App at their own risk.

8. Indemnification: Users agree to indemnify and hold harmless Zula App and its affiliates, officers, directors, employees, and agents from any claims, damages, liabilities, costs, or expenses arising out of their use of the app or violation of these terms.

9. Governing Law: These Terms shall be governed by and construed in accordance with the laws of Uganda. Any disputes arising out of these terms shall be resolved exclusively by the courts of Uganda.

10. Changes to Terms: Zula App reserves the right to modify or revise these Terms at any time without prior notice. Users are encouraged to review the terms regularly for any updates or changes.

By using Zula App, you acknowledge that you have read, understood, and agreed to these Terms. If you do not agree with any part of these Terms, please do not use Zula App.''';