// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromMap(jsonString);

import 'dart:convert';

class LoginResponse {
  LoginResponse({
    this.responseCode,
    this.responseMessage,
    this.agentId,
    this.agentType,
    this.agentName,
    this.status,
    this.permission,
    this.insuranceTieup,
  });

  int? responseCode;
  String? responseMessage;
  int? agentId;
  String? agentType;
  String? agentName;
  String? status;
  List<Permission>? permission;
  bool? insuranceTieup;

  factory LoginResponse.fromJson(String str) => LoginResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
    responseCode: json["responseCode"] == null ? null : json["responseCode"],
    responseMessage: json["responseMessage"] == null ? null : json["responseMessage"],
    agentId: json["agentId"] == null ? null : json["agentId"],
    agentType: json["agent_type"] == null ? null : json["agent_type"],
    agentName: json["agentName"] == null ? null : json["agentName"],
    status: json["status"] == null ? null : json["status"],
    permission: json["permission"] == null ? null : List<Permission>.from(json["permission"].map((x) => Permission.fromMap(x))),
    insuranceTieup: json["insuranceTieup"] == null ? null : json["insuranceTieup"],
  );

  Map<String, dynamic> toMap() => {
    "responseCode": responseCode == null ? null : responseCode,
    "responseMessage": responseMessage == null ? null : responseMessage,
    "agentId": agentId == null ? null : agentId,
    "agent_type": agentType == null ? null : agentType,
    "agentName": agentName == null ? null : agentName,
    "status": status == null ? null : status,
    "permission": permission == null ? null : List<dynamic>.from(permission!.map((x) => x.toMap())),
    "insuranceTieup": insuranceTieup == null ? null : insuranceTieup,
  };
}

class Permission {
  Permission({
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn,
    this.permissionId,
    this.permissiontype,
    this.moduleId,
    this.subModuleId,
    this.status,
    this.value,
  });

  int? createdBy;
  dynamic createdOn;
  int? modifiedBy;
  dynamic modifiedOn;
  int? permissionId;
  String? permissiontype;
  dynamic moduleId;
  dynamic subModuleId;
  dynamic status;
  dynamic value;

  factory Permission.fromJson(String str) => Permission.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Permission.fromMap(Map<String, dynamic> json) => Permission(
    createdBy: json["created_by"] == null ? null : json["created_by"],
    createdOn: json["created_on"],
    modifiedBy: json["modified_by"] == null ? null : json["modified_by"],
    modifiedOn: json["modified_on"],
    permissionId: json["permissionID"] == null ? null : json["permissionID"],
    permissiontype: json["permissiontype"] == null ? null : json["permissiontype"],
    moduleId: json["moduleID"],
    subModuleId: json["subModuleID"],
    status: json["status"],
    value: json["value"],
  );

  Map<String, dynamic> toMap() => {
    "created_by": createdBy == null ? null : createdBy,
    "created_on": createdOn,
    "modified_by": modifiedBy == null ? null : modifiedBy,
    "modified_on": modifiedOn,
    "permissionID": permissionId == null ? null : permissionId,
    "permissiontype": permissiontype == null ? null : permissiontype,
    "moduleID": moduleId,
    "subModuleID": subModuleId,
    "status": status,
    "value": value,
  };
}
