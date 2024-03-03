import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../controller/qrscan_controller.dart';

class QrscanPage extends GetView<QrscanController> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late String barcodeData;
  bool te = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                  height: 500,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                    overlay: QrScannerOverlayShape(
                        borderColor: Colors.cyanAccent,
                        borderRadius: 10,
                        borderLength: 20,
                        borderWidth: 10,
                        cutOutSize: MediaQuery.of(context).size.width * 0.8),
                  )),
              Obx(() => Text('${controller.totalResponse}')),

              TextButton(
                  onPressed: () {
                    controller.qrViewController!.pauseCamera();
                  },
                  child: Text('결과 보기')),
              Obx(() => Visibility(
                  visible: (controller.totalResponse.value.isNotEmpty),
                  child: TextButton(
                      onPressed: () {
                        controller.qrViewController!.resumeCamera();
                      },
                      child: Text('결과 확인하기')))),
            ],
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController qrViewController) {

    controller.qrViewController = qrViewController;
    qrViewController!.scannedDataStream.listen((scanData) {
      // QR 스캔됨
      if(te) {
        te = false;
        if (scanData.code!.contains('m.dhlottery.co.kr')) {
          List<String> parts = scanData.code!.split('?');
          barcodeData = parts[1];
          controller.qrViewController!.pauseCamera();
          controller.barcodeResult(barcodeData);
        }
      }
    });
  }

}
