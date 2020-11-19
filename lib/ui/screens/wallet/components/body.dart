import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  showAlertDialog(BuildContext context, String alertText) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        context = navigationKey.currentState.overlay.context;
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text('Oops!'),
      content: Text(alertText),
      actions: [
        okButton,
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: navigationKey.currentState.overlay.context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  onGetWallet() async {
    String _token;
    SharedPreferences isToken = await SharedPreferences.getInstance();
    _token = isToken.get('token');
    if (_token == null) {
      String alertText = 'Please Sign up with Email or Phone to get wallet';
      showAlertDialog(context, alertText);
    } else {
      Navigator.pushNamed(context, WalletPinView);
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).fetchPortforlio();
  }

  @override
  Widget build(BuildContext context) {
    return mBalance.data == null
        ? Center(
            child: WalletChoice(onGetWallet, showAlertDialog),
          )
        : MyWallet();
  }
}