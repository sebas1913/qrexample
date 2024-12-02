import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'QR Flutter Demo',
      home: QRGenerator(),
    );
  }
}

class QRGenerator extends StatelessWidget {
  const QRGenerator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userId = "sebas1913";

    // Información del usuario en formato JSON
    Map<String, dynamic> userData = {
      "user": userId,
      "type": "QR",
    };


    String qrData = jsonEncode(userData);

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Flutter Example'),
      ),
      body: Center(
        child: QrImageView(
          data: qrData,
          version: QrVersions.auto,
          size: 260.0,
        ),
      ),
    );
  }
}
