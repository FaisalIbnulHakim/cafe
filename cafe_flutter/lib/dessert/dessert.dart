import 'package:flutter/material.dart';
import 'package:cafe_flutter/dessert/setting_dessert.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:cafe_client/cafe_client.dart';

import '../pages/bottom_nav.dart';
import '../pages/home.dart';
import '../pages/loading_screen.dart';
import 'dessert_detail.dart';

var client = Client('http://192.168.100.19:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

class Dessert extends StatefulWidget {
  static const routeName = "/dessert";

  @override
  State<Dessert> createState() => _DessertState();
}

class _DessertState extends State<Dessert> {
  List<Cafe>? _cafe;

  // If the connection to the server fails, this field will hold the exception
  // that was thrown.
  Exception? _connectionException;
  @override
  void initState() {
    super.initState();
    _loadCafe();
  }

  Future<void> _loadCafe() async {
    try {
      final cafe = await client.cafe.getAllCafe();
      final dessertCafe =
          cafe.where((dessert) => dessert.jenis == 'dessert').toList();
      setState(() {
        _cafe = dessertCafe;
      });
    } catch (e) {
      _connectionFailed(e);
    }
  }

  void _connectionFailed(dynamic exception) {
    // If the connection to the server fails, we clear the list of notes and
    // store the exception that was thrown. This will make the loading screen
    // appear and show a button to try again.

    // In a real app you would probably want to do more complete error handling.
    setState(() {
      _cafe = null;
      _connectionException = exception;
    });
  }

  @override
  void didUpdateWidget(covariant Dessert oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Panggil _loadCafe() setiap kali widget diperbarui (kembali dari SettingFood)
    _loadCafe();
  }

  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    // CartPage(),
    // ProfilePage(),
  ];

  void _onTabTapped(int index) {
    if (index == 0) {
      setState(() {
        _currentIndex = index;
      });
      if (index == 0) {
        // Navigate to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dessert"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async {
              // Navigasi ke halaman SettingFood dan tunggu sampai selesai
              await Navigator.pushNamed(context, SettingDessert.routeName);
              // Setelah kembali dari SettingFood, panggil _loadCafe() untuk penyegaran data
              _loadCafe();
            },
          ),
        ],
        // leading: Container(),
      ),
      backgroundColor: Color.fromARGB(255, 225, 225, 225),
      body: _cafe == null
          ? LoadingScreen(
              exception: _connectionException, onTryAgain: _loadCafe)
          : _cafe!.isEmpty
              ? Center(
                  child: Text('Belum ada data yang masuk'),
                )
              : Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: GridView.builder(
                    itemCount: _cafe!.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 10,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.only(right: 8, left: 8, top: 12),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    _cafe![index].url,
                                    height: 110,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          _cafe![index].name,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Signika"),
                                        ),
                                      ),
                                      // Divider(
                                      //   color: Colors.black,
                                      //   thickness: 1.0,
                                      // ),
                                      SizedBox(height: 2),
                                      Text(
                                        "RP. " + _cafe![index].harga,
                                        textAlign: TextAlign.left,
                                        // maxLines: 3,
                                        // overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Signika",
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Container(
                                        margin: EdgeInsets.only(top: 10.5),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              DetailDessert.routeName,
                                              arguments: _cafe![index],
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            backgroundColor:
                                                Colors.blue.shade400,
                                          ),
                                          child: Text("Detail"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 11 / 15,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 15,
                    ),
                  ),
                ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
