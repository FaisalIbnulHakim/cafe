import 'package:flutter/material.dart';
import 'package:cafe_client/cafe_client.dart';
import 'package:cafe_flutter/pages/loading_screen.dart';
import 'package:cafe_flutter/drink/add_drink.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cafe_flutter/drink/edit_drink.dart';

var client = Client('http://192.168.100.19:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

class SettingDrink extends StatefulWidget {
  static const routeName = "/setting-drink";

  @override
  State<SettingDrink> createState() => _SettingDrinkState();
}

class _SettingDrinkState extends State<SettingDrink> {
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
      final drinkCafe = cafe.where((drink) => drink.jenis == 'drink').toList();
      setState(() {
        _cafe = drinkCafe;
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

  Future<void> _navigateToAddDrink() async {
    await Navigator.pushNamed(context, AddDrink.routeName);
    // Refresh data setelah kembali dari halaman AddFood
    _loadCafe();
  }

  Future<void> _navigateToEditDrink(Cafe cafe) async {
    await Navigator.pushNamed(
      context,
      EditDrink.routeName,
      arguments: cafe,
    );
    // Refresh data setelah kembali dari halaman EditFood
    _loadCafe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List Drink"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _navigateToAddDrink,
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
                                  _navigateToEditDrink(_cafe![index]);
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
                                            'Apakah Anda yakin ingin menghapus restoran ini?'),
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
