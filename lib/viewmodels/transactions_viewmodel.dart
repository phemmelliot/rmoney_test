import 'package:flutter/cupertino.dart';
import 'package:rmoney_test/dependency/injector.dart';
import 'package:rmoney_test/models/transactions_result.dart';
import 'package:rmoney_test/models/web_error.dart';
import 'package:rmoney_test/services/service_api.dart';

class TransactionsViewModel extends ChangeNotifier {
  final ServiceAPI service = dependencyInjector.get<ServiceAPI>();

  List<ClientTransaction> transactions = [];
  String? errorMessage;
  bool loading = false;

  Future<void> getTransactions() async {
    try {
      loading = true;
      errorMessage = null;
      notifyListeners();

      transactions = (await service.getTransactions()) as List<ClientTransaction>;
    } on WebError catch(e) {
      errorMessage = e.errorMessage;
    } catch(e) {
      errorMessage = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
