import 'package:flutter/material.dart';
import 'package:cafe_client/cafe_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

var client = Client('http://192.168.100.19:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

class EditFood extends StatefulWidget {
  static const routeName = "/edit-food";
  final TextEditingController urlController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController subController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();

  @override
  State<EditFood> createState() => _EditFoodState();
}

class _EditFoodState extends State<EditFood> {
  List<Cafe>? _cafe;

  Cafe? _cafes;
  Exception? _connectionException;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Mengambil data restoran dari arguments
    _cafes = ModalRoute.of(context)?.settings.arguments as Cafe?;

    // Mengisi data pada controller sesuai data yang ada
    widget.urlController.text = _cafes?.url ?? '';
    widget.namaController.text = _cafes?.name ?? '';
    widget.subController.text = _cafes?.sub ?? '';
    widget.hargaController.text = _cafes?.harga ?? '';
  }

  Future<void> _updateCafe(Cafe cafe) async {
    try {
      await client.cafe.updateCafe(cafe);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Data cafe berhasil diubah."),
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
    // Tangani error koneksi di sini
    setState(() {
      _cafe = null;
      _connectionException = exception;
      // Set nilai _connectionException jika diperlukan
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Food"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          // Tambahkan key jika Anda membutuhkannya
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
                onPressed: () async {
                  final updatedRestoran = Cafe(
                    id: _cafes?.id, // Pastikan id dari restoran diatur
                    url: widget.urlController.text,
                    name: widget.namaController.text,
                    sub: widget.subController.text,
                    harga: widget.hargaController.text,
                    jenis: "food",
                  );

                  await _updateCafe(
                      updatedRestoran); // Kirim perubahan ke server
                },
                child: const Text('Ubah'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
