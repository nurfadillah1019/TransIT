import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import paket intl
import 'barcode.dart'; // Import BarcodePage

class PaymentPage extends StatefulWidget {
  final List<String> selectedSeats;
  final String busNumber;
  final String time;

  PaymentPage({
    required this.selectedSeats,
    required this.busNumber,
    required this.time,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentMethod = 'QRIS'; // Default is QRIS
  String? selectedEWallet = 'OVO'; // Default E-Wallet is OVO
  String? selectedBank = 'BNI'; // Default Bank is BNI

  // Controllers for form fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  // Format angka menjadi mata uang Rupiah
  String formatRupiah(int number) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatCurrency.format(number);
  }

  @override
  Widget build(BuildContext context) {
    int totalPrice = widget.selectedSeats.length * 20000; // Harga per kursi

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pembayaran',
          style: TextStyle(color: Color(0xFFF3F3E0)),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF608BC1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFF3F3E0)),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Informasi perjalanan
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF133E87),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.directions_bus, color: Colors.white),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bus No. ${widget.busNumber}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.time,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        'Kursi: ${widget.selectedSeats.join(", ")}',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        'Total: ${formatRupiah(totalPrice)}',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Pilihan metode pembayaran
            Text(
              'Pilih Metode Pembayaran',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            RadioListTile<String>(
              title: Text('QRIS'),
              value: 'QRIS',
              groupValue: selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('E-Wallet'),
              value: 'E-Wallet',
              groupValue: selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('Online Banking'),
              value: 'Online Banking',
              groupValue: selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value;
                });
              },
            ),
            SizedBox(height: 20),

            // Menampilkan informasi berdasarkan metode pembayaran yang dipilih
            if (selectedPaymentMethod == 'QRIS')
              Column(
                children: [
                  Text(
                    'QRIS Pembayaran',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Image.asset(
                    'images/frame.png', // Gambar QRIS statik
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 10),
                  Text('Scan kode QR di atas untuk melakukan pembayaran.'),
                ],
              ),
            if (selectedPaymentMethod == 'E-Wallet')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'E-Wallet Pembayaran',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  DropdownButton<String>(
                    value: selectedEWallet,
                    items: [
                      {'name': 'OVO', 'image': 'images/ovo.png'},
                      {'name': 'DANA', 'image': 'images/dana.png'},
                      {'name': 'GoPay', 'image': 'images/gopay.png'},
                    ]
                        .map((wallet) => DropdownMenuItem<String>(
                              value: wallet['name'],
                              child: Row(
                                children: [
                                  Image.asset(
                                    wallet['image']!,
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Text(wallet['name']!),
                                ],
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedEWallet = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                      'Gunakan aplikasi $selectedEWallet Anda untuk menyelesaikan pembayaran.'),
                ],
              ),
            if (selectedPaymentMethod == 'Online Banking')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Online Banking Pembayaran',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  DropdownButton<String>(
                    value: selectedBank,
                    items: [
                      {'name': 'BNI', 'image': 'images/bni.png'},
                      {'name': 'BCA', 'image': 'images/bca.png'},
                      {'name': 'Mandiri', 'image': 'images/mandiri.png'},
                    ]
                        .map((bank) => DropdownMenuItem<String>(
                              value: bank['name'],
                              child: Row(
                                children: [
                                  Image.asset(
                                    bank['image']!,
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Text(bank['name']!),
                                ],
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedBank = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                      'Lakukan transfer ke rekening $selectedBank untuk menyelesaikan pembayaran.'),
                ],
              ),
            SizedBox(height: 20),
// Bagian tombol bayar diubah seperti ini
            if (selectedPaymentMethod == 'E-Wallet' ||
                selectedPaymentMethod == 'Online Banking')
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Langsung navigasi ke BarcodePage tanpa validasi tambahan
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BarcodePage(
                          paymentMethod: selectedPaymentMethod!,
                          selectedOption: selectedPaymentMethod == 'E-Wallet'
                              ? selectedEWallet
                              : selectedPaymentMethod == 'Online Banking'
                                  ? selectedBank
                                  : null,
                          totalAmount: totalPrice,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF608BC1),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    minimumSize: Size(200, 50),
                  ),
                  child: Text(
                    'Bayar ${formatRupiah(totalPrice)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}