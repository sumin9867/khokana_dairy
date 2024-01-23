import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/introduction.dart';
import 'package:intro_screen_onboarding_flutter/introscreenonboarding.dart';
import 'package:phonetest/Screen/userhome.dart';
import 'package:phonetest/auth/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatelessWidget {
  final List<Introduction> list = [
    Introduction(
      imageUrl: 'images/search.png',
      title: 'Search',
      subTitle: 'Enter the name, category, or location in the search bar.',
    ),
    Introduction(
      title: 'Browse',
      subTitle:
          'Explore the categorized business listings for specific industries.',
      imageUrl: 'images/browse.png',
    ),
    Introduction(
      title: 'Connect',
      subTitle: 'Click on the phone icon to dial directly from the directory.',
      imageUrl: 'images/connect.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      // Check if the user is already logged in
      future: isLoggedIn(),
      builder: (context, snapshot) {
        print("isLoggedIn: ${snapshot.data}");
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading indicator or some placeholder while checking login status
          return CircularProgressIndicator();
        } else {
          if (snapshot.data == true) {
            // User is already logged in, navigate to home page
            return UserHomepage(); // Replace with your home page widget
          } else {
            // User is not logged in, show onboarding screen
            return IntroScreenOnboarding(
              backgroudColor: Color.fromARGB(255, 255, 255, 255),
              foregroundColor: Color.fromARGB(255, 52, 107, 237),
              introductionList: list,
              onTapSkipButton: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              ),
              skipTextStyle: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 18,
              ),
            );
          }
        }
      },
    );
  }

  // Function to check if the user is already logged in
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    print('isLoggedIn: $isLoggedIn');
    return isLoggedIn;
  }
}
