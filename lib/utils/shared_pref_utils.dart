

import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:ticket_agent/utils/string_utils.dart';

import '../data/model/login_response.dart';

class SharedPrefUtils
{

 static GetStorage getxStrorage = GetStorage();


 static void setData(String key, dynamic value) => getxStrorage.write(key, value);

 static int? getInt(String key) =>getxStrorage.read(key);

 static String? getString(String key) => getxStrorage.read(key);

 static bool? getBool(String key) => getxStrorage.read(key);

 static double? getDouble(String key) => getxStrorage.read(key);

 static dynamic getData(String key) => getxStrorage.read(key);

 static void clearData() async => getxStrorage.erase();



 //Returned the logined in user

 static LoginResponse? getLoginedInUser()
 {
  String? data= SharedPrefUtils.getString(StringUtils.loginInfosp);
  return data!=null?LoginResponse.fromJson(data):null;

 }

  static int getAgentId()
 {
  String? data= SharedPrefUtils.getString(StringUtils.loginInfosp);
  LoginResponse loginResponse = LoginResponse.fromJson(data!);
  return loginResponse.agentId??0;

 }

 static String? getUserName()
 {
  return SharedPrefUtils.getString(StringUtils.username);
 }


}
