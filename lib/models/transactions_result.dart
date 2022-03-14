import 'package:rmoney_test/enums/transaction_mode.dart';

class TransactionsResult {
  String? status;
  String? code;
  String? message;
  late List<ClientTransaction> clientTransactions = [];

  TransactionsResult({this.status, this.code, this.message});

  TransactionsResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null && json['data']['clientTransactions'] != null) {
      clientTransactions = <ClientTransaction>[];
      json['data']['clientTransactions'].forEach((v) {
        clientTransactions.add(ClientTransaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    data['data']['clientTransactions'] =
        this.clientTransactions.map((v) => v.toJson()).toList();
    return data;
  }
}

class ClientTransaction {
  num? transactionId;
  String? type;
  num? amount;
  String? comment;
  String? entryDate;
  String? currencyCode;
  String? balance;

  ClientTransaction(
      {this.transactionId,
        this.type,
        this.amount,
        this.comment,
        this.entryDate,
        this.currencyCode,
        this.balance});

  ClientTransaction.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'];
    type = json['type'];
    amount = json['amount'];
    comment = json['comment'];
    entryDate = json['entryDate'];
    currencyCode = json['currencyCode'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transactionId'] = this.transactionId;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['comment'] = this.comment;
    data['entryDate'] = this.entryDate;
    data['currencyCode'] = this.currencyCode;
    data['balance'] = this.balance;
    return data;
  }

  TransactionMode get transactionMode {
    if(type == "TRANSFER" || type == "WITHDRAWAL") {
      return TransactionMode.outward;
    }

    return TransactionMode.inward;
  }
}
