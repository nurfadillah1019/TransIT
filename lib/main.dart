import 'package:flutter/material.dart';
import 'bus_shedule.dart';  

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TransIT',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF608BC1),
        title: Text('TransIT', style: TextStyle(color: Color(0xFFF3F3E0))),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Color(0xFFF3F3E0)),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF133E87),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Text(
                      'A',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Almaira Zahra Khairunnisa',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        'Rp500.000',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Button Grid
            Row(
              children: [
                Expanded(child: _buildButton(context, 'Jadwal Bus', Icons.calendar_month_rounded)),
                SizedBox(width: 16), // Spacer between buttons
                Expanded(child: _buildButton(context, 'Tujuan', Icons.map_rounded)),
              ],
            ),
            SizedBox(height: 16),
            // Tap-In Button
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF133E87),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ingin naik BCT?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Klik tap-in, pilih e-wallet lalu scan QR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.qr_code, color: Color(0xFF133E87), size: 30),
                          SizedBox(width: 8),
                          Text(
                            'Tap-in',
                            style: TextStyle(
                              color: Color(0xFF133E87),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Akun'),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label, IconData icon) {
    return InkWell( // Menggunakan InkWell untuk mendeteksi klik
      onTap: () {
        if (label == 'Jadwal Bus') {
          // Navigasi ke Program 2 (BusSchedulePage) saat tombol "Jadwal Bus" ditekan
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BusSchedulePage()),
          );
        }
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Color(0xFF133E87),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
