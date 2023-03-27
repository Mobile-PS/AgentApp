import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ticket_agent/business_logic/busroute/bus_route_bloc.dart';
import 'package:ticket_agent/data/model/BusRoute.dart';
import 'package:ticket_agent/data/repos/BusRouteRepository.dart';
import 'package:ticket_agent/presentation/screen/SeatLayoutPage.dart';
import 'package:ticket_agent/presentation/screen/manifest_print_ticket.dart';
import 'package:ticket_agent/utils/LangConstants.dart';
import 'package:ticket_agent/utils/color_utils.dart';
import 'package:ticket_agent/utils/shared_pref_utils.dart';

import '../../MyController.dart';
import '../../utils/MyThemes.dart';
import '../../utils/string_utils.dart';

class BusListingPage extends StatefulWidget {
  int sourceId;
  int destId;
  String date;
  String lang;
  int operatorId;
  String busType;

  BusListingPage(
      {Key? key,
      required this.sourceId,
      required this.destId,
      required this.date,
      required this.lang,
      required this.operatorId,
      required this.busType})
      : super(key: key);

  @override
  State<BusListingPage> createState() => _BusListingPageState();
}

class _BusListingPageState extends State<BusListingPage> {
  BusRouteBloc bloc = BusRouteBloc(BusRouteRepository());
  MyController myController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              "${myController.source?.cityName} - ${myController.destination?.cityName}"),
        ),
        body: BlocBuilder<BusRouteBloc, BusRouteState>(
          builder: (context, state) {
            print("MyState $state");
            if (state is LoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SuccessState) {
              var data = state.value.list;
              return data.length < 1
                  ? Center(
                      child: Text(LangConstants.ac_bs_lyt_no_bus.tr),
                    )
                  : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return childUI(context, data[index]);
                      });
            } else {
              return Text("Something went wrong");
            }
          },
          bloc: bloc,
        ));
  }

  Widget childUI(BuildContext context, BusRoute busRoute) {
    return InkWell(
      onTap: () {
        myController.selectedBus = busRoute;

        if (myController.isManifest) {
          Get.to(ManifestPrintTicket());
        } else {
          Get.to(SeatLayoutPage());
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
        child: Card(
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text("${busRoute.operatorName}",
                      style: AppStyle.customTextTheme(
                          ColorUtils.black, FontWeight.w600, 18))),
              Center(
                  child: Text("(${busRoute.routeName})",
                      style: AppStyle.customTextTheme(
                          ColorUtils.grey, FontWeight.w500, 14))),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("Departure On",
                            style: AppStyle.customTextTheme(
                                ColorUtils.grey, FontWeight.w500, 14)),
                        Text("${busRoute.departureTime}",
                            style: AppStyle.customTextTheme(
                                ColorUtils.black, FontWeight.w500, 14)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Total Travel Time",
                            style: AppStyle.customTextTheme(
                                ColorUtils.grey, FontWeight.w500, 14)),
                        Text("${busRoute.departureTime}",
                            style: AppStyle.customTextTheme(
                                ColorUtils.black, FontWeight.w500, 14)),
                      ],
                    ),
                    Column(
                      children: [
                        Text(LangConstants.str_seat.tr,
                            style: AppStyle.customTextTheme(
                                ColorUtils.grey, FontWeight.w500, 14)),
                        Text("${busRoute.totalSeat}",
                            style: AppStyle.customTextTheme(
                                ColorUtils.black, FontWeight.w500, 14)),
                      ],
                    ),
                  ],
                ),
              ),

              // Column(

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        // SvgPicture.asset("${StringUtils.imageBasePath}dot.svg",
                        //     width: 20, height: 15),
                        // Dash(
                        //     direction: Axis.vertical,
                        //     length: 40,
                        //     dashLength: 5,
                        //     dashThickness: 0.5,
                        //     dashColor: Colors.black),
                        // SvgPicture.asset("${StringUtils.imageBasePath}dot.svg",
                        //     width: 20, height: 15),
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text("${busRoute.sourceName}",
                        //     style: AppStyle.customTextTheme(
                        //         ColorUtils.black, FontWeight.w600, 18)),
                        // Text("${busRoute.departureTime}",
                        //     style: AppStyle.customTextTheme(
                        //         ColorUtils.grey, FontWeight.w500, 16)),
                        // Text("${busRoute.destinationName}",
                        //     style: AppStyle.customTextTheme(
                        //         ColorUtils.black, FontWeight.w600, 18)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text("${busRoute.sourceName}",
                                    style: AppStyle.customTextTheme(
                                        ColorUtils.black, FontWeight.w600, 14)),
                                Text("${busRoute.departureTime}",
                                    style: AppStyle.customTextTheme(
                                        ColorUtils.grey, FontWeight.w500, 12)),
                              ],
                            ),
                            Dash(
                                direction: Axis.horizontal,
                                length: 90,
                                dashLength: 30,
                                dashThickness: 0.9,
                                dashColor: Colors.black),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Column(
                                children: [
                                  Text("${busRoute.destinationName}",
                                      style: AppStyle.customTextTheme(
                                          ColorUtils.black,
                                          FontWeight.w600,
                                          14)),
                                  Text("${busRoute.arrivalTime}",
                                      style: AppStyle.customTextTheme(
                                          ColorUtils.grey,
                                          FontWeight.w500,
                                          12)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        height: 35,
                        decoration: BoxDecoration(
                            color: ColorUtils.lightGrey,
                            border: Border.all(
                              color: ColorUtils.grey,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5.0),
                          child: Text("${busRoute.busType}",
                              style: AppStyle.customTextTheme(
                                  ColorUtils.black, FontWeight.w500, 12)),
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                        height: 35,
                        decoration: BoxDecoration(
                            color: ColorUtils.lightGrey,
                            border: Border.all(
                              color: ColorUtils.grey,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5.0),
                          child: Text("T250 DKI",
                              style: AppStyle.customTextTheme(
                                  ColorUtils.black, FontWeight.w500, 12)),
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text(
                          '${LangConstants.ac_bs_lyt_fare_tzs.tr} ${busRoute.fare}',
                          style: AppStyle.customTextTheme(
                              ColorUtils.black, FontWeight.w500, 14)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    bloc.add(getBusRoute(SharedPrefUtils.getAgentId(), widget.busType,
        widget.date, widget.destId, widget.lang, 0, widget.sourceId));
    // "agentId": "8210",
    // "busType": "all",
    // "date": "2022-12-18",
    // "destination": 42,
    // "lang": "en",
    // "operatorId": 0,
    // "source": 1086
    super.initState();
  }
}
