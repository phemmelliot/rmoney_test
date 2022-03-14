import 'package:flutter/material.dart';
import 'package:rmoney_test/utils/app_colors.dart';

class NetworkErrorRetryWidget extends StatelessWidget {
  final String message;
  final Function onTap;

  const NetworkErrorRetryWidget({Key? key, required this.message, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
      child: Column(
        children: [
          Image.asset(
            'assets/wifiSlash.png',
            height: 88,
            width: 88,
          ),
          SizedBox(height: 38),
          Text(
            message,
            style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.normal, height: 1.43),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          Container(
            height: 40,
            width: 120,
            child: RaisedButton(
              onPressed: () {
                onTap();
              },
              child: Text("RETRY", style: TextStyle(color: Colors.white),),
              color: AppColors.purpleTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
