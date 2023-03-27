import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ticket_agent/business_logic/cancel_ticket/cancel_ticket_bloc.dart';
import 'package:ticket_agent/business_logic/cancel_ticket/cancel_ticket_event.dart';
import 'package:ticket_agent/business_logic/cancel_ticket/cancel_ticket_state.dart';
import 'package:ticket_agent/presentation/screen/home_page.dart';
import 'package:ticket_agent/utils/LangConstants.dart';
import 'package:ticket_agent/utils/MyThemes.dart';

import '../../business_logic/print_ticket/print_ticket_bloc.dart';
import '../../components/button_loading_view.dart';
import '../../data/model/GetTicketInfoByPNRResponse.dart';
import '../../data/repos/TicketInfoRepository.dart';
import '../../utils/date_utils.dart';
import '../../utils/shared_pref_utils.dart';
import 'change_password.dart';

class CancleTicket extends StatefulWidget {
  const CancleTicket({Key? key}) : super(key: key);

  @override
  State<CancleTicket> createState() => _CancleTicketState();
}

class _CancleTicketState extends State<CancleTicket> {
  PrintTicketBloc bloc = PrintTicketBloc(TicketInfoRepository());
  CancelTicketBloc cancelBloc = CancelTicketBloc(TicketInfoRepository());
  TextEditingController searchBox = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => bloc,
          ),
          BlocProvider(
            create: (context) => cancelBloc,
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text(LangConstants.ac_ag_dash_cancel_tic.tr),
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
                                  searchBox.text.toString(),
                                  "en",
                                  "bus_agent"));
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
                      GetTicketInfoByPnrResponse ticketInfoByPnrResponse =
                          state.ticketInfoByPnrResponse;
                      print(ticketInfoByPnrResponse.busName);
                      return Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount:
                                ticketInfoByPnrResponse.passenger!.length,
                            itemBuilder: (contextx, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Center(
                                              child: Text(
                                            "SONIC INT COACH",
                                            style: AppStyle.customTextTheme(
                                                Colors.black,
                                                FontWeight.bold,
                                                15),
                                          ))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          DottedLine(
                                            direction: Axis.horizontal,
                                            lineLength: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            lineThickness: 1.0,
                                            dashLength: 4.0,
                                            dashRadius: 1.0,
                                            dashGapLength: 4.0,
                                            dashGapColor: Colors.transparent,
                                            dashGapRadius: 0.0,
                                          ),
                                          Text(
                                            "Afrltek",
                                            style: AppStyle.customTextTheme(
                                                Colors.black,
                                                FontWeight.bold,
                                                15),
                                          ),
                                          DottedLine(
                                            direction: Axis.horizontal,
                                            lineLength: MediaQuery.of(context)
                                                    .size
                                                    .width /
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
                                                "${ticketInfoByPnrResponse.inquiryNo}"),
                                            textWidget(
                                                LangConstants
                                                    .ac_tic_print_tic_no.tr,
                                                "${ticketInfoByPnrResponse.pnr}"),
                                            textWidget(
                                                LangConstants
                                                    .ac_tic_print_is.tr,
                                                "${MyDateUtils.getFormatterDate(ticketInfoByPnrResponse.ticketBookingDate!)}  ${ticketInfoByPnrResponse.ticketBookingTime}"),
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
                                                LangConstants
                                                    .ac_tic_print_trp.tr,
                                                "${ticketInfoByPnrResponse.startCity} - ${ticketInfoByPnrResponse.stopCity}"),
                                            textWidget(
                                                LangConstants
                                                    .ac_tic_print_pk.tr,
                                                "${ticketInfoByPnrResponse.pickPoint} "),
                                            textWidget(
                                                LangConstants
                                                    .ac_tic_print_dr.tr,
                                                "${ticketInfoByPnrResponse.dropPoint} "),
                                            textWidget("BUS NO",
                                                "${ticketInfoByPnrResponse.busNo} "),
                                            textWidget(
                                                LangConstants
                                                    .ac_tic_print_bs_cls.tr,
                                                "${ticketInfoByPnrResponse.passenger![index]!.seatType}"),
                                            textWidget(
                                                LangConstants
                                                    .ac_tic_str_tic_id.tr,
                                                "${ticketInfoByPnrResponse.passenger![index]!.ticketId}"),
                                            textWidget(
                                                LangConstants
                                                    .ac_tic_print_ps.tr,
                                                "${ticketInfoByPnrResponse.passenger![index]!.firstName}  ${ticketInfoByPnrResponse.passenger![index]!.lastName}"),
                                            textWidget(
                                                LangConstants
                                                    .ac_tic_print_ps_ph.tr,
                                                "${ticketInfoByPnrResponse.passenger![index]!.mobileNo}"),
                                            textWidget(
                                                LangConstants
                                                    .ac_tic_print_st_no.tr,
                                                "${ticketInfoByPnrResponse.passenger![index]!.seatNo}"),
                                            textWidget(
                                                LangConstants
                                                    .ac_tic_print_st_fr.tr,
                                                "${ticketInfoByPnrResponse.passenger![index]!.seatFare}"),
                                            textWidget(
                                                LangConstants
                                                    .ac_tic_print_tr_dt.tr,
                                                "${ticketInfoByPnrResponse.tripDate}"),
                                            textWidget(
                                                LangConstants
                                                    .ac_tic_print_dep.tr,
                                                "${ticketInfoByPnrResponse.departureTime}"),
                                            textWidget(
                                                LangConstants
                                                    .ac_tic_print_repo.tr,
                                                "${ticketInfoByPnrResponse.startCity}"),
                                            textWidget(
                                                LangConstants
                                                    .ac_tic_print_iss.tr,
                                                "${ticketInfoByPnrResponse.startCity}"),
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
                                        child: textWidget(
                                            LangConstants
                                                .ac_tic_print_tic_enq.tr,
                                            "754753769"),
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
          bottomNavigationBar: BlocBuilder<CancelTicketBloc, CancelTicketState>(
            builder: (context, state) {
              if (state is CancelSuccessState) {
                if (state.cancelTicketResponse.responseMessage == "Success") {
                  Get.snackbar(state.cancelTicketResponse.responseMessage,
                      "Ticket Cancel Successfully");
                  Get.off(HomePage());
                } else {
                  Get.snackbar("Error", "Something Went wrong");
                }

                print(state.cancelTicketResponse.responseMessage);
              }
              if (state is CancelLoadingState) {
                print("Loading");
              } else {
                print("cacel error");
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                child: CustomLoadingButton(
                    isLoading: false,
                    title: LangConstants.ac_bs_lyt_cancel.tr,
                    onPress: () {
                      cancelBloc.add(CancelTicket(searchBox.text.toString(),
                          SharedPrefUtils.getAgentId()));
                    }),
              );
            },
          ),
        ));
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
  }
}
