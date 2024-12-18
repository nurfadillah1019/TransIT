import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String errorMessage = '';

  void register() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        errorMessage = 'Semua field harus diisi!';
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        errorMessage = 'Password dan Konfirmasi Password tidak cocok!';
      });
      return;
    }

    try {
      // Simpan data pengguna ke Firebase Firestore
      final userDoc = FirebaseFirestore.instance.collection('users').doc(username);

      // Periksa apakah username sudah digunakan
      final snapshot = await userDoc.get();
      if (snapshot.exists) {
        setState(() {
          errorMessage = 'Username sudah digunakan!';
        });
        return;
      }

      // Simpan data pengguna
      await userDoc.set({
        'username': username,
        'password': password, // Simpan hash password untuk keamanan
      });

      // Kembali ke halaman login
      Navigator.pop(context);
    } catch (e) {
      setState(() {
        errorMessage = 'Terjadi kesalahan: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Konfirmasi Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 18, color: Colors.white),
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
