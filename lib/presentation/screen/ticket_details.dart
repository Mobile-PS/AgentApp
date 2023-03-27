import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ticket_agent/business_logic/booking/booking_bloc.dart';
import 'package:ticket_agent/data/model/BookingResponse.dart';
import 'package:ticket_agent/data/model/booking_req.dart';
import 'package:ticket_agent/data/repos/BusRouteRepository.dart';
import 'package:ticket_agent/presentation/screen/BookingSuccessPage.dart';
import 'package:ticket_agent/presentation/screen/print_ticket_page.dart';
import 'package:ticket_agent/utils/MyThemes.dart';
import 'package:ticket_agent/utils/shared_pref_utils.dart';

import '../../MyController.dart';
import '../../components/button_loading_view.dart';
import '../../data/model/OperatorResponse.dart';
import '../../data/model/seat_number.dart';
import '../../utils/color_utils.dart';
import '../../utils/date_utils.dart';
import 'BusSearchPage.dart';

class TicketDetails extends StatefulWidget {
  const TicketDetails({Key? key}) : super(key: key);

  @override
  State<TicketDetails> createState() => _TicketDetailsState();
}

class _TicketDetailsState extends State<TicketDetails> {
  List<String> countries = [
    "TTCL T-Pesa",
    "M-Pesa",
    "Tigo Pesa",
    "Airtel Money",
    "Cash"
  ];
  String? selectedPaymentType;
  String? selectedPayment;
  MyController controller =
      Get.isRegistered() ? Get.find() : Get.put(MyController());
  BookingBloc bloc = BookingBloc(BusRouteRepository());

  @override
  Widget build(BuildContext context) {
    var state;
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 70,
            title: Text("${controller.selectedBus?.operatorName}")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        simpleTextField("Journey"),
                        boldTextField(
                            "${controller.selectedBus?.sourceName} - ${controller.selectedBus?.destinationName}"),
                        simpleTextField("Name"),
                        boldTextField(
                            "${controller.passangerList[0].firstName} ${controller.passangerList[0].lastName}"),
                        simpleTextField("NET Fare"),
                        boldTextField("${controller.selectedBus?.fare}"),
                        simpleTextField("Total Fare"),
                        boldTextField(
                            "${controller.selectedBus?.fare * controller.passangerList.length}"),
                        simpleTextField("Departure Time"),
                        boldTextField(
                            "${controller.selectedBus?.departureTime}"),
                      ],
                    )),
                    SizedBox.shrink(),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          simpleTextField("Date"),
                          boldTextField(
                              "${MyDateUtils.getFormatterDate(controller.selectedBus!.date)}"),
                          simpleTextField("Email"),
                          boldTextField("${controller.passangerList[0].email}"),
                          simpleTextField("Insurance Total"),
                          boldTextField("TZS 00"),
                          simpleTextField("Seat No"),
                          boldTextField(
                              "${controller.passangerList[0].seatNo}"),
                          simpleTextField("Arrival Time"),
                          boldTextField(
                              "${controller.selectedBus?.arrivalTime}"),
                          //     Colors.black, FontWeight.bold, 15),),
                        ],
                      ),
                    ),
                  ],
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 25),
                //   child: Row(mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Column(mainAxisAlignment: MainAxisAlignment.end,
                //         children: [
                //           Text("Apply Discount",style: AppStyle.customTextTheme(
                //               Colors.black, FontWeight.bold, 15),),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Column(
                //   children: [
                //     Text("60 mins before departure time",style: AppStyle.customTextTheme(
                //         Colors.black, FontWeight.w400, 15),)
                //   ],
                // ),
                SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    "Payment mode",
                    style: AppStyle.customTextTheme(
                        Colors.black, FontWeight.bold, 20),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                DropdownButtonHideUnderline(
                    child: DropdownButton2(
                        isExpanded: true,
                        hint: Text(
                          'Select payment mode',
                          style: AppStyle.customTextTheme(
                              ColorUtils.grey, FontWeight.w600, 16),
                        ),
                        items: countries
                            ?.map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // SvgPicture.asset(
                                      //     "${StringUtils
                                      //         .imageBasePath}bus.svg",
                                      //     width: 25,
                                      //     height: 25),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        item,
                                        style: AppStyle.customTextTheme(
                                            ColorUtils.black,
                                            FontWeight.w600,
                                            16),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedPaymentType = value as String;
                          });
                        },
                        value: selectedPaymentType ?? null,
                        icon: const Icon(
                          Icons.expand_more,
                        ),
                        iconSize: 30,
                        iconEnabledColor: Colors.black,
                        iconDisabledColor: Colors.grey,
                        buttonHeight: 50,
                        buttonWidth: double.infinity,
                        buttonPadding: const EdgeInsets.all(10),
                        /*buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
              color: Colors.pink,
                ),
                color: Colors.white,
              ),*/
                        itemHeight: 50,
                        dropdownMaxHeight: 300,
                        dropdownWidth: MediaQuery.of(context).size.width * 0.90,
                        //  dropdownPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                        /* dropdownDecoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                color: ColorUtils.green, width: 1),
              ),*/
                        dropdownElevation: 5,
                        scrollbarRadius: const Radius.circular(2),
                        scrollbarThickness: 6,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(-8, -2))),
                // SizedBox(
                //   height: 15,
                // ),
                // Row(mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Icon(Icons.expand_more),
                //     Text("cash",style: AppStyle.customTextTheme(
                //         ColorUtils.grey, FontWeight.w600, 16),
                //     ),
                //
                //   ],
                // )
                /*      DropdownButtonHideUnderline(
                  child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // SvgPicture.asset(
                          //     "${StringUtils.imageBasePath}bus.svg",
                          //     width: 25,
                          //     height: 25),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Cash',
                            style: AppStyle.customTextTheme(
                                ColorUtils.grey, FontWeight.w600, 16),
                          ),
                        ],
                      ),
                      items: list
                          ?.map((item) =>
                          DropdownMenuItem<String>(
                            value: item,
                            child: Row(mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SvgPicture.asset(
                                //     "${StringUtils
                                //         .imageBasePath}bus.svg",
                                //     width: 25,
                                //     height: 25),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  item,
                                  style: AppStyle.customTextTheme(
                                      ColorUtils.black,
                                      FontWeight.w600,
                                      16),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedPayment = value as String;
                        });
                      },
                      value: selectedPayment ?? null,
                      icon: const Icon(
                        Icons.expand_more,
                      ),

                      iconSize: 30,
                      iconEnabledColor: Colors.black,
                      iconDisabledColor: Colors.grey,
                      buttonHeight: 50,
                      buttonWidth: double.infinity,
                      buttonPadding: const EdgeInsets.all(10),
                      */ /*buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
              color: Colors.pink,
                ),
                color: Colors.white,
              ),*/ /*
                      itemHeight: 50,
                      dropdownMaxHeight: 300,
                      dropdownWidth:
                      MediaQuery
                          .of(context)
                          .size
                          .width * 0.90,
                      //  dropdownPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                      */ /* dropdownDecoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                color: ColorUtils.green, width: 1),
              ),*/ /*
                      dropdownElevation: 5,
                      scrollbarRadius: const Radius.circular(2),
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                      offset: const Offset(-8, -2))),*/
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                " Checkout :",
                style: AppStyle.customTextTheme(
                    ColorUtils.white, FontWeight.w600, 16),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100),
                child: Container(
                    padding: EdgeInsets.all(4),
                    width: 120,
                    height: 40,
                    child: BlocBuilder<BookingBloc, BookingState>(
                      bloc: bloc,
                      builder: (context, state) {
                        return CustomLoadingButton(
                          isLoading: false,
                          title: "Proceed",
                          onPress: () {
                            String bseatList = "";
                            List<SeatNumber> selectedSeats =
                                controller.selectedSeats.toList();

                            for (int i = 0; i < selectedSeats.length; i++) {
                              for (int j = 0;
                                  j <
                                      controller
                                          .response.value.busLayout!.length;
                                  j++) {
                                if (controller.response.value.busLayout![j]
                                            .rowNo ==
                                        selectedSeats[i].rowI.toString() &&
                                    controller.response.value.busLayout![j]
                                            .colNo ==
                                        selectedSeats[i].colI.toString()) {
                                  bseatList = controller
                                      .response.value.busLayout![j].seatNo
                                      .toString();
                                }
                              }
                            }
                            //  Get.to(BookingSuccessPage());
                            bloc.add(Getbooking(BookingRequest(
                                agentType: "bus_agent",
                                insuranceTieup: false,
                                label: "${controller.selectedBus?.label}",
                                lang: "en",
                                masterrouteId: 0,
                                masterrouteviaId: 0,
                                operatorName:
                                    controller.selectedBus?.operatorName,
                                passengerList: controller.passangerList,
                                primaryInfo: PrimaryInfo(
                                    agentId: SharedPrefUtils.getAgentId(),
                                    arrivalTime:
                                        controller.selectedBus?.arrivalTime,
                                    departureTime:
                                        controller.selectedBus?.departureTime,
                                    discount: 0,
                                    dropPoint: controller
                                        .selectedDroppingPoint!.pointId,
                                    isOperator: true,
                                    operatorId:
                                        controller.selectedBus?.operatorId,
                                    passengerId: 0,
                                    paymentGateway: "cash",
                                    paymentSource: "cash",
                                    pickPoint: controller
                                        .selectedBoardingPoint!.pointId,
                                    fkRouteid: controller.selectedBus?.routeId,
                                    fkRouteViaCityId:
                                        controller.selectedBus?.routeViaCityId,
                                    seatCount: controller.selectedSeats.length,
                                    bseatsList: bseatList,
                                    startCityId: controller.source?.cityId,
                                    stopCityId: controller.destination?.cityId,
                                    //  startCityId: controller.selectedBoardingPoint?.pointId,
                                    // stopCityId: controller.selectedDroppingPoint?.pointId,
                                    totalFare:
                                        (controller.selectedSeats.length *
                                                controller.selectedBus?.fare)
                                            .toInt(),
                                    ticketSource: "agent_app",
                                    ticketStatus: "partially pending",
                                    tripDate: controller.selectedBus?.date))));

                            if (state is BookingSuccessState) {
                              BookingResponse res = state.bookingResponse;
                              print("res" + res.toJson().toString());
                              Get.to(
                                  PrintTicketPage(refId: res.refId.toString()));
                            }
                          },
                        );
                      },
                    )),
              ),
            ],
          ),
        ));
  }

  Widget simpleTextField(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "$text",
        style: AppStyle.customTextTheme(Colors.black, FontWeight.w400, 15),
      ),
    );
  }

  Widget boldTextField(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "$text",
        style: AppStyle.customTextTheme(Colors.black, FontWeight.w700, 15),
      ),
    );
  }

// Widget simpleTextField(String text)
// {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Text("$text", style: AppStyle.customTextTheme(
//         Colors.black, FontWeight.w400, 15),),
//   );
//
// }
//
//
// Widget boldTextField(String text)
// {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Text("$text", style: AppStyle.customTextTheme(
//         Colors.black, FontWeight.w700, 15),),
//   );
//
// }
}
