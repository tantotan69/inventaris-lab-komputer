
import 'package:flutter/material.dart';
import 'daftar_barang_page.dart';

// Dashboard menggunakan StatelessWidget karena tidak mengelola perubahan data sendiri.
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar adalah bagian judul di atas halaman.
      appBar: AppBar(
        title: const Text('Dashboard Inventaris'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,

        // Tombol Logut admin
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'logout',
            onPressed:(){
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (route) => false,
              );
            },
          )
        ],
      ),

      // LayoutBuilder membantu menyesuaikan tampilan dengan lebar layar.
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Jika lebar layar 600 piksel atau lebih, gunakan tampilan lebar.
          final bool layarLebar = constraints.maxWidth >= 600;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container untuk bagian sambutan.
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      // Gambar komputer dari folder assets.
                      Image.asset(
                        'assets/images/komputer.png',
                        width: layarLebar ? 150 : 100,
                        height: layarLebar ? 150 : 100,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 16),

                      // Column menyusun tulisan secara vertikal.
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selamat Datang!',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Aplikasi Inventaris Laboratorium Komputer',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Ringkasan Inventaris',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                // Grid menyesuaikan jumlah kolom dengan lebar layar.
                GridView.count(
                  crossAxisCount: layarLebar ? 4 : 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: layarLebar ? 1.5 : 1.3,
                  children: [
                    kartuRingkasan(
                      'Total Barang',
                      '80',
                      Icons.inventory,
                    ),
                    kartuRingkasan(
                      'Kondisi Baik',
                      '60',
                      Icons.check_circle,
                    ),
                    kartuRingkasan(
                      'Rusak Ringan',
                      '20',
                      Icons.warning,
                    ),
                    kartuRingkasan(
                      'Rusak Berat',
                      '0',
                      Icons.error,
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Tombol untuk membuka halaman daftar barang.
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DaftarBarangPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.inventory),
                    label: const Text('Lihat Daftar Barang'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(14),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Fungsi untuk membuat kartu ringkasan agar kode tidak berulang.
  Widget kartuRingkasan(String judul, String jumlah, IconData ikon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(ikon, size: 30, color: Colors.green),
          const SizedBox(height: 8),
          Text(
            jumlah,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            judul,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
