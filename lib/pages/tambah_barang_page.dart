import 'package:flutter/material.dart';

// Halaman ini bisa digunakan untuk Tambah maupun Edit Barang.
class TambahBarangPage extends StatefulWidget {
  final Map<String, dynamic>? barang;

  const TambahBarangPage({super.key, this.barang});

  @override
  State<TambahBarangPage> createState() => _TambahBarangPageState();
}

class _TambahBarangPageState extends State<TambahBarangPage> {
  // Controller untuk membaca input.
  final namaController = TextEditingController();
  final jumlahController = TextEditingController();

  String kondisi = 'Baik';

  // Memeriksa apakah halaman sedang digunakan untuk mengedit.
  bool get modeEdit => widget.barang != null;

  @override
  void initState() {
    super.initState();

    // Jika ada data barang, masukkan ke dalam form.
    if (modeEdit) {
      namaController.text = widget.barang!['nama'].toString();
      jumlahController.text = widget.barang!['jumlah'].toString();
      kondisi = widget.barang!['kondisi'].toString();
    }
  }

  // Fungsi menyimpan atau memperbarui barang.
  void simpanBarang() {
    String nama = namaController.text.trim();
    String jumlah = jumlahController.text.trim();

    if (nama.isEmpty || jumlah.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama dan jumlah barang harus diisi')),
      );
      return;
    }

    int? jumlahBarang = int.tryParse(jumlah);

    if (jumlahBarang == null || jumlahBarang <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jumlah harus berupa angka lebih dari 0')),
      );
      return;
    }

    // Mengembalikan data ke halaman sebelumnya.
    Navigator.pop(context, {
      'nama': nama,
      'jumlah': jumlahBarang,
      'kondisi': kondisi,
    });
  }

  @override
  void dispose() {
    namaController.dispose();
    jumlahController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(modeEdit ? 'Edit Barang' : 'Tambah Barang'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  kToolbarHeight -
                  MediaQuery.of(context).padding.top -
                  40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Input nama barang.
                TextField(
                  controller: namaController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Nama Barang',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.computer),
                  ),
                ),

                const SizedBox(height: 16),

                // Input jumlah barang.
                TextField(
                  controller: jumlahController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'Jumlah Barang',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.numbers),
                  ),
                ),

                const SizedBox(height: 16),

                // Pilihan kondisi barang.
                DropdownButtonFormField<String>(
                  initialValue: kondisi,
                  decoration: const InputDecoration(
                    labelText: 'Kondisi Barang',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Baik', 'Rusak Ringan', 'Rusak Berat'].map((item) {
                    return DropdownMenuItem(value: item, child: Text(item));
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        kondisi = value;
                      });
                    }
                  },
                ),

                const SizedBox(height: 24),

                // Tombol Simpan atau Update.
                ElevatedButton.icon(
                  onPressed: simpanBarang,
                  icon: Icon(modeEdit ? Icons.update : Icons.save),
                  label: Text(modeEdit ? 'UPDATE BARANG' : 'SIMPAN BARANG'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
