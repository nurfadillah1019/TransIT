import 'package:flutter/material.dart';
import 'tap-in.dart';
import 'bus_shedule.dart';
import 'history.dart';

class HomePage extends StatelessWidget {
  // List saldo untuk e-wallet dan bank
  final List<Map<String, String>> balances = [
    {"type": "DANA", "amount": "Rp2.000"},
    {"type": "OVO", "amount": "Rp50.000"},
    {"type": "GoPay", "amount": "Rp10.000"},
    {"type": "BCA", "amount": "Rp100.000"},
    {"type": "Mandiri", "amount": "Rp200.000"},
    {"type": "BNI", "amount": "Rp300.000"},
  ];

  final String userName = "Lee Kyun";

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
      body: _buildHomePage(context),
    );
  }

  Widget _buildHomePage(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi, $userName!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF133E87),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: balances.length,
              itemBuilder: (context, index) {
                return _buildBalanceCard(balances[index]);
              },
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildButton(
                    context, 'Jadwal Bus', Icons.calendar_month_rounded),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildButton(
                    context, 'Riwayat Perjalanan', Icons.map_rounded),
              ),
            ],
          ),
          SizedBox(height: 16),
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
                  'Ingin naik MRT?',
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TapInPage(
                          busNumber: '123',
                          time: '10:00 AM',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.qr_code,
                              color: Color(0xFF133E87), size: 30),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(Map<String, String> balance) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      width: 140,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.account_balance_wallet, color: Colors.blue, size: 30),
          Text(
            balance["type"]!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            balance["amount"]!,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label, IconData icon) {
    return InkWell(
      onTap: () {
        if (label == 'Jadwal Bus') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    BusSchedulePage()), // Navigasi ke halaman Jadwal Bus
          );
        } else if (label == 'Riwayat Perjalanan') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HistoryPage()), // Navigasi ke halaman HistoryPage
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
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
