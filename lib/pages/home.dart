import 'package:dtt_app/thema/colors.dart';
import 'package:dtt_app/thema/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: home(),
    );
  }



  SafeArea home() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("DTT REAL ESTATE", style: AppTextStyles.title1),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: SizedBox(
              height: 48,
              child: SearchBar(
                backgroundColor: WidgetStateProperty.all(AppColors.lightGray), 
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Köşe yarıçapını azaltın
                  ),
                ),
                hintText: "Search for a home",
                trailing: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.search))
                ],
              ),
            ),
          ),
          Expanded(child: listItem()),
        ]),
      ),
    );
  }


    ListView listItem() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      "assets/images/launcher_icon.png",
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\$45.000",
                        style: AppTextStyles.title1,
                      ),
                      Text(
                        "1011KH Raamgrach",
                        style: AppTextStyles.subtitle,
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(right: 48),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/ic_bed.svg',
                                  color: AppColors.mediumGray,
                                  width: 24,
                                  height: 24,
                                ),
                                Text(
                                  "1",
                                  style: AppTextStyles.detail,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/ic_bath.svg',
                                  color: AppColors.mediumGray,
                                  width: 24,
                                  height: 24,
                                ),
                                Text(
                                  "1",
                                  style: AppTextStyles.detail,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/ic_layers.svg',
                                  color: AppColors.mediumGray,
                                  width: 24,
                                  height: 24,
                                ),
                                Text(
                                  "46",
                                  style: AppTextStyles.detail,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/ic_location.svg',
                                  color: AppColors.mediumGray,
                                  width: 24,
                                  height: 24,
                                ),
                                Text(
                                  "15.4 km",
                                  style: AppTextStyles.detail,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
}




