import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:otp/otp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'QR Flutter OTP Demo',
      home: QRGenerator(),
    );
  }
}

class QRGenerator extends StatefulWidget {
  const QRGenerator({Key? key}) : super(key: key);

  @override
  State<QRGenerator> createState() => _QRGeneratorState();
}

class _QRGeneratorState extends State<QRGenerator> {
  late Timer _timer;
  String _qrData = "";
  final String userId = "sebas1913";
  final String otpSecret = "HI893Y23B234H9823Y984Y23H4HJK23HJ4HKJ23HIU4H9283Y4932";

  @override
  void initState() {
    super.initState();
    _generateQRData();
    _startQRUpdateTimer();
  }

  void _generateQRData() {
    String otp = OTP.generateTOTPCodeString(
      otpSecret,
      DateTime.now().millisecondsSinceEpoch,
      interval: 5, // Duración
    );

    // Información del usuario junto con el OTP
    Map<String, dynamic> userData = {
      "user": userId,
      "type": "QR",
      "otp": otp,
    };

    setState(() {
      _qrData = jsonEncode(userData);
    });
  }

  void _startQRUpdateTimer() {
    // Actualiza el QR cada 20 segundos
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _generateQRData();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Flutter OTP Example'),
      ),
      body: Center(
        child: _qrData.isEmpty
            ? const CircularProgressIndicator()
            : QrImageView(
          data: _qrData,
          version: QrVersions.auto,
          size: 260.0,
        ),
      ),
    );
  }
}
