import 'package:flutter/material.dart';

class SeatSelectionPage extends StatefulWidget {
  final String busNumber;
  final String time;

  SeatSelectionPage({required this.busNumber, required this.time});

  @override
  _SeatSelectionPageState createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  List<List<String>> seatStatus = [
    ['A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A'],
    ['F', 'F', 'F', 'A', 'F', 'F', 'A', 'F', 'F', 'A'],
    ['A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A'],
    ['F', 'F', 'F', 'A', 'F', 'F', 'A', 'F', 'F', 'A'],
    ['A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A'],
    ['A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A'],
  ];

  void selectSeat(int row, int col) {
    setState(() {
      if (seatStatus[row][col] == 'A') {
        seatStatus[row][col] = 'S'; // Kursi dipilih
      } else if (seatStatus[row][col] == 'S') {
        seatStatus[row][col] = 'A'; // Batalkan pilihan
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Kursi untuk ${widget.busNumber} pada pukul ${widget.time}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Pilih Kursi Anda',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, // Jumlah kolom
                crossAxisSpacing: 5,
                mainAxisSpacing: 3,
              ),
              itemCount: seatStatus.length * seatStatus[0].length,
              itemBuilder: (context, index) {
                int row = index ~/ seatStatus[0].length; // Menghitung baris
                int col = index % seatStatus[0].length; // Menghitung kolom

                Color color;
                if (seatStatus[row][col] == 'F') {
                  color = Colors.red; // Kursi terisi
                } else if (seatStatus[row][col] == 'S') {
                  color = Colors.green; // Kursi dipilih
                } else {
                  color = Colors.blue; // Kursi kosong
                }

                return GestureDetector(
                  onTap: () {
                    selectSeat(row, col);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        '${String.fromCharCode(65 + row)}${col + 1}', // Menampilkan nomor kursi
                        style: TextStyle(color: Colors.white, fontSize: 12), // Ukuran teks lebih kecil
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
