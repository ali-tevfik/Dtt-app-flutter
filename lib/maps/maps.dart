import 'package:dtt_app/model/MapsModel.dart';
import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:geolocator/geolocator.dart';

class Maps {
  Future<bool> permissionCheck() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request permission if denied
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      // Handle the case where permission is denied forever
      return false;
    } else {
      return true;
    }
  }

  Future<MapsModel?> findMyLocation() async {
    if (await permissionCheck() == true) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print("permission check true");
      return MapsModel(
          latitude: position.latitude, longitude: position.longitude);
    } else {
      print("permission check false");
      return null;
    }
  }

  Future<String> findDistance(
      MapsModel? position, double lat2, double lon2) async {
    final flutterMapMath = FlutterMapMath();
    if (position == null) {
      return "0";
    }
    return flutterMapMath
        .distanceBetween(position.latitude.toDouble(),
            position.longitude.toDouble(), lat2, lon2, "km")
        .toStringAsFixed(1);
  }
}
