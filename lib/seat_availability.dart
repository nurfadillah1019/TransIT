import 'package:flutter/material.dart';
import 'payment_page.dart'; // Import PaymentPage

class SeatSelectionPage extends StatefulWidget {
  final String busNumber;
  final String time;

  SeatSelectionPage({required this.busNumber, required this.time});

  @override
  _SeatSelectionPageState createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  List<List<String>> seatStatus = [
    ['A', 'A', 'F', '', 'F', 'F'],
    ['A', 'F', 'A', '', 'A', 'A'],
    ['A', 'F', 'F', '', 'A', 'F'],
    ['A', 'A', 'A', '', 'A', 'A'],
    ['A', 'A', 'A', '', 'F', 'A'],
    ['A', 'A', 'A', '', 'F', 'A'],
    ['A', 'A', 'A', '', 'F', 'A'],
    ['', '', '', '', 'F', 'A'],
    ['F', 'F', 'F', 'F', 'F', 'F'],
  ];

  bool isSeatSelected = false;
  List<String> selectedSeats = [];

  void selectSeat(int row, int col) {
    if (seatStatus[row][col] == 'A') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi Pilihan'),
            content: Text(
                'Apakah Anda yakin ingin memilih kursi ${String.fromCharCode(65 + row)}${col + 1}?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Batal'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    seatStatus[row][col] = 'S';
                    selectedSeats.add('${String.fromCharCode(65 + row)}${col + 1}');
                    isSeatSelected = true;
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Pilih'),
              ),
            ],
          );
        },
      );
    } else if (seatStatus[row][col] == 'S') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi Pembatalan'),
            content: Text(
                'Apakah Anda yakin ingin membatalkan pemilihan kursi ${String.fromCharCode(65 + row)}${col + 1}?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tidak'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    seatStatus[row][col] = 'A';
                    selectedSeats.remove('${String.fromCharCode(65 + row)}${col + 1}');
                    isSeatSelected = selectedSeats.isNotEmpty;
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Iya'),
              ),
            ],
          );
        },
      );
    } else if (seatStatus[row][col] == 'F') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Kursi Tidak Tersedia'),
            content: Text(
                'Kursi ${String.fromCharCode(65 + row)}${col + 1} sudah terisi. Silakan pilih kursi lainnya.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tutup'),
              ),
            ],
          );
        },
      );
    }
  }

  void proceedToPayment() {
    if (selectedSeats.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tidak ada kursi yang dipilih!')),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi Pembayaran'),
            content: Text(
                'Anda telah memilih ${selectedSeats.length} kursi: ${selectedSeats.join(', ')}.\nApakah Anda ingin melanjutkan ke pembayaran?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Batal'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(
                        selectedSeats: selectedSeats,
                        busNumber: widget.busNumber,
                        time: widget.time,
                      ),
                    ),
                  ); // Navigate to PaymentPage
                },
                child: Text('Lanjutkan Pembayaran'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pilih Kursi untuk ${widget.busNumber} pada pukul ${widget.time}',
          style: TextStyle(fontSize: 18, color: Color(0xFFF3F3E0)),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (selectedSeats.isEmpty) {
              Navigator.pop(context); // Langsung kembali jika tidak ada kursi dipilih
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Konfirmasi Keluar'),
                    content: Text(
                        'Anda telah memilih kursi: ${selectedSeats.join(', ')}.\nKeluar akan membatalkan pilihan Anda. Apakah Anda yakin?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Tutup dialog
                        },
                        child: Text('Tidak'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Tutup dialog
                          Navigator.pop(context); // Kembali ke halaman sebelumnya
                        },
                        child: Text('Keluar'),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Color(0xFFF3F3E0)),
            onPressed: () {
              // Aksi untuk ikon notifikasi
            },
          ),
        ],
        backgroundColor: Color(0xFF608BC1),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Pilih Kursi Anda',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: seatStatus.length * seatStatus[0].length,
                itemBuilder: (context, index) {
                  int row = index ~/ seatStatus[0].length;
                  int col = index % seatStatus[0].length;

                  if (seatStatus[row][col] == '') {
                    return Container();
                  }

                  Color color;
                  if (seatStatus[row][col] == 'F') {
                    color = Colors.red;
                  } else if (seatStatus[row][col] == 'S') {
                    color = Colors.green;
                  } else {
                    color = Colors.blue;
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
                          '${String.fromCharCode(65 + row)}${col + 1}',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.red,
                    ),
                    SizedBox(width: 8),
                    Text('Tidak Tersedia'),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 8),
                    Text('Tersedia'),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.green,
                    ),
                    SizedBox(width: 8),
                    Text('Dipilih'),
                  ],
                ),
              ],
            ),
          ),
          if (selectedSeats.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  onPressed: proceedToPayment,
                  child: Text('Lanjutkan Pembayaran', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
