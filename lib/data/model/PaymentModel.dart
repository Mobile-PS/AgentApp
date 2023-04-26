
class PaymentModel {
  int? responseCode;
  String? responseMessage;
  List<CList>? list;

  PaymentModel({this.responseCode, this.responseMessage, this.list});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    if (json['list'] != null) {
      list = <CList>[];
      json['list'].forEach((v) {
        list!.add(new CList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CList {
  String? category;
  List<ChannelList>? channelList;

  CList({this.category, this.channelList});

  CList.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    if (json['channelList'] != null) {
      channelList = <ChannelList>[];
      json['channelList'].forEach((v) {
        channelList!.add(new ChannelList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    if (this.channelList != null) {
      data['channelList'] = this.channelList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChannelList {
  int? id;
  String? channelType;
  String? code;
  String? channel;
  List<Instruction>? instruction;

  ChannelList(
      {this.id, this.channelType, this.code, this.channel, this.instruction});

  ChannelList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    channelType = json['channelType'];
    code = json['code'];
    channel = json['channel'];
    if (json['instruction'] != null) {
      instruction = <Instruction>[];
      json['instruction'].forEach((v) {
        instruction!.add(new Instruction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['channelType'] = this.channelType;
    data['code'] = this.code;
    data['channel'] = this.channel;
    if (this.instruction != null) {
      data['instruction'] = this.instruction!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Instruction {
  int? id;
  Null? channels;
  dynamic? instructionEn;
  dynamic? instructionSw;
  bool? status;

  Instruction(
      {this.id,
        this.channels,
        this.instructionEn,
        this.instructionSw,
        this.status});

  Instruction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    channels = json['channels'];
    instructionEn = json['instruction_en'];
    instructionSw = json['instruction_sw'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['channels'] = this.channels;
    data['instruction_en'] = this.instructionEn;
    data['instruction_sw'] = this.instructionSw;
    data['status'] = this.status;
    return data;
  }
}