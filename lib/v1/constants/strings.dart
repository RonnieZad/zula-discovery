import 'package:line_icons/line_icons.dart';
import 'package:lucide_icons/lucide_icons.dart';

List<String> optionsAi = [
  "What are the top tourist attractions in Kampala?",
  "Can you suggest some must-see places in Jinja?",
  "What is the best time to visit Uganda?",
  "What are some cultural customs I should be aware of when visiting Uganda?",
  "How do I greet people in Uganda?",
  "What are some traditional dishes to try in Uganda?",
  "Can you help me plan a 7-day itinerary for Uganda?",
  "What are some good day trips from Kampala?",
  "How can I spend a weekend in Entebbe?",
  "What are the best outdoor activities in Uganda?",
  "Are there any hidden gems in Mbarara?",
  "What are some family-friendly attractions in Uganda?",
  "What is the best way to get around Kampala?",
  "How can I use public transportation in Uganda?",
  "Are there any reliable taxi apps in Uganda?",
  "Can you recommend some budget hotels in Kampala?",
  "What are the best areas to stay in Kampala?",
  "How do I find last-minute hotel deals in Uganda?",
  "Do I need a visa to travel to Uganda?",
  "How long does it take to renew a passport for travel to Uganda?",
  "What are the entry requirements for Uganda?",
  "Are there any travel advisories for Uganda?",
  "What vaccinations do I need for traveling to Uganda?",
  "How do I get travel insurance for a trip to Uganda?",
  "What are the top travel destinations in Uganda for 2024?",
  "Where are the best places to travel in Uganda during winter?",
  "Can you suggest some eco-friendly travel destinations in Uganda?",
  "What are the best places for adventure travel in Uganda?",
  "Can you recommend some romantic honeymoon destinations in Uganda?",
  "Where are the best places for food lovers to visit in Uganda?"
];

List<String> imageUrlList = [
  "https://www.extremeadventures.co.ug/wp-content/uploads/2023/07/quad-bikes-1-1200.jpg",
  "https://pbs.twimg.com/media/F8AvbCRWUAcfLzM.jpg",
  "https://media-cdn.tripadvisor.com/media/photo-s/0b/1d/51/6f/the-lawns.jpg",
  "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/18/4f/e8/ce/renovated-interior.jpg?w=1200&h=-1&s=1",
  "https://www.silverbackgorillatours.com/wp-content/uploads/2019/03/uganda-national-parks.jpg",
  "https://www.extremeadventures.co.ug/wp-content/uploads/2023/07/go-karting-1-1200.jpg"
];

final List<String> searchSuggestions = [
  'Restaurants',
  'Clubs',
  'Gardens',
  'Experiences',
  'Stays'
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

final List<Map<String, dynamic>> experienceTabCategories = [
  {
    'icon': LucideIcons.album,
    'label': 'All',
  },
  {
    'icon': LucideIcons.vegan,
    'label': 'Art',
  },
  {
    'icon': LineIcons.biking,
    'label': 'Biking',
  },
  {
    'icon': LucideIcons.tent,
    'label': 'Camping',
  },
  {
    'icon': LucideIcons.music,
    'label': 'Concerts',
  },
  {
    'icon': LucideIcons.waves,
    'label': 'Culture',
  },
  {
    'icon': LucideIcons.drumstick,
    'label': 'Foods',
  },
  {
    'icon': LineIcons.hiking,
    'label': 'Hiking',
  },
  {
    'icon': LineIcons.heart,
    'label': 'Health',
  },
  {
    'icon': LineIcons.film,
    'label': 'Movies',
  },
  {
    'icon': LucideIcons.footprints,
    'label': 'Nature',
  },
  {
    'icon': LucideIcons.workflow,
    'label': 'Seminars',
  },
  {
    'icon': LineIcons.binoculars,
    'label': 'Sight Seeing',
  },
  {
    'icon': LucideIcons.activity,
    'label': 'Sports',
  },
];

List<Map<String, dynamic>> bottomNavbar = [
  {'icon': LineIcons.mapPin, 'label': 'Places'},
  {'icon': LineIcons.alternateTicket, 'label': 'Experiences'},
  {'icon': LineIcons.cog, 'label': 'Setup'}
];

List<Map<String, dynamic>> settingsOptions = [
  {
    'title': 'Account',
    'description': 'Email Address\nPhone Number\nNotifications',
    'icon': LucideIcons.user
  },
  // {
  //   'title': 'Preferences',
  //   'description': 'Theme\nLanguage\nInterests',
  //   'icon': LucideIcons.settings
  // },
  {
    'title': 'Privacy',
    'description': 'Terms\nPrivacy\nPermissions',
    'icon': LucideIcons.shield
  },
  {
    'title': 'About',
    'description': 'App Version\nTerms\nPrivacy Policy',
    'icon': LucideIcons.info
  },
  // {
  //   'title': 'About',
  //   'description': 'App Version\nTerms\nPrivacy Policy',
  //   'icon': LucideIcons.info
  // }
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
