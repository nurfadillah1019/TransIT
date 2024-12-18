import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseConnectionPage extends StatefulWidget {
  const FirebaseConnectionPage({Key? key}) : super(key: key);

  @override
  _FirebaseConnectionPageState createState() => _FirebaseConnectionPageState();
}

class _FirebaseConnectionPageState extends State<FirebaseConnectionPage> {
  String _connectionStatus = "Checking connection...";
  late DatabaseReference _testRef;

  @override
  void initState() {
    super.initState();
    _testRef = FirebaseDatabase.instance.ref("test_connection");
    _checkFirebaseConnection();
  }

  Future<void> _checkFirebaseConnection() async {
    try {
      // Attempt to write data to Firebase
      await _testRef.set("connected");

      // Attempt to read the written data back
      final snapshot = await _testRef.get();
      if (snapshot.exists && snapshot.value == "connected") {
        setState(() {
          _connectionStatus = "Firebase is successfully connected!";
        });
      } else {
        setState(() {
          _connectionStatus = "Connection test failed: Data mismatch.";
        });
      }
    } catch (e) {
      setState(() {
        _connectionStatus = "Failed to connect to Firebase: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Connection Test"),
        backgroundColor: const Color(0xFF4A235A),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_done,
              size: 80,
              color: Colors.purple,
            ),
            const SizedBox(height: 20),
            Text(
              _connectionStatus,
              style: const TextStyle(fontSize: 18, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
