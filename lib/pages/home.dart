import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dtt_app/API/api.dart';
import 'package:dtt_app/maps/maps.dart';
import 'package:dtt_app/model/HomeModel.dart';
import 'package:dtt_app/model/MapsModel.dart';
import 'package:dtt_app/pages/detail2.dart';
import 'package:dtt_app/thema/colors.dart';
import 'package:dtt_app/thema/text_styles.dart';
import 'package:dtt_app/utils/extraInformation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Home>> futuresHomes;
  late Future<MapsModel?> myLocation;
  MapsModel? currentLocation;
  final TextEditingController _searcBarController = TextEditingController();
  List<Home> _filteredItems = [];
  bool isSearchResult = false;
  late ConnectivityResult _connectivityResult;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivityStreamSubscription;
  bool _hasInternet = false;

  void _onConnectivityChanged(ConnectivityResult result) {
    setState(() {
      _connectivityResult = result;
    });

    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      setState(() {
        _hasInternet = true;
        myLocation = Maps().findMyLocation();
        futuresHomes = HomeApi().getHome();
      });
    } else {
      print('No internet connection!');
      setState(() {
        _hasInternet = false;
      });
    }
  }

  Future<void> _checkInitialConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      setState(() {
        _connectivityResult = result;
        _hasInternet = (result == ConnectivityResult.wifi ||
            result == ConnectivityResult.mobile);
      });
    } catch (e) {
      print('Connection error : $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _checkInitialConnectivity();
    _connectivityStreamSubscription =
        _connectivity.onConnectivityChanged.listen(_onConnectivityChanged);
  }

  @override
  void dispose() {
    _connectivityStreamSubscription.cancel();
    super.dispose();
  }

  void _filterItems(String query, List<Home> searchHome) {
    setState(() {
      _filteredItems = searchHome.where((home) {
        return home.zip.toUpperCase().replaceAll(' ', '').contains(query) ||
            home.city.toUpperCase().contains(query);
      }).toList();
      isSearchResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasInternet) {
      return Scaffold(
        body: Center(child: Text('No internet Connection! Retry..')),
      );
    } else {
      return Scaffold(
        body: FutureBuilder(
          future: myLocation,
          builder: (context, locationSnapshot) {
            if (locationSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (locationSnapshot.hasError) {
              return Center(child: Text("Error loading location"));
            } else if (!locationSnapshot.hasData) {
              return Center(child: Text("No location data available"));
            }
            currentLocation = locationSnapshot.data;

            return FutureBuilder(
              future: futuresHomes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else {
                  List<Home> sortedHomes = List.from(snapshot.data!);
                  sortedHomes.sort((a, b) => a.price.compareTo(b.price));

                  if (_filteredItems.isEmpty && !isSearchResult) {
                    _filteredItems = sortedHomes;
                  }

                  return home(sortedHomes);
                }
              },
            );
          },
        ),
      );
    }
  }

  SafeArea home(List<Home> list) {
    return SafeArea(
      child: SizedBox(
        width: Adaptive.w(100),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("DTT REAL ESTATE", style: AppTextStyles.title1),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: SizedBox(
                  height: 48,
                  child: SearchBar(
                    onChanged: (value) {
                      _filterItems(
                          value.toUpperCase().replaceAll(" ", ''), list);
                    },
                    controller: _searcBarController,
                    backgroundColor:
                        WidgetStateProperty.all(AppColors.lightGray),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget listItem() {
    if (_filteredItems.isEmpty) {
      return Center(
        child: Image.asset('assets/images/search_state_empty.png'),
      );
    } else {
      return ListView.builder(
        padding: EdgeInsets.only(top: 16),
        itemCount: _filteredItems.length,
        itemBuilder: (context, index) {
          final home = _filteredItems[index];
          return Hero(
            tag: home.image,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Detail2(
                      home: _filteredItems[index],
                      location: currentLocation,
                    ),
                  ),
                );
              },
              child: Card(
                color: AppColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(1),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.network(
                            home.image,
                            fit: BoxFit.cover,
                            width: Adaptive.w(20),
                            height: Adaptive.h(10),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              home.price,
                              style: AppTextStyles.title1,
                            ),
                            Text(
                              "${home.zip} ${home.city}",
                              style: AppTextStyles.subtitle,
                            ),
                            SizedBox(height: 16),
                            Extrainformation(
                                home: home, currentLocation: currentLocation),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
