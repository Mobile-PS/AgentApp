import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ticket_agent/data/model/ReservationChartDetailsResponce.dart';
import 'package:ticket_agent/utils/LangConstants.dart';

import '../../MyController.dart';
import '../../business_logic/auth/manifest/manifest_bloc.dart';
import '../../components/button_loading_view.dart';
import '../../data/model/GetTicketInfoByPNRResponse.dart';
import '../../data/repos/TicketInfoRepository.dart';
import '../../utils/MyThemes.dart';
import '../../utils/date_utils.dart';

class ManifestPrintTicket extends StatefulWidget {
  const ManifestPrintTicket({Key? key}) : super(key: key);

  @override
  State<ManifestPrintTicket> createState() => _ManifestPrintTicketState();
}

class _ManifestPrintTicketState extends State<ManifestPrintTicket> {
  ManifestBloc bloc = ManifestBloc(TicketInfoRepository());

  MyController myController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LangConstants.ac_rsv_li_manifst.tr),
      ),
      body: BlocBuilder<ManifestBloc, ManifestState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is ManifestLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ManifestSuccessState) {
            var response = state.reservationChartDetailsResponce;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "${response.busDetails.company}",
                        style: AppStyle.customTextTheme(
                            Colors.black, FontWeight.bold, 15),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DottedLine(
                          direction: Axis.horizontal,
                          lineLength: MediaQuery.of(context).size.width / 3,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashRadius: 1.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        ),
                        Text(
                          LangConstants.nav_header_title.tr,
                          style: AppStyle.customTextTheme(
                              Colors.black, FontWeight.w500, 15),
                        ),
                        DottedLine(
                          direction: Axis.horizontal,
                          lineLength: MediaQuery.of(context).size.width / 3,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashRadius: 1.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        )
                      ],
                    ),
                    Center(
                      child: Text(
                        "Passenger Manifest",
                        style: AppStyle.customTextTheme(
                            Colors.black, FontWeight.w500, 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 9.0, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${LangConstants.ac_rsv_li_jr_dt.tr}  ${response.busDetails.date}'),
                          Text("Company Name : ${response.busDetails.company}"),
                          Text("Bus No : ${response.busDetails.busNo}"),
                          Text(
                              "Bus Reg. No :${response.busDetails.registrationNo} "),
                          Text(
                              '${LangConstants.ac_rsv_li_rt.tr}: ${response.busDetails.route}'),
                        ],
                      ),
                    ),
                    DottedLine(
                      direction: Axis.horizontal,
                      lineLength: MediaQuery.of(context).size.width,
                      lineThickness: 1.0,
                      dashLength: 4.0,
                      dashRadius: 1.0,
                      dashGapLength: 4.0,
                      dashGapColor: Colors.transparent,
                      dashGapRadius: 0.0,
                    ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: response.list.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      "${index + 1} ${response.list[index].firstName} ${response.list[index].lastName}"),
                                  Text(
                                      '${LangConstants.phone.tr} ${response.list[index].passContact}'),
                                  Text(
                                      '${LangConstants.ac_cncl_tic_adp_nm.tr} : ${response.list[index].passContact}'),
                                  Text(
                                      "Sub Route : ${response.list[index].passContact}"),
                                  Text(
                                      '${LangConstants.ac_rsv_li_adp_dr.tr} : ${response.list[index].droping}'),
                                  Text(
                                      '${LangConstants.ac_ag_bs_lis_fare.tr}: ${response.list[index].seatFare}'),
                                ],
                              ),
                            );
                          }),
                    ),
                    DottedLine(
                      direction: Axis.horizontal,
                      lineLength: MediaQuery.of(context).size.width,
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
                      child: Text("Total Amount TSH : 32,000.00"),
                    ),
                    DottedLine(
                      direction: Axis.horizontal,
                      lineLength: MediaQuery.of(context).size.width,
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
          } else {
            return Center(
              child: Text("Something went wrong"),
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
        child: CustomLoadingButton(
            isLoading: false,
            title: LangConstants.ac_tic_print.tr,
            onPress: () {
              // Get.to();
            }),
      ),
    );
  }

  @override
  void initState() {
    bloc.add(Manifest(
        myController.selectedBus!.routeId,
        myController.selectedBus!.date.toString(),
        myController.selectedBus!.routeViaCityId));
    super.initState();
  }
}
