import 'package:dio/dio.dart';
import 'package:rmoney_test/dependency/injector.dart';
import 'package:rmoney_test/models/transactions_result.dart';
import 'package:rmoney_test/models/web_error.dart';

class WebService {
  Dio httpClient = dependencyInjector.get<Dio>();
  
  Future<TransactionsResult> getTransactions() async {
    try {
      var response = await httpClient.get("https://api-sandbox.renmoney.com/deposit-transfer/api/v3/investment/3580016662/transactions");

      if (response.statusCode == 200) {
        return TransactionsResult.fromJson(response.data);
      } else {
        throw WebError("An error occurred while fetching data from the server, please try again");
      }
    } catch(e) {
      throw WebError("An error occurred while fetching data from the server, please try again");
    }
  }
}
