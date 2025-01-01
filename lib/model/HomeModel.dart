import 'package:intl/intl.dart';

class Home {
  final int id;
  final String image;
  final String price;
  final int bedrooms;
  final int bathrooms;
  final int size;
  final String description;
  final String zip;
  final String city;
  final int latitude;
  final int longitude;
  final String createdDate;

  Home({
    required this.id,
    required this.image,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.size,
    required this.description,
    required this.zip,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.createdDate,
  });

  factory Home.fromJson(Map<String, dynamic> json) {
    final baseUrl = "https://intern.d-tt.nl/";

    return Home(
        id: json['id'],
        image: "$baseUrl/${json['image']}",
        price: "\$${NumberFormat("#,###").format(json['price'])}",
        bedrooms: json['bedrooms'],
        bathrooms: json['bathrooms'],
        size: json['size'],
        description: json['description'],
        zip: json['zip'],
        city: json['city'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        createdDate: json['createdDate']);
  }
}
