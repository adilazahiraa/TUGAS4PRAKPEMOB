import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart'; // Pastikan import model Produk
import 'package:tokokita/ui/produk_form.dart'; // Pastikan import ProdukForm

class ProdukDetail extends StatefulWidget {
  final Produk? produk;

  ProdukDetail({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk Adila'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kode Produk
            Text(
              "Kode: ${widget.produk?.kodeProduk ?? '-'}",
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 8),
            
            // Nama Produk
            Text(
              "Nama: ${widget.produk?.namaProduk ?? '-'}",
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8),
            
            // Harga Produk
            Text(
              "Harga: Rp. ${widget.produk?.hargaProduk?.toString() ?? '-'}",
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20),
            
            // Tombol Hapus dan Edit
            _tombolHapusEdit(),
          ],
        ),
      ),
    );
  }

  // Widget untuk menampilkan tombol Hapus dan Edit
  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdukForm(produk: widget.produk),
              ),
            );
          },
        ),
        
        const SizedBox(width: 8),
        
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  // Konfirmasi penghapusan produk
  void confirmHapus() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konfirmasi"),
          content: const Text("Yakin ingin menghapus data ini?"),
          actions: [
            // Tombol Ya untuk menghapus
            OutlinedButton(
              child: const Text("Ya"),
              onPressed: () {
                // TODO: Tambahkan logika hapus produk
                Navigator.pop(context); // Menutup dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Produk berhasil dihapus")),
                );
              },
            ),
            
            // Tombol Batal
            OutlinedButton(
              child: const Text("Batal"),
              onPressed: () => Navigator.pop(context), // Menutup dialog
            ),
          ],
        );
      },
    );
  }
}
