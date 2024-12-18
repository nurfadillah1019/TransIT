import 'package:flutter/material.dart';
import 'seat_availability.dart';

class BusSchedulePage extends StatelessWidget {
  final List<Map<String, String>> lastTrips = [
    {'busNumber': 'Bus № 31', 'from': 'MT Haryono', 'to': 'BP', 'price': 'Rp. 15.000'},
    {'busNumber': 'Central Line', 'from': 'Gunung Bakaran', 'to': 'Gunung Sari', 'price': 'Rp. 20.000'},
    {'busNumber': 'Bus № 79', 'from': 'Jl. Sudirman', 'to': 'Kebun Sayur', 'price': 'Rp. 20.000'},
    {'busNumber': 'Tram № 17', 'from': 'Jl. R.Rahayu', 'to': 'BB', 'price': 'Rp. 15.000'},
    {'busNumber': 'Bus № 45', 'from': 'Jl. Imam Bonjol', 'to': 'Manggar', 'price': 'Rp. 18.000'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF608BC1),
        title: Text(
          'Jadwal Bus',
          style: TextStyle(color: Color(0xFFF3F3E0)),
        ),
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
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF133E87),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bus No. 112',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Destinasi: Jl. MT Haryono',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '13:45',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bus', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Destinasi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Waktu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Ketersediaan Kursi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            Divider(),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFCBDCEB),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _buildBusScheduleRow(context, '№ 112', 'Pusat Kota', '13:45'),
                  Divider(),
                  _buildBusScheduleRow(context, '№ 24', 'Bandara', '14:00'),
                  Divider(),
                  _buildBusScheduleRow(context, '№ 36', 'Universitas', '14:20'),
                  Divider(),
                  _buildBusScheduleRow(context, '№ 48', 'BSB', '14:25'),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Bagian perjalanan terakhir dengan ListView.builder
            Text(
              'Perjalanan Terakhir',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Scrollable ListView
            Expanded(
              child: ListView.builder(
                itemCount: lastTrips.length,
                itemBuilder: (context, index) {
                  final trip = lastTrips[index];
                  return Card(
                    elevation: 2.0,
                    margin: EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trip['busNumber']!,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text('Dari: ${trip['from']}', style: TextStyle(fontSize: 14)),
                          Text('Ke: ${trip['to']}', style: TextStyle(fontSize: 14)),
                          SizedBox(height: 8),
                          Text('Harga: ${trip['price']}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusScheduleRow(BuildContext context, String busNumber, String destination, String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(busNumber, style: TextStyle(fontSize: 16)),
        Text(destination, style: TextStyle(fontSize: 16)),
        Text(time, style: TextStyle(fontSize: 16, color: Colors.blue)),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SeatSelectionPage(
                  busNumber: busNumber,
                  time: time,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            backgroundColor: const Color.fromARGB(255, 255, 250, 224),
            minimumSize: Size(90, 36),
          ),
          child: Text(
            'Lihat',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
