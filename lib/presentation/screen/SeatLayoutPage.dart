import 'package:book_my_seat/book_my_seat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ticket_agent/components/button_loading_view.dart';
import 'package:ticket_agent/data/model/BusDetailRequest.dart';
import 'package:ticket_agent/data/model/BusDetailResponse.dart';
import 'package:ticket_agent/presentation/screen/dropping_page.dart';
import 'package:ticket_agent/presentation/screen/multi_passanger_form_widget.dart';
import 'package:ticket_agent/utils/color_utils.dart';
import 'package:ticket_agent/utils/shared_pref_utils.dart';
import 'package:ticket_agent/utils/string_utils.dart';
import '../../MyController.dart';
import '../../business_logic/busroute/bus_route_bloc.dart';
import '../../data/model/seat_number.dart';
import '../../data/repos/BusRouteRepository.dart';
import '../../utils/MyThemes.dart';
import 'bording_dropping_page.dart';

class SeatLayoutPage extends StatefulWidget {
  const SeatLayoutPage({Key? key}) : super(key: key);

  @override
  State<SeatLayoutPage> createState() => _SeatLayoutPageState();
}

class _SeatLayoutPageState extends State<SeatLayoutPage> {
  // Set<SeatNumber> selectedSeats = {};
  MyController myController = Get.find();
  BusRouteBloc bloc = BusRouteBloc(BusRouteRepository());
  List<List<SeatState>> listOfSeatsParent = [];
  List<SeatState> listOfSeats = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        myController.selectedSeats.clear();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
                "${myController.selectedBus?.sourceName} - ${myController.selectedBus?.destinationName}"),
          ),
          body: BlocBuilder<BusRouteBloc, BusRouteState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is BusDetailsLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is BusDetailsSuccessState) {
                myController.response.value = state.value;

                for (int i = 0;
                    i < (myController.response.value.columnCount!! + 1);
                    i++) {
                  for (int j = 0;
                      j < (myController.response.value.rowCount!! + 1);
                      j++) {
                    if (j == 2) {
                      listOfSeats.add(SeatState.empty);
                    } else {
                      listOfSeats.add(SeatState.unselected);
                    }
                  }
                  listOfSeatsParent.add(listOfSeats);
                  // listOfSeats.clear();
                }

                return /*CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: true,
                      child:*/
                    SingleChildScrollView(
                        child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
                        child: Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              colorLayoutUI(ColorUtils.black, "Blocked"),
                              colorLayoutUI(ColorUtils.pink, "Women"),
                              colorLayoutUI(ColorUtils.lightGrey, "Empty"),
                              colorLayoutUI(ColorUtils.green, "Selected"),
                              colorLayoutUI(ColorUtils.primary, "Booked")
                            ],
                          ),
                        )),
                    Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 20.0, top: 10, bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SvgPicture.asset(
                                        "${StringUtils.imageBasePath}steering_wheel.svg")
                                  ],
                                ),
                              ),
                              Divider(thickness: 1),
                              Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height / 2,
                                alignment: Alignment.center,
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: myController
                                        .response.value.columnCount!,
                                    mainAxisSpacing: 8.0,
                                    crossAxisSpacing: 15.0,
                                    childAspectRatio: 2 /
                                        3, //assuming a seat aspect ratio of 2:3
                                  ),
                                  itemCount:
                                      myController.response.value.columnCount! *
                                          myController.response.value.rowCount!,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final seatNumber = index + 1;
                                    final isSeatSelected = true;
                                    // _selectedSeats.contains(seatNumber);
                                    final isSeatReserved =
                                        seatNumber == 3 || seatNumber == 12;

                                    Widget seatWidget;

                                    /* if (isSeatReserved) {
                                            seatWidget = const Icon(
                                              Icons.event_seat,
                                              color: Colors.grey,
                                            );
                                          } else {*/
                                    seatWidget = GestureDetector(
                                        onTap: () {
                                          //_toggleSeatSelection(seatNumber)
                                          if (myController.response.value
                                                  .busLayout![index].status ==
                                              "available") {
                                            myController.selectedList.add(
                                                myController.response.value
                                                    .busLayout![index]);
                                            myController
                                                .response
                                                .value
                                                .busLayout![index]
                                                .status = "click";

                                            setState(() {});
                                            /*showMaterialModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  seatBottomSheet(
                                                      myController:
                                                          myController),
                                            );*/
                                          } else {
                                            if (myController.response.value
                                                    .busLayout![index].status ==
                                                "click") {
                                              myController.selectedList.remove(
                                                  myController.response.value
                                                      .busLayout![index]);

                                              myController
                                                  .response
                                                  .value
                                                  .busLayout![index]
                                                  .status = "available";

                                              setState(() {});
                                            }
                                          }
                                        },
                                        child: Stack(
                                          children: [
                                            myController
                                                        .response
                                                        .value
                                                        .busLayout![index]
                                                        .status ==
                                                    "available"
                                                ? Image.asset(
                                                    'assets/images/seat_unbooked.png')
                                                : myController
                                                                .response
                                                                .value
                                                                .busLayout![
                                                                    index]
                                                                .status ==
                                                            "confirmed"

                                                    ? Image.asset(
                                                        'assets/images/seat_booked.png'):
                                            myController
                                                .response
                                                .value
                                                .busLayout![
                                            index]
                                                .status ==
                                                "click"?
                                            Image.asset(
                                                'assets/images/seat_selected.png')
                                                    : myController
                                                .response
                                                .value
                                                .busLayout![
                                            index]
                                                .status ==
                                                "partially pending"
                                                ? Image.asset(
                                                'assets/images/partpending.jpeg'):
                                            Image.asset(
                                                        'assets/images/seat_unbooked.png'),
                                            Positioned.fill(
                                                bottom: 30,
                                                child: Center(
                                                    child: Text(
                                                        myController
                                                                .response
                                                                .value
                                                                .busLayout![
                                                                    index]
                                                                .seatType! +
                                                            '\n' +
                                                            myController
                                                                .response
                                                                .value
                                                                .busLayout![
                                                                    index]
                                                                .seatNo!,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: myController
                                                                    .response
                                                                    .value
                                                                    .busLayout![
                                                                        index]
                                                                    .status ==
                                                                "confirmed"
                                                            ? AppStyle
                                                                .customTextTheme(
                                                                ColorUtils
                                                                    .white,
                                                                FontWeight.w500,
                                                                10,
                                                              )
                                                            : AppStyle
                                                                .customTextTheme(
                                                                ColorUtils
                                                                    .black,
                                                                FontWeight.w500,
                                                                10,
                                                              ))))
                                          ],
                                        )
                                        /*Icon(
                                                isSeatSelected ? Icons.event_seat : Icons.event_available,
                                                color: isSeatSelected ? Colors.blue : Colors.green,
                                              ),*/
                                        );
                                    // }

                                    if (!myController.response.value
                                        .busLayout![index].isSeat!) {
                                      return SizedBox.shrink();
                                    } else {
                                      return seatWidget;
                                    }
                                  },
                                ),
                                /*SeatLayoutWidget(
                                        onSeatStateChanged:
                                            (rowI, colI, seatState) {
                                          print("seatState $seatState");
                                          if (seatState == SeatState.selected &&
                                              myController
                                                      .selectedSeats.length <
                                                  5) {
                                            myController.selectedSeats.add(
                                                SeatNumber(
                                                    rowI: rowI, colI: colI));
                                          } else if (seatState ==
                                              SeatState.unselected) {
                                            seatState = SeatState.unselected;
                                            myController.selectedSeats.remove(
                                                SeatNumber(
                                                    rowI: rowI, colI: colI));
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Maximum 5 seats allowed");
                                          }
                                          showMaterialModalBottomSheet(
                                            context: context,
                                            builder: (context) =>
                                                seatBottomSheet(
                                                    myController: myController),
                                          );
                                        },
                                        stateModel: SeatLayoutStateModel(
                                            pathDisabledSeat:
                                                'assets/images/svg_disabled_bus_seat.svg',
                                            pathSelectedSeat:
                                                'assets/images/svg_selected_bus_seats.svg',
                                            pathSoldSeat:
                                                'assets/images/svg_sold_bus_seat.svg',
                                            pathUnSelectedSeat:
                                                'assets/images/svg_unselected_bus_seat.svg',
                                            rows: myController
                                                .response.value.rowCount!!,
                                            cols: myController
                                                .response.value.columnCount!!,
                                            seatSvgSize: 60,
                                            currentSeatsState:
                                                listOfSeatsParent),
                                      ),*/
                              ),
                              Container(
                                  color: Colors.transparent,
                                  height: 130,
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text("Ticket price",
                                                  style:
                                                      AppStyle.customTextTheme(
                                                          ColorUtils.grey,
                                                          FontWeight.w500,
                                                          14)),
                                              Text(
                                                  "TZS. ${myController.selectedBus!.fare}",
                                                  style:
                                                      AppStyle.customTextTheme(
                                                          ColorUtils.black,
                                                          FontWeight.w500,
                                                          16))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text("Total price",
                                                  style:
                                                      AppStyle.customTextTheme(
                                                          ColorUtils.grey,
                                                          FontWeight.w500,
                                                          14)),
                                              Text(
                                                  "TZS. ${myController.selectedBus!.fare * myController.selectedList.length}",
                                                  style:
                                                      AppStyle.customTextTheme(
                                                          ColorUtils.black,
                                                          FontWeight.w500,
                                                          16))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text("Selected seats",
                                                  style:
                                                      AppStyle.customTextTheme(
                                                          ColorUtils.grey,
                                                          FontWeight.w500,
                                                          14)),
                                              Text(
                                                  "${myController.selectedList.length} ",
                                                  style:
                                                      AppStyle.customTextTheme(
                                                          ColorUtils.black,
                                                          FontWeight.w500,
                                                          16)),
                                              SizedBox(height: 10),
                                              SizedBox(
                                                width: 100,
                                                height: 30,
                                                child: CustomLoadingButton(
                                                    isLoading: false,
                                                    title: "Pay Now",
                                                    onPress: () {
                                                      Get.to(
                                                          BordingDropingPage());
                                                    }),
                                              )
                                            ],
                                          ),
                                        ),
/*
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Selected seats",
                        style: AppStyle.customTextTheme(
                            ColorUtils.grey, FontWeight.w500, 14)),
                    Obx(() => Text("${myController.selectedList.length} ",
                        style: AppStyle.customTextTheme(
                            ColorUtils.black, FontWeight.w500, 16))),
                    SizedBox(height: 10),
                 */
/*   SizedBox(
                      width: 100,
                      height: 30,
                      child: CustomLoadingButton(
                          isLoading: false,
                          title: "Pay Now",
                          onPress: () {
                            Get.to(BordingDropingPage());
                          }),
                    )*/ /*

                  ],
                ),
              ),
*/
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        )),
                  ],
                ));
                /*     )
                  ],
                );*/
              } else {
                return Text("");
              }
            },
          )),
    );
  }

  @override
  void initState() {
    bloc.add(GetBusDetails(BusDetailRequest(
        agentId: SharedPrefUtils.getAgentId(),
        agentType: "bus_agent_app",
        arrivalTime: myController.selectedBus!.arrivalTime,
        busLayoutId: myController.selectedBus!.buslayoutId.toString(),
        coachId: myController.selectedBus!.coachId.toString(),
        date: myController.selectedBus!.date,
        departureTime: myController.selectedBus!.departureTime,
        endId: myController.selectedBus!.destination.toString(),
        label: myController.selectedBus!.label,
        lang: 'en',
        routeId: myController.selectedBus!.routeId.toString(),
        routeId1: myController.selectedBus!.routeId1.toString(),
        routeViacityId: myController.selectedBus!.routeViaCityId.toString(),
        routeViacityId1: 1,
        startId: myController.selectedBus!.source.toString())));

    myController.selectedList.clear();
    super.initState();
  }
}

Widget colorLayoutUI(color, title) {
  return Container(
    padding: EdgeInsets.all(5),
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: color,
            boxShadow: [
              BoxShadow(color: color, spreadRadius: 3),
            ],
          ),
          height: 24,
          width: 24,
        ),
        Text(title,
            style:
                AppStyle.customTextTheme(ColorUtils.grey, FontWeight.w500, 12))
      ],
    ),
  );
}

Widget seatLayout(color, title) {
  return Container(
    //  padding: EdgeInsets.only(left: 5,right: 5),
    margin: EdgeInsets.only(top: 10),
    child: Column(
      children: [
        Container(
          //  margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: color,
            boxShadow: [
              BoxShadow(color: color, spreadRadius: 3),
            ],
          ),
          height: 30,
          width: 30,
          child: Center(
              child: Text(title,
                  style: AppStyle.customTextTheme(
                      ColorUtils.black, FontWeight.w500, 14))),
        ),
      ],
    ),
  );
}

class seatBottomSheet extends StatelessWidget {
  seatBottomSheet({
    Key? key,
    required this.myController,
  }) : super(key: key);
  final MyController myController;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        height: 130,
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Ticket price",
                        style: AppStyle.customTextTheme(
                            ColorUtils.grey, FontWeight.w500, 14)),
                    Text("TZS. ${myController.selectedBus!.fare}",
                        style: AppStyle.customTextTheme(
                            ColorUtils.black, FontWeight.w500, 16))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Total price",
                        style: AppStyle.customTextTheme(
                            ColorUtils.grey, FontWeight.w500, 14)),
                    Text(
                        "TZS. ${myController.selectedBus!.fare * myController.selectedList.length}",
                        style: AppStyle.customTextTheme(
                            ColorUtils.black, FontWeight.w500, 16))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Selected seats",
                        style: AppStyle.customTextTheme(
                            ColorUtils.grey, FontWeight.w500, 14)),
                    Text("${myController.selectedList.length} ",
                        style: AppStyle.customTextTheme(
                            ColorUtils.black, FontWeight.w500, 16)),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 100,
                      height: 30,
                      child: CustomLoadingButton(
                          isLoading: false,
                          title: "Pay Now",
                          onPress: () {
                            Get.to(BordingDropingPage());
                          }),
                    )
                  ],
                ),
              ),
/*
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Selected seats",
                        style: AppStyle.customTextTheme(
                            ColorUtils.grey, FontWeight.w500, 14)),
                    Obx(() => Text("${myController.selectedList.length} ",
                        style: AppStyle.customTextTheme(
                            ColorUtils.black, FontWeight.w500, 16))),
                    SizedBox(height: 10),
                 */
/*   SizedBox(
                      width: 100,
                      height: 30,
                      child: CustomLoadingButton(
                          isLoading: false,
                          title: "Pay Now",
                          onPress: () {
                            Get.to(BordingDropingPage());
                          }),
                    )*/ /*

                  ],
                ),
              ),
*/
            ],
          ),
        ));
  }
}
