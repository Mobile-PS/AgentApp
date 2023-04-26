
class PaymentUpdateModel {
  int? responseCode;
  String? responseMessage;
  String? ticketID;
  String? pnr;
  Null? bankInfo;
  Null? accountName;

  PaymentUpdateModel(
      {this.responseCode,
        this.responseMessage,
        this.ticketID,
        this.pnr,
        this.bankInfo,
        this.accountName});

  PaymentUpdateModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    ticketID = json['ticketID'];
    pnr = json['pnr'];
    bankInfo = json['bankInfo'];
    accountName = json['accountName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    data['ticketID'] = this.ticketID;
    data['pnr'] = this.pnr;
    data['bankInfo'] = this.bankInfo;
    data['accountName'] = this.accountName;
    return data;
  }
}