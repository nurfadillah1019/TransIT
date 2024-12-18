import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk format Rupiah

class BarcodePage extends StatelessWidget {
  final String paymentMethod;
  final String? selectedOption; // E-Wallet atau Bank
  final int totalAmount;

  BarcodePage({
    required this.paymentMethod,
    this.selectedOption,
    required this.totalAmount,
  });

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
    // Peta untuk gambar barcode berdasarkan metode pembayaran
    final Map<String, String> barcodeImages = {
      'QRIS': 'images/frame.png',
      'OVO': 'images/frame.png',
      'DANA': 'images/frame.png',
      'GoPay': 'images/frame.png',
      'BNI': 'images/frame.png',
      'BCA': 'images/frame.png',
      'Mandiri': 'images/frame.png',
    };

    // Tentukan gambar barcode yang akan digunakan
    String? barcodeImage = barcodeImages[selectedOption ?? paymentMethod];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Barcode Pembayaran',
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pastikan Saldo Anda Mencukupi',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              if (barcodeImage != null)
                Image.asset(
                  barcodeImage,
                  width: 350,
                  height: 350,
                  fit: BoxFit.contain,
                )
              else
                Text(
                  'Barcode tidak tersedia untuk metode ini.',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              SizedBox(height: 20),
              Text(
                'Silahkan scan barcode ini di mesin scanner',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
