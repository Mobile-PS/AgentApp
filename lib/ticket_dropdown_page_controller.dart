import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ticket_agent/data/model/BookingResponse.dart';
import 'package:ticket_agent/data/model/PaymentModel.dart';
import 'package:ticket_agent/data/model/PaymentUpdateModel.dart';
import 'package:ticket_agent/data/model/booking_req.dart';
import 'package:ticket_agent/presentation/screen/BusSearchPage.dart';
import 'package:ticket_agent/presentation/screen/home_page.dart';
import 'package:ticket_agent/presentation/screen/print_ticket_page.dart';
import 'package:ticket_agent/utils/color_utils.dart';
import 'package:ticket_agent/utils/default_button1.dart';
import 'package:ticket_agent/utils/default_button2.dart';
import 'package:ticket_agent/utils/progresswidget_collection.dart';
import 'data/repos/BusRouteRepository.dart';
import 'main.dart';



class TicketDropdownPageController extends GetxController {

  final BusRouteRepository _mockRepository = Get.put(BusRouteRepository());



  bool togggle = true;

  List<ChannelList> selectedByDataList = [];

  List<CList> mainDataList = [];

  BookingResponse? _paymentUpdateModel;

  int selectedIndex = 0;

  bool loading = false;
  String swapcount = '0';
  List<Widget> _statusChild = [];



  @override
  void onInit() {
   // GetPayMode();
    super.onInit();
  }


  void updateIndex(int index) {
    selectedIndex = index;
    update();
  }

  void toggleLoading() {
    if (loading) {
      loading = false;
    } else {
      loading = true;
    }
    update();
  }


  void GetPayMode(int routeID, BuildContext context) async {


    print(routeID);

    ProgressWidgetsCollection(context).startLoader();

    final responseActive = await _mockRepository.getPaymentMode(routeID);

    ProgressWidgetsCollection(context).stopLoader();


    if (responseActive != null) {

      print(responseActive.responseMessage);


      selectedByDataList = responseActive.list![0].channelList!;
      selectedByDataList.add(ChannelList(id: 10,channelType: 'C',channel: 'Cash',code: null,instruction: []));

   /*   final response1 = MetaModel.fromJson(responseActive.data);

      if(response1.meta?.flag == 'Success') {
        //showToast(response1.meta!.message!, 'success');

        final successresp = CheckUser.fromJson(responseActive.data);
        swapcount = successresp.data!.swappiesCount.toString();

      }*/
    }


    update();

  }


  createDialog(BuildContext context, var refid) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(10.0)), //this right here
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                          child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10.0),
                              child: Text(
                                'Booking Confirmed',
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ))),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10.0),
                              child: Text(
                                'Ticket details sent to you\n by email and sms.\n Thank you for choosing Afritek.',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ))),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Padding(
                                    padding:
                                    EdgeInsets.only(left: 10, right: 10),
                                    child: DefaultButton1(
                                      press: () {
                                        // con.clearData();
                                        Get.to(
                                            PrintTicketPage(
                                                refId: refid));
                                        // Get.offAllNamed('/login_screen');
                                      },
                                      text: 'PRINT',
                                      height: 48,
                                    ))),
                            Expanded(
                                child: Padding(
                                    padding:
                                    EdgeInsets.only(left: 10, right: 10),
                                    child: DefaultButton2(
                                        press: () {
                                          Get.back();
                                          Get.offAll(BusSearchpage());

                                        },
                                        text: 'CLOSE',
                                        height: 48))),
                          ]),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ));
        });
  }

  createDialogonline(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return WillPopScope(
                onWillPop: () async => true,
                child: Dialog(
                  insetPadding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(10.0)), //this right here
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      width: double.infinity,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: CupertinoColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.systemGrey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: Padding(
                                padding: EdgeInsets.only(left: 10, right: 10.0),
                                child: Text(
                                  'Booking Confirmed',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ))),

                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                                padding: EdgeInsets.only(left: 10, right: 10.0),
                                child: Text(
                                  'Selected seat are reserved.',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                )),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                                padding: EdgeInsets.only(left: 10, right: 10.0),
                                child: Text(
                                  'Reservation details has been sent to you via email sms...',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                )),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                                padding: EdgeInsets.only(left: 10, right: 10.0),
                                child: Text(
                                  'Make online payment within 15 min.',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                )),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                                padding: EdgeInsets.only(left: 10, right: 10.0),
                                child: Text(
                                  'Use details as below.',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                )),
                        SizedBox(
                          height: 10,
                        ),
                         Padding(
                                padding: EdgeInsets.only(left: 10, right: 10.0),
                                child: Text(
                                  'Ref No:${_paymentUpdateModel!.refId.toString()}',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                )),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                                padding: EdgeInsets.only(left: 10, right: 10.0),
                                child: Text(
                                  'Total Fare:${_paymentUpdateModel!.grandTotal.toString()}',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                )),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 10, right: 10.0),
                            child: Text(
                              'Instructions',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _statusChild,),

                          SizedBox(
                            height: 20,
                          ),
                        Center(child:
                            InkWell(onTap: () {
                              Get.offAll(BusSearchpage());
                            },child:
                        Container(
                          height: 48,
                          width: MediaQuery.of(context).size.width/3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                ColorUtils.primary,
                                ColorUtils.primary,
                              ],
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Close',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )))

                      ],)),

                ));
          });
        });
  }



  void SavebookingRequest(BuildContext context,int payid,var paytype,int pos,BookingRequest bookingRequest) async {


  //  print(routeID);
   _statusChild.clear();

   ProgressWidgetsCollection(context).startLoader();

   final responseActive = await _mockRepository.saveTicketDetails(bookingRequest);

   ProgressWidgetsCollection(context).stopLoader();

    if (responseActive != null && responseActive.responseCode == 200) {

      print(responseActive.responseMessage);
      _paymentUpdateModel = responseActive;

     // createDialog(context, responseActive.refId.toString());

      if(paytype == 'Cash' || paytype == 'cash') {
        SaveTransactionRequest(context, payid, 'cash', responseActive.ticketId);
      }
      else{
        selectedByDataList[pos].instruction?.forEach((element) {
          _statusChild.add(Padding(padding: EdgeInsets.only(left: 10),child:
              Text(
           element.instructionEn.toString(),
            style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500),
          )));
        });

        SaveTransactionRequest(context, payid, 'online', responseActive.ticketId);

      }

    }
    else{

      Fluttertoast.showToast(msg:responseActive!.responseMessage.toString());
    }


   // update();

  }


  void SaveTransactionRequest(BuildContext context,int channelid,var paymode,var transid) async {


    //  print(routeID);

    ProgressWidgetsCollection(context).startLoader();

    final responseActive = await _mockRepository.getSuccessTransaction(channelid,paymode,transid);

    ProgressWidgetsCollection(context).stopLoader();

    if (responseActive != null && responseActive.responseCode == 200) {

      print(responseActive.responseMessage);

      if(paymode == 'cash') {
        createDialog(context, responseActive.pnr);
      }
      else{
        createDialogonline(context);

      }

    }
    else{
      Fluttertoast.showToast(msg:responseActive!.responseMessage.toString());

    }


    update();

  }


}
