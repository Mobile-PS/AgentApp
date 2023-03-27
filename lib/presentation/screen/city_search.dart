import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ticket_agent/data/model/city_response.dart';
import 'package:ticket_agent/utils/LangConstants.dart';
import 'package:ticket_agent/utils/MyThemes.dart';

import '../../business_logic/sharebloc/shared_bloc.dart';
import '../../data/repos/SharedRepository.dart';

class SearchCityPage extends StatefulWidget {
  const SearchCityPage({Key? key}) : super(key: key);

  @override
  State<SearchCityPage> createState() => _SearchCityPageState();
}

class _SearchCityPageState extends State<SearchCityPage> {

  SharedBloc bloc = SharedBloc(sharedRepository: SharedRepository());

  List<CityItem> cityList =[];
  List<CityItem> filterCityList =[];
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: TextField(
            cursorColor: Colors.white,
             autofocus: true,
             focusNode: FocusNode(),
            controller: _controller,
            decoration: InputDecoration(
              hintText: LangConstants.ac_sr_bs_search.tr,
              hintStyle: AppStyle.customTextTheme(Colors.white, FontWeight.w400, 20),
              focusColor: Colors.blue,
              suffixIcon: IconButton(
                onPressed:(){
                  setState(()
                  {
                    filterCityList = cityList.where((i) => i.cityName!.toLowerCase().contains(_controller.text.toLowerCase())).toList();
                  });

                },
                icon: Icon(Icons.search,color: Colors.white,),
              ),
            ),
               onChanged: (value)
              {
                setState(()
                {
                  filterCityList = cityList.where((i) => i.cityName!.toLowerCase().contains(_controller.text.toLowerCase())).toList();
                });

              },
            style: AppStyle.customTextTheme(Colors.white, FontWeight.w400, 20),
          ),
        ),
        body: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {


            if (state is LoadingState) {
              return Center(child: CircularProgressIndicator(),
              );
            } else if (state is CityLoadedState) {

              CityResponse cityResponse = state.value;
              cityList=cityResponse.cityList!;

              if(_controller.text.isEmpty)
                {
                  filterCityList=cityList;
                }
              else
                {
                  filterCityList = cityList.where((i) => i.cityName!.toLowerCase().contains(_controller.text.toLowerCase())).toList();

                }


              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: filterCityList.length,
                  itemBuilder: (contextx, index) {
                    return InkWell(
                      onTap: () {
                        Get.back(result: filterCityList[index]);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                            child: Text(filterCityList[index].cityName
                                .toString(),style: AppStyle.customTextTheme(Colors.black, FontWeight.w500, 16),),
                          ),
                          Divider(
                            thickness: 1,
                          ), //
                        ],
                      ),
                    );
                  });

            } else {

              return Center(child: Text("Something went wrong"));
            }
          },
        ),
      );

  }

  @override
  void initState() {
    bloc.add(CityLoadEvent());
    super.initState();
  }
}
