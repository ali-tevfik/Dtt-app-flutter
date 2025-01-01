import 'package:dtt_app/SplashScreen/splashScreen.dart';
import 'package:dtt_app/pages/home.dart';
import 'package:dtt_app/pages/information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import './thema/colors.dart';
import './thema/text_styles.dart';

void main() {
  
  runApp(Sizer(builder: (context, orientation, deviceType) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.darkGray,
        primaryColor: AppColors.lightGrayOpacity,
        textTheme: TextTheme(
          headlineLarge: AppTextStyles.title1,
          headlineMedium: AppTextStyles.title2,
          headlineSmall: AppTextStyles.title3,
        ),
      ),
      home: Splashscreen(),
    );
  }));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

List<StatefulWidget> _pages = [HomePage(), Information()];

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.red,
          unselectedItemColor: AppColors.darkGray,
          backgroundColor: AppColors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: 0,
          onTap: (index) => {
                setState(() {
                  _currentIndex = index;
                })
              },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/ic_home.svg',
                color: _currentIndex == 0 ? Colors.black : AppColors.mediumGray,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/ic_info.svg',
                color: _currentIndex == 1 ? Colors.black : AppColors.mediumGray,
              ),
              label: 'Information',
            ),
          ]),
      body: _pages[_currentIndex],
    );
  }
}
