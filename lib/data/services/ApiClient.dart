import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import "package:http_parser/http_parser.dart" as http_parser;
import 'package:ticket_agent/data/model/BookingResponse.dart';
import 'package:ticket_agent/data/model/BusDetailResponse.dart';
import 'package:ticket_agent/data/model/BusRouteResponse.dart';
import 'package:ticket_agent/data/model/GetTicketInfoByPNRResponse.dart';
import 'package:ticket_agent/data/model/OperatorResponse.dart';
import 'package:ticket_agent/data/model/booking_req.dart';
import 'package:ticket_agent/data/model/changePasswordRequest.dart';
import 'package:ticket_agent/data/model/city_response.dart';
import 'package:ticket_agent/data/model/login_response.dart';
import 'package:ticket_agent/data/model/saveNewPasswordRequest.dart';
import 'package:ticket_agent/data/model/saveNewPasswordResponse.dart';
import 'package:ticket_agent/utils/string_utils.dart';

import '../model/BordingPointsResponce.dart';
import '../model/BusDetailRequest.dart';
import '../model/CancleTicketResponse.dart';
import '../model/PaymentModel.dart';
import '../model/PaymentUpdateModel.dart';
import '../model/ReservationChartDetailsResponce.dart';
import '../model/SaveTicketResponse.dart';
import '../model/agentProfileResponse.dart';
import '../model/bus_layout_filter_response.dart';
import '../model/changePasswordResponse.dart';
import '../model/forgotPasswordResponse.dart';

class ApiClient {
  Dio _dio = Dio();
  Dio _dio1 = Dio();

  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: StringUtils.base_url,
      connectTimeout: 100000,
      receiveTimeout: 100000,
    ));

    _dio1 = Dio(BaseOptions(
      baseUrl: StringUtils.base_url1,
      connectTimeout: 100000,
      receiveTimeout: 100000,
    ));
    initializeInterceptors();
  }

  // login api calling
  Future<LoginResponse?> loginApi(String username, String password) async {
    Response response = await _dio.post('agentLogin',
        data: {'username': username, 'password': password},
        options: Options(method: 'POST'));
    return LoginResponse.fromMap(response.data);
  }

  Future<OperatorResponse?> getOperatorList(int agentId) async {
    Response response = await _dio.post('getOperatorList',
        data: {'agent_id': agentId}, options: Options(method: 'POST'));
    return OperatorResponse.fromJson(response.data);
  }

  //busTypeLayoutFilter

  Future<BusLayoutFilterResponse> getBusLayoutFilters() async {
    Response response = await _dio.post("busLayoutFilter");
    return BusLayoutFilterResponse.fromMap(response.data);
  }

  Future<CityResponse> getCities() async {
    Response response = await _dio.post("getCity");
    return CityResponse.fromMap(response.data);
  }

  Future<BusRouteResponse> getBusRoutes(
      int agentId,
      String busType,
      String date,
      int destination,
      String lang,
      int operatorId,
      int source) async {
    //  print("agentId $agentId , busType $busType , date $date , src $source , dest $destination , lang $lang , operator  $operatorId");
    Response response = await _dio.post("searchRoute",
        data: {
          "agentId": agentId,
          "busType": busType,
          "date": date, //"2022-12-18",
          "destination": destination,
          "lang": lang, //"en",
          "operatorId": operatorId, //0
          "source": source
        },
        options: Options(method: 'POST'));
    return BusRouteResponse.fromJson(response.data);
  }

  Future<BusDetailResponse?> getBusDetailsApi(BusDetailRequest request) async {
    print("getBusDetails ${request.toJson()}");
    Response response = await _dio.post('getBusDetails',
        data: request.toJson(), options: Options(method: 'POST'));
    return BusDetailResponse.fromJson(response.data);
  }

  Future<BoardingPointsResponse?> bordingPointsApi(
      String routeID, String startId, String stopId) async {
    print("apitesting : $routeID  $startId $stopId");
    Response response = await _dio.post('getBoardingPoints',
        data: {"routeId": routeID, "startId": startId, "stopId": stopId},
        options: Options(method: 'POST'));

    return BoardingPointsResponse.fromJson(response.data);
  }

  // Future<SaveTicketResponse?> getSaveTicketApi(SaveTicketRequest request)  async {
  //   Response response = await _dio.post('getSaveTicket',
  //       data: request.toJson(),
  //       options: Options(method:'POST'));
  //   return SaveTicketResponse.fromJson(response.data);
  // }

  Future<CancleTicketResponse?> cancelTicketApi(String pnr, int agentId) async {
    Response response = await _dio.post('getTicketCancellationDetails',
        data: {"pnr": pnr, "agentId": agentId},
        options: Options(method: 'POST'));
    return CancleTicketResponse.fromJson(response.data);
  }

  Future<ChangePasswordResponse?> changepasswordApi(String agentId,
      String username, String oldPassword, String newPassword) async {
    Response response = await _dio.post('changePassword',
        data: {
          "agent_id": agentId,
          "username": username,
          "old_password": oldPassword,
          "new_password": newPassword
        },
        options: Options(method: 'POST'));
    return ChangePasswordResponse.fromJson(response.data);
  }

  Future<ForgotPasswordResponse?> ForgotPasswordApi(String username) async {
    Response response = await _dio.post('forgotPassword',
        data: {"username": username}, options: Options(method: 'POST'));
    return ForgotPasswordResponse.fromJson(response.data);
  }

  Future<BookingResponse?> BookingApi(BookingRequest bookingRequest) async {
    print(json.encode(bookingRequest.toJson()));
    Response response = await _dio.post('saveticketDetails',
        data: bookingRequest.toJson(), options: Options(method: 'POST'));
    return BookingResponse.fromJson(response.data);
  }

  Future<PaymentModel?> getPaymentMode(int routID) async {
    Response response = await _dio1.post('getAllPaymentSource',
        data: {
            "bookingChannel": "bus_agent_app",
            "date": "2023-03-24",
            "language": "english",
            "route_id": routID
        },
         options: Options(method: 'POST'));

    return PaymentModel.fromJson(response.data);
  }

  Future<PaymentUpdateModel?> getSuccessTransaction(int channelid,var paymode,var tickid) async {
    Response response = await _dio.post('successTransaction',
        data: {
          "paymentChannel": channelid,
          "paymentMode": paymode,
          "status": "Success",
          "ticketId": tickid,
          "txnid": "0"
        },
        options: Options(method: 'POST'));

    return PaymentUpdateModel.fromJson(response.data);
  }

  Future<AgentProfileResponse?> getAgentProfile(int agentId) async {
    Response response = await _dio.post('agentProfile',
        data: {"agent_id": agentId}, options: Options(method: 'POST'));

    return AgentProfileResponse.fromJson(response.data);
  }

  Future<SaveNewPasswordResponse> getSavePasswordApi(
      String username,
      int agentId,
      String newPassword,
      String confirmPassword,
      String otp) async {
    Response response = await _dio.post('saveNewPassword',
        data: {
          "username": username,
          "agent_id": agentId,
          "newPassword": newPassword,
          "confirmPassword": confirmPassword,
          "otp": otp
        },
        options: Options(method: 'POST'));

    return SaveNewPasswordResponse.fromJson(response.data);
  }

  Future<ReservationChartDetailsResponce?> reservationChartDetailsApi(
      int routeId, String date, int routeViaCityId) async {
    Response response = await _dio.post('getReservationChartDetails',
        data: {
          "routeId": routeId,
          "date": date,
          "routeViaCityId": routeViaCityId,
        },
        options: Options(method: 'POST'));
    return ReservationChartDetailsResponce.fromJson(response.data);
  }

  Future<GetTicketInfoByPnrResponse?> getTicketInfoByPNR(
      String pnr, String lang, String agentType) async {
    Response response = await _dio.post('getTicketDetailsByPnr',
        data: {"pnr": pnr, "lang": lang, "agent_type": agentType},
        options: Options(method: 'POST'));
    return GetTicketInfoByPnrResponse.fromJson(response.data);
  }

  initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent
      print("ERRRRORRRR ${options.data}");
      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: `handler.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: `handler.reject(dioError)`
    }, onResponse: (response, handler) {
      print("ERRRRORRRR ${response.data}");
      // Do something with response data
      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: `handler.reject(dioError)`
    }, onError: (DioError e, handler) {
      print("ERRRRORRRR ${e.error}");
      // Do something with response error
      return handler.next(e); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: `handler.resolve(response)`.
    }));
  }
}
