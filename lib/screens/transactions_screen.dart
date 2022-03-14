import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmoney_test/models/transactions_result.dart';
import 'package:rmoney_test/utils/app_colors.dart';
import 'package:rmoney_test/viewmodels/transactions_viewmodel.dart';
import 'package:rmoney_test/widgets/error_retry_widget.dart';
import 'package:rmoney_test/widgets/transaction_card.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  late List<ClientTransaction> clientTransactions;
  late TransactionsViewModel transactionsViewModel;

  @override
  void initState() {
    transactionsViewModel = TransactionsViewModel();
    transactionsViewModel.getTransactions();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "All Transactions",
          style: TextStyle(
            color: AppColors.purpleTextColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      body: ChangeNotifierProvider(
        create: (context) => transactionsViewModel,
        builder: (context, child) {
          clientTransactions = context.watch<TransactionsViewModel>().transactions;

          if (context.watch<TransactionsViewModel>().errorMessage != null) {
            return Center(
              child: NetworkErrorRetryWidget(
                  message: transactionsViewModel.errorMessage as String,
                  onTap: context.read<TransactionsViewModel>().getTransactions,
              ),
            );
          }

          if (context.watch<TransactionsViewModel>().loading) {
            return Center(child: CircularProgressIndicator.adaptive(strokeWidth: 10,));
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: ListView.separated(
              itemBuilder: (context, index){
                return TransactionCard(transaction: clientTransactions[index]);
              },
              itemCount: clientTransactions.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 15,);
              },
            ),
          );
        },
      ),
    );
  }
}
