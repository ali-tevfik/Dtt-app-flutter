import 'dart:convert';

import 'package:dtt_app/model/HomeModel.dart';
import 'package:http/http.dart' as http;

class HomeApi {
  final url = "https://intern.d-tt.nl/api/house";

  Future<List<Home>> getHome() async {
    final response = await http.get(Uri.parse(url),
        headers: {'Access-Key': ''});

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<Home> homes = data.map((item) => Home.fromJson(item)).toList();
      return homes;
    } else {
      throw Exception("Failed to load homes");
    }
  }
}
