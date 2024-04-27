import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({
    super.key,
  });

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  String _scanBarcode = 'Unknown';

  Future<void> scanBarcodeNormal() async {
    String barcodesScanRes;
    try {
      barcodesScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      debugPrint(barcodesScanRes);
    } on PlatformException {
      barcodesScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodesScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Scan a Barcode'),
        // ),
        body: Builder(builder: (context) {
      return Container(
        alignment: Alignment.center,
        child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ElevatedButton(
              //   onPressed: scanBarcodeNormal,
              //   child: Text('Scan Barcode'),
              // ),
              Text("Coming Soon!\n",
                  style: TextStyle(
                    fontSize: 20,
                    color: AppTheme.nearlyOrange,
                  ))
            ]),
      );
    }));
  }
}
