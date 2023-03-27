import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ticket_agent/business_logic/print_ticket/print_ticket_bloc.dart';
import 'package:ticket_agent/data/model/GetTicketInfoByPNRResponse.dart';
import 'package:ticket_agent/data/repos/TicketInfoRepository.dart';
import 'package:ticket_agent/utils/LangConstants.dart';
import 'package:ticket_agent/utils/date_utils.dart';

import '../../components/button_loading_view.dart';
import '../../utils/MyThemes.dart';
import 'PrintTicketDetailsPage.dart';

class PrintTicketPage extends StatefulWidget {
  PrintTicketPage({Key? key, this.refId}) : super(key: key);

  String? refId;
  @override
  State<PrintTicketPage> createState() => _PrintTicketPageState();
}

class _PrintTicketPageState extends State<PrintTicketPage> {
  PrintTicketBloc bloc = PrintTicketBloc(TicketInfoRepository());
  TextEditingController searchBox = TextEditingController();
  GetTicketInfoByPnrResponse? ticketInfoByPnrResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LangConstants.ac_tic_acbar_title.tr),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchBox,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        hintText: ' Enter PNR Number',
                        hintStyle: AppStyle.customTextTheme(
                            Colors.black, FontWeight.w400, 20),
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    child: InkWell(
                        onTap: () {
                          bloc.add(GetTicketDetailsByPNR(
                              searchBox.text.toString(), "en", "bus_agent"));
                        },
                        child: Icon(Icons.search)),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<PrintTicketBloc, PrintTicketState>(
              bloc: bloc,
              builder: (context, state) {
                if (state is PrintLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PrintSuccessState) {
                  ticketInfoByPnrResponse = state.ticketInfoByPnrResponse;
                  print(ticketInfoByPnrResponse?.busName);
                  return Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: ticketInfoByPnrResponse?.passenger!.length,
                        itemBuilder: (contextx, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Center(
                                          child: Text(
                                        "SONIC INT COACH",
                                        style: AppStyle.customTextTheme(
                                            Colors.black, FontWeight.bold, 15),
                                      ))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      DottedLine(
                                        direction: Axis.horizontal,
                                        lineLength:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        lineThickness: 1.0,
                                        dashLength: 4.0,
                                        dashRadius: 1.0,
                                        dashGapLength: 4.0,
                                        dashGapColor: Colors.transparent,
                                        dashGapRadius: 0.0,
                                      ),
                                      Text(
                                        LangConstants.diptech.tr,
                                        style: AppStyle.customTextTheme(
                                            Colors.black, FontWeight.bold, 15),
                                      ),
                                      DottedLine(
                                        direction: Axis.horizontal,
                                        lineLength:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        lineThickness: 1.0,
                                        dashLength: 4.0,
                                        dashRadius: 1.0,
                                        dashGapLength: 4.0,
                                        dashGapColor: Colors.transparent,
                                        dashGapRadius: 0.0,
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        textWidget(
                                            LangConstants
                                                .ac_tic_print_tic_enq.tr,
                                            "${ticketInfoByPnrResponse?.inquiryNo}"),
                                        textWidget(
                                            LangConstants
                                                .ac_tic_print_tic_no.tr,
                                            "${ticketInfoByPnrResponse?.pnr}"),
                                        textWidget(
                                            LangConstants.ac_tic_print_is.tr,
                                            "${MyDateUtils.getFormatterDate(ticketInfoByPnrResponse!.ticketBookingDate!)}  ${ticketInfoByPnrResponse?.ticketBookingTime}"),
                                      ],
                                    ),
                                  ),
                                  DottedLine(
                                    direction: Axis.horizontal,
                                    lineLength:
                                        MediaQuery.of(context).size.width,
                                    lineThickness: 1.0,
                                    dashLength: 4.0,
                                    dashRadius: 1.0,
                                    dashGapLength: 4.0,
                                    dashGapColor: Colors.transparent,
                                    dashGapRadius: 0.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        textWidget(
                                            LangConstants.ac_tic_print_trp.tr,
                                            "${ticketInfoByPnrResponse?.startCity} - ${ticketInfoByPnrResponse?.stopCity}"),
                                        textWidget(
                                            LangConstants.ac_tic_print_pk.tr,
                                            "${ticketInfoByPnrResponse?.pickPoint} "),
                                        textWidget(
                                            LangConstants.ac_tic_print_dr.tr,
                                            "${ticketInfoByPnrResponse?.dropPoint} "),
                                        textWidget("BUS NO",
                                            "${ticketInfoByPnrResponse?.busNo} "),
                                        textWidget("CLASS",
                                            "${ticketInfoByPnrResponse?.passenger![index]!.seatType}"),
                                        textWidget("TICKET ID",
                                            "${ticketInfoByPnrResponse?.passenger![index]!.ticketId}"),
                                        textWidget("PASSENGER",
                                            "${ticketInfoByPnrResponse?.passenger![index]!.firstName}  ${ticketInfoByPnrResponse?.passenger![index]!.lastName}"),
                                        textWidget("PASSENGER PHONE",
                                            "${ticketInfoByPnrResponse?.passenger![index]!.mobileNo}"),
                                        textWidget("SEAT (S) NO",
                                            "${ticketInfoByPnrResponse?.passenger![index]!.seatNo}"),
                                        textWidget("SEAT FARE",
                                            "${ticketInfoByPnrResponse?.passenger![index]!.seatFare}"),
                                        textWidget("TRAVEL DATE",
                                            "${ticketInfoByPnrResponse?.tripDate}"),
                                        textWidget("DEPARTURE",
                                            "${ticketInfoByPnrResponse?.departureTime}"),
                                        textWidget("REPORTING",
                                            "${ticketInfoByPnrResponse?.totalFare}"),
                                        textWidget("ISSUED BY",
                                            "${ticketInfoByPnrResponse?.startCity}"),
                                      ],
                                    ),
                                  ),
                                  DottedLine(
                                    direction: Axis.horizontal,
                                    lineLength:
                                        MediaQuery.of(context).size.width,
                                    lineThickness: 1.0,
                                    dashLength: 4.0,
                                    dashRadius: 1.0,
                                    dashGapLength: 4.0,
                                    dashGapColor: Colors.transparent,
                                    dashGapRadius: 0.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 20),
                                    child: textWidget("ENQUIRIES", "754753769"),
                                  ),
                                  DottedLine(
                                    direction: Axis.horizontal,
                                    lineLength:
                                        MediaQuery.of(context).size.width,
                                    lineThickness: 1.0,
                                    dashLength: 4.0,
                                    dashRadius: 1.0,
                                    dashGapLength: 4.0,
                                    dashGapColor: Colors.transparent,
                                    dashGapRadius: 0.0,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                } else if (state is PrintErrorState) {
                  return Center(
                    child: Text("Enter Valid PNR "),
                  );
                } else {
                  return Text("");
                }
              }),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
        child: CustomLoadingButton(
            isLoading: false,
            title: "Print",
            onPress: () {
              if (ticketInfoByPnrResponse != null) {
                Get.to(PrintTicketDetailPage(
                    getTicketInfoByPnrResponse: ticketInfoByPnrResponse!));
              }
            }),
      ),
    );
  }

  Widget textWidget(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        "$title : $value",
        style: AppStyle.customTextTheme(Colors.black, FontWeight.bold, 14),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.refId.toString() != null) {
      bloc.add(
          GetTicketDetailsByPNR(widget.refId.toString(), "en", "bus_agent"));
    }
  }
}
