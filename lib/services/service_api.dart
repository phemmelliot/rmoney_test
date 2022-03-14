import 'package:rmoney_test/dependency/injector.dart';
import 'package:rmoney_test/models/transactions_result.dart';
import 'package:rmoney_test/services/web_service.dart';

class ServiceAPI {
  final WebService webService = dependencyInjector.get<WebService>();
  ServiceAPI();

  Future<List<ClientTransaction>?> getTransactions() async {
    return (await webService.getTransactions()).clientTransactions;
  }
}
