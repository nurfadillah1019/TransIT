import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final List<Map<String, String>> trips = [
    {
      'title': 'Bus Nº 31',
      'from': '72-74 Oxford St.',
      'to': '20 Grosvenor Sq.',
      'time': 'Today / 16:00',
      'price': '10000'
    },
    {
      'title': 'Central Line',
      'from': 'Great Portland St.',
      'to': 'Baker Street',
      'time': 'Today / 16:15',
      'price': '5000'
    },
    {
      'title': 'Tram Nº 17',
      'from': '377 Durnsford Rd.',
      'to': '136 Buckhold Rd.',
      'time': 'Today / 16:15',
      'price': '5000'
    },
  ];

  // Tracking favorit status
  List<bool> favoriteStatus = [false, false, false];
  List<Map<String, String>> favoriteTrips = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF608BC1),
        title: Text(
          'Riwayat Perjalanan',
          style: TextStyle(color: Color(0xFFF3F3E0)),
        ),
      ),
      body: ListView.builder(
        itemCount: trips.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[300],
                        image: DecorationImage(
                          image: AssetImage('images/bus.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trips[index]['title']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'From: ${trips[index]['from']!}',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[700]),
                          ),
                          Text(
                            'To: ${trips[index]['to']!}',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[700]),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.access_time,
                                  size: 16, color: Colors.grey[600]),
                              SizedBox(width: 4),
                              Text(
                                trips[index]['time']!,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Price: Rp ${trips[index]['price']!}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
