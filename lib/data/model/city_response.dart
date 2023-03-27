// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromMap(jsonString);

import 'dart:convert';

class CityResponse {
  CityResponse({
      this.responseCode,
      this.responseMessage,
      this.cityList
  });

  int? responseCode;
  String? responseMessage;
  List<CityItem>? cityList;

  factory CityResponse.fromJson(String str) => CityResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CityResponse.fromMap(Map<String, dynamic> json) => CityResponse(
    responseCode: json["responseCode"] == null ? null : json["responseCode"],
    responseMessage: json["responseMessage"] == null ? null : json["responseMessage"],
    cityList: json["cityList"] == null ? null : List<CityItem>.from(json["cityList"].map((x) => CityItem.fromMap(x))),

  );



  Map<String, dynamic> toMap() => {
    "responseCode": responseCode == null ? null : responseCode,
    "responseMessage": responseMessage == null ? null : responseMessage,
    "cityList": cityList == null ? null : List<dynamic>.from(cityList!.map((x) => x.toMap()))
  };
}

class CityItem
{
  int? cityId;
  String? cityName;

  CityItem({
      this.cityId,
      this.cityName});


  factory CityItem.fromJson(String str) => CityItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CityItem.fromMap(Map<String, dynamic> json) => CityItem(
      cityId: json["cityId"] == null ? null : json["cityId"],
      cityName: json["cityName"] == null ? null : json["cityName"]
  );

  Map<String, dynamic> toMap() => {
    "cityId": cityId == null ? null : cityId,
    "cityName": cityName == null ? null : cityName,
  };

}
