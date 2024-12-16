import 'package:dtt_app/pages/home.dart';
import 'package:dtt_app/pages/information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import './thema/colors.dart';
import './thema/text_styles.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: AppColors.darkGray,
      primaryColor: AppColors.lightGrayOpacity,
      textTheme: TextTheme(
        headlineLarge: AppTextStyles.title1,
        headlineMedium: AppTextStyles.title2,
        headlineSmall: AppTextStyles.title3,
      ),
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

List<StatefulWidget> _pages = [HomePage(),Information()];
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
          onTap: (index)=>{
            setState(() {
              _currentIndex=index;
            })
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/ic_home.svg'),
                label: 'Home',
                backgroundColor: AppColors.red),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/ic_info.svg'),
                label: 'Information',
                backgroundColor: AppColors.darkGray),
          ]),
      body: _pages[_currentIndex],
    );
  }




}
