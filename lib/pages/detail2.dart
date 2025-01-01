import 'dart:io';

import 'package:dtt_app/model/HomeModel.dart';
import 'package:dtt_app/model/MapsModel.dart';
import 'package:dtt_app/thema/colors.dart';
import 'package:dtt_app/thema/text_styles.dart';
import 'package:dtt_app/utils/extraInformation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Detail2 extends StatefulWidget {
  @override
  _Detail2State createState() => _Detail2State();
  final MapsModel? location;
  final Home home;
  const Detail2({super.key, required this.home, required this.location});
}

class _Detail2State extends State<Detail2> {
  String desc =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              Hero(
                tag: widget.home.image,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.1,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.home.image),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Positioned(
                  top: 40,
                  left: 10,
                  right: 10,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )),
              Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).size.width,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20)),
                  ))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        widget.home.price.toString(),
                        style: AppTextStyles.title1,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Extrainformation(
                        home: widget.home,
                        currentLocation: widget.location,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text("Description", style: AppTextStyles.title1),
                Text(
                  desc,
                  style: AppTextStyles.detail,
                ),
                SizedBox(height: 20),
                Text("Location", style: AppTextStyles.title1),
                SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          widget.home.latitude.toDouble(),
                          widget.home.longitude.toDouble(),
                        ),
                        zoom: 12,
                      ),
                      onTap: (LatLng location) => _openMap(location),
                      onMapCreated: (GoogleMapController controller) {
                        controller.animateCamera(
                          CameraUpdate.newLatLngZoom(
                            LatLng(
                              widget.home.latitude.toDouble(),
                              widget.home.longitude.toDouble(),
                            ),
                            14,
                          ),
                        );
                      },
                      markers: {
                        Marker(
                          markerId: MarkerId("homeLocation"),
                          position: LatLng(
                            widget.home.latitude.toDouble(),
                            widget.home.longitude.toDouble(),
                          ),
                        ),
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

Future<void> _openMap(LatLng location) async {
  final Uri googleMapUrl = Uri.parse(
    'https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}',
  );
  final Uri appleMapUrl = Uri.parse(
    'http://maps.apple.com/?ll=${location.latitude},${location.longitude}',
  );

  if (Platform.isIOS) {
    if (await canLaunchUrl(appleMapUrl)) {
      await launchUrl(appleMapUrl, mode: LaunchMode.externalApplication);
    }
  } else {
    if (await canLaunchUrl(googleMapUrl)) {
      await launchUrl(googleMapUrl, mode: LaunchMode.externalApplication);
    }
  }
}
