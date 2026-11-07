
import 'package:flutter/material.dart';
import 'tambah_barang_page.dart';

// Halaman Detail Barang.
class DetailBarangPage extends StatelessWidget {
  final Map<String, dynamic> barang;

  const DetailBarangPage({
    super.key,
    required this.barang,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Barang'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      // SingleChildScrollView membuat halaman bisa digulir.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Ikon barang.
            Icon(
              barang['ikon'] ?? Icons.inventory_2,
              size: 100,
              color: Colors.green,
            ),

            const SizedBox(height: 20),

            // Nama barang.
            Text(
              barang['nama'].toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // Informasi jumlah barang.
            Text(
              'Jumlah: ${barang['jumlah']}',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 8),

            // Informasi kondisi barang.
            Text(
              'Kondisi: ${barang['kondisi']}',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 40),

            // Tombol Edit Barang.
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  // Membuka form edit dengan membawa data barang.
                  final hasil =
                  await Navigator.push<Map<String, dynamic>>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TambahBarangPage(
                        barang: barang,
                      ),
                    ),
                  );

                  // Jika perubahan disimpan, kirim hasil ke daftar.
                  if (hasil != null && context.mounted) {
                    Navigator.pop(context, hasil);
                  }
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit Barang'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Tombol Hapus Barang.
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  // Menampilkan dialog konfirmasi.
                  final konfirmasi = await showDialog<bool>(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: const Text('Hapus Barang'),
                      content: Text(
                        'Yakin ingin menghapus ${barang['nama']}?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(dialogContext, false);
                          },
                          child: const Text('Batal'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(dialogContext, true);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Hapus'),
                        ),
                      ],
                    ),
                  );

                  // Jika pengguna menyetujui penghapusan.
                  if (konfirmasi == true && context.mounted) {
                    Navigator.pop(context, {'hapus': true});
                  }
                },
                icon: const Icon(Icons.delete),
                label: const Text('Hapus Barang'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
