import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rmoney_test/models/transactions_result.dart';
import 'package:rmoney_test/utils/app_colors.dart';
import 'package:rmoney_test/utils/app_utils.dart';

class TransactionDetail extends StatelessWidget {
  final ClientTransaction transaction;
  final TextStyle normalTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.darkGrey,
  );

  final TextStyle boldTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.darkGrey,
  );

   TransactionDetail({Key? key, required this.transaction})
      : super(key: key);
  
  Widget detailRow(String label, String value) {
    return Row(
      children: [
        Text(label, style: normalTextStyle,),
        Spacer(),
        Text(value, style: boldTextStyle,),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purpleBackground,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 60),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Transaction Details",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 16, top: 35, bottom: 50, right: 35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Detailed summary of transaction",
                    style: normalTextStyle.copyWith(color: AppColors.purpleTextColor),
                  ),
                  SizedBox(height: 22),
                  detailRow("Amount", AppUtils.formatCurrency(transaction.amount ?? 0),),
                  SizedBox(height: 30),
                  detailRow("Transaction date", Jiffy(DateTime.parse(transaction.entryDate ?? ""))
                      .format("d MMM, yyyy"),),
                  SizedBox(height: 30),
                  detailRow("Transaction Type", transaction.type as String,),
                  SizedBox(height: 30),
                  detailRow("Balance", AppUtils.formatCurrency(num.parse(transaction.balance ?? "0")),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
