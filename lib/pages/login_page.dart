
import 'package:flutter/material.dart';
import 'dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controller untuk mengambil input pengguna
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Mengatur visibilitas password
  bool isPasswordVisible = false;

  // Fungsi login
  void login() {
    String username = usernameController.text.trim();
    String password = passwordController.text;

    if (username == 'admin' && password == '12345') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardPage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username atau password salah'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Membersihkan controller
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // Bagian judul aplikasi
      appBar: AppBar(
        title: const Text('Inventaris Lab Komputer'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                kToolbarHeight -
                MediaQuery.of(context).padding.top -
                48,
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ikon komputer
              const Icon(
                Icons.computer,
                size: 80,
                color: Colors.green,
              ),

              const SizedBox(height: 16),

              // Nama aplikasi
              const Text(
                'INVENTARIS LAB KOMPUTER',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Nama sekolah
              const Text(
                'SMA IKIP VETERAN III TAMBAKROMO',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // Input username
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),

              const SizedBox(height: 16),

              // Input password dengan ikon mata
              TextField(
                controller: passwordController,

                // Password tersembunyi atau terlihat
                obscureText: !isPasswordVisible,

                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),

                  // Tombol melihat password
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),

                // Login ketika tombol Enter ditekan
                onSubmitted: (_) => login(),
              ),

              const SizedBox(height: 24),

              // Tombol login
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
