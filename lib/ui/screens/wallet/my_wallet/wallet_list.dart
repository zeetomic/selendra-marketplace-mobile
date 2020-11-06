import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class WalletList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: wallets.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kDefaultRadius),
              side: BorderSide(
                color: kDefaultColor,
              ),
            ),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  RouteAnimation(
                    enterPage: TransactionHistory(
                        title: wallets[index].title,
                        amount: wallets[index].amount),
                  ),
                );
              },
              trailing: Text(
                wallets[index].amount,
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              leading: Image.asset(wallets[index].logo, width: 30, height: 30),
              title: Text(
                wallets[index].title,
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          );
        },
      ),
    );
  }
}
