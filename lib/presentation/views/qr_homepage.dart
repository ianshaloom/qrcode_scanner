import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../domain/models/myqrcode.dart';
import '../../domain/services/hive_services.dart';
import '../../hive/hive_boxes.dart';
import '../widgets/qr_code_card.dart';
import '../widgets/qr_code_dialog.dart';

class QrHomePage extends StatefulWidget {
  const QrHomePage({super.key});

  @override
  State<QrHomePage> createState() => _QrHomePageState();
}

class _QrHomePageState extends State<QrHomePage> {
  final HiveQrServices _hiveQrServices = HiveQrServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Qr Code Scanner'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: HiveBoxes.mpesaQrCodesBox.listenable(),
        builder: (context, Box<MyQrCode> box, _) {
          if (box.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.qr_code,
                    size: 100,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No Qr Code Saved',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final MyQrCode qrCode = box.getAt(index)!;
              return QrCodeCard(qrCode: qrCode);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () async {
          await scanBarcodeNormal().then((value) {
            if (value == '-1') {
              return value;
            }
            return qrCodeDialog(context, value);
          });
        },
        child: const Icon(Icons.qr_code),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<String> scanBarcodeNormal() async {
    String barcodeScan;

    barcodeScan = await FlutterBarcodeScanner.scanBarcode(
      '#ff7023BD',
      'Cancel',
      true,
      ScanMode.QR,
    );

    if (mounted && barcodeScan != '-1') {}

    return barcodeScan;
  }

  Future<String> qrCodeDialog(BuildContext context, String qrData) async {
    final bool confirm = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => QrCodeDialog(scanResult: qrData),
    );

    if (confirm) {
      // save to hive
      print('save to hive');
      final MyQrCode myQrCode =
          MyQrCode(qrData: qrData, id: generateCode(10), qrType: 'link');

      await _hiveQrServices.saveQrCodeToHive(myQrCode);
    }
    return qrData;
  }

  String generateCode(int length) {
    const String charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    String code = '';

    for (int i = 0; i < length; i++) {
      int randomIndex = random.nextInt(charset.length);
      code += charset[randomIndex];
    }

    return code;
  }
}
