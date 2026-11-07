
import 'package:flutter/material.dart';
import 'tambah_barang_page.dart';
import 'detail_barang_page.dart';

// Halaman Daftar Barang menggunakan StatefulWidget.
class DaftarBarangPage extends StatefulWidget {
  const DaftarBarangPage({super.key});

  @override
  State<DaftarBarangPage> createState() =>
      _DaftarBarangPageState();
}

class _DaftarBarangPageState extends State<DaftarBarangPage> {

  // Data awal inventaris laboratorium.
  final List<Map<String, dynamic>> daftarBarang = [
    {
      'nama': 'Komputer PC',
      'jumlah': 20,
      'kondisi': 'Baik',
      'ikon': Icons.computer,
    },
    {
      'nama': 'Monitor',
      'jumlah': 20,
      'kondisi': 'Baik',
      'ikon': Icons.desktop_windows,
    },
    {
      'nama': 'Keyboard',
      'jumlah': 20,
      'kondisi': 'Rusak Ringan',
      'ikon': Icons.keyboard,
    },
    {
      'nama': 'Mouse',
      'jumlah': 20,
      'kondisi': 'Baik',
      'ikon': Icons.mouse,
    },
  ];

  // Fungsi membuka halaman Tambah Barang.
  Future<void> tambahBarang() async {
    final hasil = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => const TambahBarangPage(),
      ),
    );

    // Memasukkan data baru ke dalam daftar.
    if (hasil != null && mounted) {
      setState(() {
        hasil['ikon'] = Icons.inventory_2;
        daftarBarang.add(hasil);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Barang'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      // Menampilkan daftar barang.
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: daftarBarang.length,

        itemBuilder: (context, index) {
          final barang = daftarBarang[index];

          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 12),

            // InkWell membuat Card bisa ditekan.
            child: InkWell(
              onTap: () async {
                // Membuka halaman Detail Barang.
                final hasil =
                await Navigator.push<Map<String, dynamic>>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailBarangPage(
                      barang: barang,
                    ),
                  ),
                );

                // Memeriksa hasil edit atau hapus.
                if (hasil != null && mounted) {
                  setState(() {
                    // Jika barang ingin dihapus.
                    if (hasil['hapus'] == true) {
                      daftarBarang.removeAt(index);
                    } else {
                      // Jika barang mengalami perubahan.
                      daftarBarang[index] = {
                        ...daftarBarang[index],
                        ...hasil,
                      };
                    }
                  });
                }
              },

              child: Padding(
                padding: const EdgeInsets.all(12),

                // Row menyusun ikon dan informasi mendatar.
                child: Row(
                  children: [
                    Icon(
                      barang['ikon'],
                      size: 40,
                      color: Colors.green,
                    ),

                    const SizedBox(width: 16),

                    // Column menyusun informasi vertikal.
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            barang['nama'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          Text(
                            'Jumlah: ${barang['jumlah']} unit',
                          ),

                          Text(
                            'Kondisi: ${barang['kondisi']}',
                          ),
                        ],
                      ),
                    ),

                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),

      // Tombol tambah barang.
      floatingActionButton: FloatingActionButton.extended(
        onPressed: tambahBarang,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Barang'),
      ),
    );
  }
}
