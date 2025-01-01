import 'package:dtt_app/maps/maps.dart';
import 'package:dtt_app/model/HomeModel.dart';
import 'package:dtt_app/model/MapsModel.dart';
import 'package:dtt_app/thema/colors.dart';
import 'package:dtt_app/thema/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Extrainformation extends StatelessWidget {
  final Home home;
  final MapsModel? currentLocation;

  const Extrainformation(
      {super.key, required this.home, required this.currentLocation});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //parametre : imageUrl/text
        item('assets/icons/ic_bed.svg', home.bedrooms.toString()),
        item('assets/icons/ic_bath.svg', home.bathrooms.toString()),
        item('assets/icons/ic_layers.svg', home.size.toString()),

        Expanded(
          flex: 2,
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/ic_location.svg',
                color: AppColors.mediumGray,
                width: 24,
                height: 24,
              ),
              FutureBuilder(
                  future: Maps().findDistance(currentLocation,
                      home.latitude.toDouble(), home.longitude.toDouble()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text(
                        "Error:}",
                        overflow: TextOverflow.ellipsis,
                      );
                    } else if (snapshot.hasData) {
                      return Text(
                        "${snapshot.data!} km",
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.detail,
                      );
                    } else {
                      return Text(
                        "No data",
                        overflow: TextOverflow.ellipsis,
                      );
                    }
                  })
            ],
          ),
        ),
      ],
    );
  }

  Expanded item(String imageUrl, String text) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          SvgPicture.asset(
            imageUrl,
            color: AppColors.mediumGray,
            width: 24,
            height: 24,
          ),
          Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.detail,
          ),
        ],
      ),
    );
  }
}
