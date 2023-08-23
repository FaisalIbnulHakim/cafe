import 'package:flutter/material.dart';
import 'package:cafe_client/cafe_client.dart';
import 'package:cafe_flutter/pages/loading_screen.dart';
import 'package:cafe_flutter/food/add_food.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:cafe_flutter/food/edit_food.dart';

var client = Client('http://192.168.100.19:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

class SettingFood extends StatefulWidget {
  static const routeName = "/setting-food";

  @override
  State<SettingFood> createState() => _SettingFoodState();
}

class _SettingFoodState extends State<SettingFood> {
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
      final foodCafe = cafe.where((food) => food.jenis == 'food').toList();
      setState(() {
        _cafe = foodCafe;
      });
    } catch (e) {
      _connectionFailed(e);
    }
  }

  Future<void> _deleteRestoran(Cafe cafe) async {
    try {
      await client.cafe.deleteCafe(cafe);
      await _loadCafe();
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

  Future<void> _navigateToAddFood() async {
    await Navigator.pushNamed(context, AddFood.routeName);
    // Refresh data setelah kembali dari halaman AddFood
    _loadCafe();
  }

  Future<void> _navigateToEditFood(Cafe cafe) async {
    await Navigator.pushNamed(
      context,
      EditFood.routeName,
      arguments: cafe,
    );
    // Refresh data setelah kembali dari halaman EditFood
    _loadCafe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List Food"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _navigateToAddFood,
            ),
          ],
          // leading: Container(),
        ),
        body: _cafe == null
            ? LoadingScreen(
                exception: _connectionException, onTryAgain: _loadCafe)
            : _cafe!.isEmpty
                ? Center(
                    child: Text('Belum ada data yang masuk'),
                  )
                : ListView.builder(
                    itemCount: _cafe!.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              width: 50,
                              height: 50,
                              child: CachedNetworkImage(
                                imageUrl: _cafe![index].url,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Container(
                                  height: 50,
                                  width: 50,
                                  child: Image.network(
                                      "https://www.uclg-planning.org/sites/default/files/styles/featured_home_left/public/no-user-image-square.jpg"),
                                ),
                              ),
                            ),
                          ),
                          title: Text(_cafe![index].name),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                color: Colors.blue,
                                onPressed: () {
                                  _navigateToEditFood(_cafe![index]);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Konfirmasi Hapus'),
                                        content: Text(
                                            'Apakah Anda yakin ingin menghapus menu ini?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Tutup dialog
                                            },
                                            child: Text('Batal'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              Navigator.of(context)
                                                  .pop(); // Tutup dialog
                                              var restoran = _cafe![index];
                                              setState(() {
                                                _cafe!.remove(restoran);
                                              });
                                              await _deleteRestoran(restoran);
                                            },
                                            child: Text('Hapus'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ));
  }
}
