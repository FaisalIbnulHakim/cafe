import 'package:flutter/material.dart';
import 'package:cafe_client/cafe_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

var client = Client('http://192.168.100.19:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

class AddFood extends StatefulWidget {
  static const routeName = "/add-food";
  final TextEditingController urlController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController subController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  List<Cafe>? _cafe;
  Exception? _connectionException;

  Future<void> _createCafe(Cafe cafe) async {
    try {
      await client.cafe.createCafe(cafe);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Data cafe berhasil disimpan."),
          duration: Duration(seconds: 2),
        ),
      );
      // Kembali ke halaman SettingFood setelah simpan berhasil
      Navigator.pop(context);
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

  // final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Food"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
            child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              autofocus: true,
              decoration: InputDecoration(labelText: "Nama"),
              textInputAction: TextInputAction.next,
              controller: widget.namaController,
            ),
            TextFormField(
              autocorrect: false,
              decoration: InputDecoration(labelText: "Harga"),
              textInputAction: TextInputAction.next,
              controller: widget.hargaController,
            ),
            TextFormField(
              autocorrect: false,
              decoration: InputDecoration(labelText: "Sub Judul"),
              textInputAction: TextInputAction.next,
              controller: widget.subController,
            ),
            TextFormField(
              autocorrect: false,
              decoration: InputDecoration(labelText: "Url Image"),
              textInputAction: TextInputAction.next,
              controller: widget.urlController,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _createCafe(
                  Cafe(
                    url: widget.urlController.text,
                    harga: widget.hargaController.text,
                    name: widget.namaController.text,
                    sub: widget.subController.text,
                    jenis: "food",
                  ),
                );
              },
              child: const Text('Save'),
            ),
          ],
        )),
      ),
    );
  }
}
