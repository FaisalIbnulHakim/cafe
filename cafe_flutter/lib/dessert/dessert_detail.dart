import 'package:flutter/material.dart';
import 'package:cafe_client/cafe_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import '../pages/bottom_nav.dart';
import '../pages/home.dart';

var client = Client('http://192.168.100.19:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

class DetailDessert extends StatefulWidget {
  static const routeName = "/detail-dessert";

  final Cafe cafe;

  DetailDessert({required this.cafe});

  @override
  State<StatefulWidget> createState() => _DetailDessertState();
}

class _DetailDessertState extends State<DetailDessert> {
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
        title: Text("Detail Dessert"),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 15),
              width: 370,
              height: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  widget.cafe.url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 5),
              child: Text(
                widget.cafe.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: "signika"),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width *
                  0.7, // Set to 70% of screen width
              child: Divider(
                color: Colors.black, // Set the color of the divider
                thickness: 2, // Set the thickness of the divider
              ),
            ),
            SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 30),
              child: Text(
                textAlign: TextAlign.justify,
                widget.cafe.sub,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
              ),
            ),
            SizedBox(height: 7),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: Colors.blue.shade400,
                          fixedSize: Size(150, 40),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart, size: 20),
                            SizedBox(width: 8),
                            Text(
                              "RP. " + widget.cafe.harga,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
