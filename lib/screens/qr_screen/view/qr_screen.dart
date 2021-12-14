import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sms/core/models/bottom_stateful_screen.dart';
import 'package:sms/core/repository/check_in_repository.dart';
import 'package:sms/core/widgets/bottom_loader_widget.dart';
import 'package:sms/screens/qr_screen/bloc/qr_bloc.dart';
import 'package:sms/screens/qr_screen/bloc/qr_event.dart';
import 'package:sms/screens/qr_screen/bloc/qr_state.dart';

class QRScreen extends BottomStatelessScreen {
  @override
  // TODO: implement bottomBarIcon
  Icon get bottomBarIcon => const Icon(Icons.home);

  @override
  // TODO: implement bottomBarTitle
  String get bottomBarTitle => 'Home';

  @override
  Widget build(BuildContext context) {
    var checkInRepository = CheckInRepository();

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: BlocProvider(
        create: (context) => QRScreenBloc(checkInRepository),
        child: QRScreenWidget(),
      ),
    );
    // QRScreenWidget();
  }
}

class QRScreenWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScreenWidgetState();
}

class _QRScreenWidgetState extends State<QRScreenWidget> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrViewController;
  Barcode? barcode;
  bool canShowQRScanner = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    qrViewController?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    // TODO: implement reassemble
    super.reassemble();
    if (Platform.isAndroid) {
      await qrViewController!.pauseCamera();
    }
    await qrViewController!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QRScreenBloc, QRState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return Scaffold(
              body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              buildQRView(context),
              Positioned(bottom: 10, child: buildResult(
                (state is QRCheckedIn)?state.mess:'Scan a code'
              )),
              Positioned(top: 10, child: buildControlButtons())
            ],
          ));
        });
  }

  Widget buildQRView(BuildContext context) => QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderRadius: 10,
          borderWidth: 10,
          borderLength: 20,
          cutOutSize: MediaQuery.of(context).size.width * 0.8));

  void onQRViewCreated(QRViewController qrViewController) {
    setState(() {
      this.qrViewController = qrViewController;
    });

    qrViewController.scannedDataStream.listen((barcode) {
      context.read<QRScreenBloc>().add(CheckIn(barcode.code));
      setState(() {
        this.barcode = barcode;
      });
    });
  }

  Widget buildResult(String result) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white24),
        child:
        Text(
            barcode != null ? 'Result: $result' : 'Scan a code!',
            maxLines: 3),
      );

  Widget buildControlButtons() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        color: Colors.white24
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () async{
                await qrViewController?.toggleFlash();
                setState(() {});
              },
              icon: FutureBuilder<bool?>(
                future: qrViewController?.getFlashStatus(),
                builder:(context, snapshot){
                  if (snapshot.data!=null){
                    return Icon(
                      snapshot.data! ? Icons.flash_on : Icons.flash_off
                    );
                  } else {
                    return const Icon(Icons.flash_off);
                  }
                    },
              )
          ),
          IconButton(
              onPressed: () async{
                await qrViewController?.flipCamera();
                setState((){});
              },
              icon: FutureBuilder(
                future: qrViewController?.getCameraInfo(),
                builder:(context, snapshot){
                  if (snapshot.data != null){
                    return const Icon(
                        Icons.switch_camera
                    );
                  } else {
                    return Container();
                  }
                },
              )
          ),

        ],
      ),
    );

  }
}
