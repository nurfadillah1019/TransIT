import 'package:flutter/material.dart';
import 'seat_availability.dart';

class BusSchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF608BC1),
        title: Text(
          'Bus Schedule',
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
                        'Destination: City Center',
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
                Text('Destination', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Time', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Seat Availability', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
                  _buildBusScheduleRow(context, '№ 112', 'City center', '13:45'),
                  Divider(),
                  _buildBusScheduleRow(context, '№ 24', 'Airport', '14:00'),
                  Divider(),
                  _buildBusScheduleRow(context, '№ 36', 'University', '14:20'),
                  Divider(),
                  _buildBusScheduleRow(context, '№ 48', 'Shopping Mall', '14:25'),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Bagian "Your Last Trips"
            Text(
              'Your Last Trips',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Jumlah item per baris
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.3, 
                children: [
                  _buildTripCard('Bus № 31', 'MT Haryono', 'BP', 'Rp. 15.000'),
                  _buildTripCard('Central Line', 'Gunung Bakaran', 'Gunung Sari', 'Rp. 20.000'),
                  _buildTripCard('Bus № 79', 'Jl. Sudirman', 'Kebun Sayur', 'Rp. 20.000'),
                  _buildTripCard('Tram № 17', 'Jl. R.Rahayu', 'BB', 'Rp. 15.000'),
                ],
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
            // Navigasi ke halaman SeatSelectionPage
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
            'Show',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildTripCard(String busNumber, String from, String to, String price) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              busNumber,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('From: $from', style: TextStyle(fontSize: 14)),
            Text('To: $to', style: TextStyle(fontSize: 14)),
            SizedBox(height: 8),
            Text('Price: $price', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
