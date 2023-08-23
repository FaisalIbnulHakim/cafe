import 'package:cafe_client/cafe_client.dart';
import 'package:cafe_flutter/drink/drink_detail.dart';
import 'package:cafe_flutter/drink/edit_drink.dart';
import 'package:cafe_flutter/drink/setting_drink.dart';
import 'package:cafe_flutter/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'dessert/dessert_detail.dart';
import 'drink/add_drink.dart';
import 'food/add_food.dart';
import 'food/edit_food.dart';
import 'food/food_detail.dart';
import 'food/setting_food.dart';
import 'dessert/add_dessert.dart';
import 'dessert/edit_dessert.dart';
import 'dessert/setting_dessert.dart';

// Sets up a singleton client object that can be used to talk to the server from
// anywhere in our app. The client is generated from your server code.
// The client is set up to connect to a Serverpod running on a local server on
// the default port. You will need to modify this to connect to staging or
// production servers.
var client = Client('http://192.168.100.19:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomeStateful(),
      home: HomePage(),
      routes: {
        AddFood.routeName: (context) => AddFood(),
        SettingFood.routeName: (context) => SettingFood(),
        EditFood.routeName: (context) => EditFood(),
        AddDrink.routeName: (context) => AddDrink(),
        SettingDrink.routeName: (context) => SettingDrink(),
        EditDrink.routeName: (context) => EditDrink(),
        AddDessert.routeName: (context) => AddDessert(),
        SettingDessert.routeName: (context) => SettingDessert(),
        EditDessert.routeName: (context) => EditDessert()
      },
      onGenerateRoute: (settings) {
        if (settings.name == DetailFood.routeName) {
          // Menerima objek Restoran yang diteruskan melalui argumen rute
          final cafe = settings.arguments as Cafe?;
          return MaterialPageRoute(
            builder: (context) => DetailFood(cafe: cafe!),
          );
        } else if (settings.name == DetailDrink.routeName) {
          final cafe = settings.arguments as Cafe?;
          return MaterialPageRoute(
            builder: (context) => DetailDrink(cafe: cafe!),
          );
        } else if (settings.name == DetailDessert.routeName) {
          final cafe = settings.arguments as Cafe?;
          return MaterialPageRoute(
            builder: (context) => DetailDessert(cafe: cafe!),
          );
        }
        return null;
      },
    );
  }
}
