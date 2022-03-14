import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rmoney_test/enums/transaction_mode.dart';
import 'package:rmoney_test/models/transactions_result.dart';
import 'package:rmoney_test/screens/transaction_detail.dart';
import 'package:rmoney_test/utils/app_colors.dart';
import 'package:rmoney_test/utils/app_utils.dart';

class TransactionCard extends StatelessWidget {
  final ClientTransaction? transaction;

  const TransactionCard({Key? key, required this.transaction})
      : super(key: key);

  Widget amountWidget() {
    Color textColor = transaction?.amount?.isNegative ?? false
        ? AppColors.redTextColor
        : AppColors.greenTextColor;

    return Text(
      AppUtils.formatCurrency(transaction?.amount ?? 0),
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14,
        color: textColor,
      ),
    );
  }

  Widget detailWidget() {
    TextStyle normalStyle = TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.normal,
        color: AppColors.blackText);

    bool hasTo = (transaction?.comment?.toLowerCase().contains("to") ?? false);
    bool hasFrom = (transaction?.comment?.toLowerCase().contains("from") ?? false);
    bool isRichText = hasTo || hasFrom;

    if (isRichText) {
      List<String> splittedText = [];
      if (hasFrom) {
        splittedText = transaction?.comment?.split("from") as List<String>;
        splittedText[0] = "${splittedText[0]}from";
      } else if (hasTo) {
        splittedText = transaction?.comment?.split("to") as List<String>;
        splittedText[0] = "${splittedText[0]}to";
      }

      if (splittedText.length > 2) {
        String secondElement = splittedText[1];

        for (int i = 2; i < splittedText.length; i++) {
          secondElement = "$secondElement${hasTo ? "to" : "from"}${splittedText[i]}";
        }

        splittedText = [splittedText[0], secondElement];
      }

      return RichText(
        text: TextSpan(
          style: normalStyle,
          children: [
            TextSpan(text: splittedText[0]),
            TextSpan(
              text: splittedText[1],
              style: TextStyle(
                color: AppColors.purpleTextColor,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      );
    }

    return Text(
      transaction?.comment ?? transaction?.type ?? "Transaction",
      style: normalStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    String iconString;
    switch (transaction?.transactionMode ?? TransactionMode.outward) {
      case TransactionMode.outward:
        iconString = "assets/outwards_icon.png";
        break;
      case TransactionMode.inward:
        iconString = "assets/inwards_icon.png";
        break;
    }

    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return TransactionDetail(transaction: transaction as ClientTransaction);
        }));
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.transactionCardBgColor),
        child: Row(
          children: [
            Image.asset(
              iconString,
              height: 40,
              width: 40,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  detailWidget(),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    Jiffy(DateTime.parse(transaction?.entryDate ?? ""))
                        .format("d MMM, yyyy"),
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.darkGrey,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: amountWidget(),
            )
          ],
        ),
      ),
    );
  }
}
