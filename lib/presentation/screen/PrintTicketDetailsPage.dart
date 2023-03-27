import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart' hide Image;
import 'package:flutter/services.dart';

import 'package:blue_print_pos/blue_print_pos.dart';
import 'package:blue_print_pos/models/blue_device.dart';
import 'package:blue_print_pos/models/connection_status.dart';
import 'package:blue_print_pos/receipt/receipt_section_text.dart';
import 'package:blue_print_pos/receipt/receipt_text_size_type.dart';
import 'package:blue_print_pos/receipt/receipt_text_style_type.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart' as RB;

import '../../data/model/GetTicketInfoByPNRResponse.dart';

class PrintTicketDetailPage extends StatefulWidget {
  GetTicketInfoByPnrResponse getTicketInfoByPnrResponse;
  PrintTicketDetailPage({Key? key, required this.getTicketInfoByPnrResponse})
      : super(key: key);
  @override
  PrintTicketDetailState createState() => PrintTicketDetailState();
}

class PrintTicketDetailState extends State<PrintTicketDetailPage> {
  final BluePrintPos _bluePrintPos = BluePrintPos.instance;
  List<BlueDevice> _blueDevices = <BlueDevice>[];
  BlueDevice? _selectedDevice;
  bool _isLoading = false;
  int _loadingAtIndex = -1;

  // BLE weighing
  final flutterReactiveBle = RB.FlutterReactiveBle();
  RB.DiscoveredDevice? deviceChipseaBle;
  String mButtonText = "Connect Chipsea-BLE";
  String mWeighingReading = "---";
  String mUnit = "no";

  @override
  void initState() {
    super.initState();
    (WidgetsBinding.instance).addPostFrameCallback((_) async {});
    _onScanPressed();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onScanPressed() async {
    if (Platform.isAndroid) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
      ].request();
      if (statuses[Permission.bluetoothScan] != PermissionStatus.granted ||
          statuses[Permission.bluetoothConnect] != PermissionStatus.granted) {
        return;
      }
    }

    setState(() => _isLoading = true);
    _bluePrintPos.scan().then((List<BlueDevice> devices) {
      if (devices.isNotEmpty) {
        setState(() {
          _blueDevices = devices;
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    });
  }

  void _onDisconnectDevice() {
    _bluePrintPos.disconnect().then((ConnectionStatus status) {
      if (status == ConnectionStatus.disconnect) {
        setState(() {
          _selectedDevice = null;
        });
      }
    });
  }

  void _onSelectDevice(int index) {
    setState(() {
      _isLoading = true;
      _loadingAtIndex = index;
    });
    final BlueDevice blueDevice = _blueDevices[index];
    _bluePrintPos.connect(blueDevice).then((ConnectionStatus status) {
      if (status == ConnectionStatus.connected) {
        setState(() => _selectedDevice = blueDevice);
      } else if (status == ConnectionStatus.timeout) {
        _onDisconnectDevice();
      } else {
        if (kDebugMode) {
          print('$runtimeType - something wrong');
        }
      }
      setState(() => _isLoading = false);
    });
  }

  Future<void> _onPrintReceipt() async {
    /// Example for Print Image
    // / final ByteData logoBytes = await rootBundle.load(
    // /   'assets/logo.jpg',
    /// );

    /// Example for Print Text
    final ReceiptSectionText receiptText = ReceiptSectionText();
    // receiptText.addImage(
    //    base64.encode(Uint8List.view(logoBytes.buffer)),
    //     width: 300,
    //   );
    receiptText.addSpacer();
    receiptText.addText('SONIC INT COACH',
        size: ReceiptTextSizeType.large, style: ReceiptTextStyleType.bold);
    receiptText.addSpacer();

    receiptText.addText(
      '--------Afritek--------',
      size: ReceiptTextSizeType.small,
    );
    receiptText.addSpacer(useDashed: true);
    receiptText.addLeftRightText(
        'ENQUIRIES :', '${widget.getTicketInfoByPnrResponse.inquiryNo}');
    receiptText.addLeftRightText(
        'TICKET NO :', '${widget.getTicketInfoByPnrResponse.pnr}');
    receiptText.addLeftRightText('ISSUED :',
        '${widget.getTicketInfoByPnrResponse.tripDate} ${widget.getTicketInfoByPnrResponse.departureTime}');
    receiptText.addSpacer(useDashed: true);
    receiptText.addLeftRightText('TRIP :',
        '${widget.getTicketInfoByPnrResponse.startCity} - ${widget.getTicketInfoByPnrResponse.stopCity}');
    receiptText.addLeftRightText(
        'Pick Point :', '${widget.getTicketInfoByPnrResponse.pickPoint}');
    receiptText.addLeftRightText(
        'Drop point :', '${widget.getTicketInfoByPnrResponse.dropPoint}');
    receiptText.addLeftRightText(
        'BUS No :', '${widget.getTicketInfoByPnrResponse.busNo}');
    receiptText.addLeftRightText(
        'CLASS :', '${widget.getTicketInfoByPnrResponse.busType}');
    receiptText.addLeftRightText('Ticket ID :', '');
    receiptText.addLeftRightText('PASSENGER :',
        '${widget.getTicketInfoByPnrResponse.passenger![0]?.firstName} ${widget.getTicketInfoByPnrResponse.passenger![0]?.lastName}');
    receiptText.addLeftRightText('PASSENGER PHONE :',
        '${widget.getTicketInfoByPnrResponse.passenger![0]?.mobileNo}');
    receiptText.addLeftRightText('SEAT NO :',
        '${widget.getTicketInfoByPnrResponse.passenger![0]?.seatNo}');
    receiptText.addLeftRightText('SEAT FARE :',
        '${widget.getTicketInfoByPnrResponse.passenger![0]?.seatFare}');
    receiptText.addLeftRightText(
        'TRAVEL DATE :', '${widget.getTicketInfoByPnrResponse.tripDate}');
    receiptText.addLeftRightText(
        'DEPARTURE :', '${widget.getTicketInfoByPnrResponse.departureTime}');
    receiptText.addLeftRightText('REPORTING :', '60 mins before Bus de pt.');
    receiptText.addLeftRightText('ISSUED BY :', 'Test one');
    receiptText.addSpacer(useDashed: true);
    receiptText.addLeftRightText(
      'TRA CODE',
      '\$ NA',
      leftStyle: ReceiptTextStyleType.normal,
      rightStyle: ReceiptTextStyleType.bold,
    );
    receiptText.addSpacer(useDashed: true);
    receiptText.addLeftRightText(
      'Payment',
      'Cash',
      leftStyle: ReceiptTextStyleType.normal,
      rightStyle: ReceiptTextStyleType.normal,
    );
    receiptText.addSpacer(count: 1);

    receiptText.addText('Powered by Afritek', size: ReceiptTextSizeType.small);
    receiptText.addSpacer();

    await _bluePrintPos.printReceiptText(receiptText, feedCount: 1);

    /// Example for print QR
    // await _bluePrintPos.printQR('https://www.google.com/', size: 250);

    /// Text after QR
    // final ReceiptSectionText receiptSecondText = ReceiptSectionText();
    // receiptSecondText.addText('Powered by Afritek',
    //     size: ReceiptTextSizeType.small);
    // receiptSecondText.addSpacer();
    // await _bluePrintPos.printReceiptText(receiptSecondText, feedCount: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Printer'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: _isLoading && _blueDevices.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _blueDevices.isNotEmpty
                    ? SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: List<Widget>.generate(
                                  _blueDevices.length, (int index) {
                                return Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: _blueDevices[index].address ==
                                                (_selectedDevice?.address ?? '')
                                            ? _onDisconnectDevice
                                            : () => _onSelectDevice(index),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                _blueDevices[index].name,
                                                style: TextStyle(
                                                  color: _selectedDevice
                                                              ?.address ==
                                                          _blueDevices[index]
                                                              .address
                                                      ? Colors.blue
                                                      : Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                _blueDevices[index].address,
                                                style: TextStyle(
                                                  color: _selectedDevice
                                                              ?.address ==
                                                          _blueDevices[index]
                                                              .address
                                                      ? Colors.blueGrey
                                                      : Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (_loadingAtIndex == index && _isLoading)
                                      Container(
                                        height: 24.0,
                                        width: 24.0,
                                        margin:
                                            const EdgeInsets.only(right: 8.0),
                                        child:
                                            const CircularProgressIndicator(),
                                      ),
                                    if (!_isLoading &&
                                        _blueDevices[index].address ==
                                            (_selectedDevice?.address ?? ''))
                                      TextButton(
                                        onPressed: _onPrintReceipt,
                                        child: Container(
                                          color: _selectedDevice == null
                                              ? Colors.grey
                                              : Colors.blue,
                                          padding: const EdgeInsets.all(8.0),
                                          child: const Text(
                                            'Print',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              }),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text(
                              'Scan bluetooth device',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.blue),
                            ),
                            Text(
                              'Press button scan',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isLoading ? null : _onScanPressed,
        child: const Icon(Icons.search),
        backgroundColor: _isLoading ? Colors.grey : Colors.blue,
      ),
    );
  }
}
