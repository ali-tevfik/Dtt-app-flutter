import 'package:dtt_app/thema/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  _InformationState createState() => _InformationState();
}

String desc =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: SafeArea(
        child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About",
                style: AppTextStyles.title1,
              ),
              Text(
                desc,
                style: AppTextStyles.subtitle,
              ),
              Text(
                "Design and Development",
                style: AppTextStyles.title1,
              ),
              SafeArea(
                child: Row(
                  spacing: 16,
                  children: [
                    Image.asset(
                      'assets/images/dtt_banner/hdpi/dtt_banner.png',
                      width: 120,
                      height: 120,
                    ),
                    Column(
                      children: [
                        Text("by DTT"),
                        GestureDetector(
                          child:Text( "d-tt.nl",style: TextStyle(color: Colors.blue),),
                          onTap: () async {
                            final url = "https://www.d-tt.nl/";
                            if(await canLaunchUrl(Uri.parse(url))){
                              await launchUrl(Uri.parse(url));
                            }
                          },
                        )
                      ],
                    )
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
