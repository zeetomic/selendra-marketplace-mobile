import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  PrefService _pref = PrefService();

  List<String> svg = [
    'images/undraw_wallet.svg',
    'images/undraw_loving_it.svg',
    'images/undraw_empty_cart.svg',
    'images/undraw_Mobile_application.svg'
        'images/packaging.svg'
  ];

  void checkUser() {
    //READ TOKEN
    _pref.read('token').then(
      (value) async {
        print("Token $value");
        if (value != null) {
          Provider.of<ProductsProvider>(context, listen: false)
              .fetchListingProduct();
          Provider.of<UserProvider>(context, listen: false).fetchPortforlio();
          Provider.of<SellerProvider>(context, listen: false).fetchBuyerOrder();
          AuthProvider().currentUser.then(
            (value) {
              if (value != null) {
                //Fetch user profile and navigate to home screen
                Provider.of<UserProvider>(context, listen: false)
                    .fetchSocialUserInfo(
                        value.email, value.displayName, value.photoUrl);
                Navigator.pushReplacementNamed(context, BottomNavigationView);
              } else {
                //CHECK SOCIAL ACCOUNT LOGIN USER
                //FETCH USER PROFILE AND NAVIGATE
                Provider.of<UserProvider>(context, listen: false)
                    .fetchUserInfo();
                Navigator.pushReplacementNamed(context, BottomNavigationView);
              }
            },
          );

          // //FETCH USER PROFILE AND NAVIGATE
          // Provider.of<UserProvider>(context, listen: false).fetchUserInfo();

          // //Provider.of<ProductsProvider>(context, listen: false).getVegi();
          // Navigator.pushReplacementNamed(context, BottomNavigationView);
          // // await UserProvider().fetchPortforlio().then(
          // //   (onValue) {
          // //     //CHECK IF TOKEN IS VALID
          // //     if (onValue == '200') {
          // //       //FETCH USER PROFILE AND NAVIGATE
          // //       Provider.of<UserProvider>(context, listen: false).fetchUserInfo();
          // //       //Provider.of<ProductsProvider>(context, listen: false).getVegi();
          // //       Navigator.pushReplacementNamed(context, BottomNavigationView);
          // //     } else {
          // //       //IF NOT VALID CLEAR TOKEN AND NAVIGATE TO WELCOME SCREEN
          // //       _pref.clear('token');
          // //       Navigator.pushReplacementNamed(context, WelcomeView);
          // //     }
          // //   },
          // // );
        } else {
          Navigator.pushReplacementNamed(context, WelcomeView);
          // print("")

        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    //Check auth
    Timer(
      Duration(milliseconds: 2000),
      () {
        _pref.read('isshow').then(
          (onValue) {
            if (onValue == null) {
              Navigator.pushReplacementNamed(context, IntroScreenView);
            } else {
              checkUser();
            }
          },
        );
      },
    );

    //Pre svg image
    for (int i = 0; i < svg.length; i++) {
      precachePicture(
          ExactAssetPicture(SvgPicture.svgStringDecoder, svg[i]), null);
    }

    //SET LANGUAGE
    var _lang = Provider.of<LangProvider>(context, listen: false);
    _pref.read('lang').then(
      (value) {
        _lang.setLocal(value, context);
        // print(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetworkAlert(
        Center(
          child: Image.asset(
            'images/logo.png',
            height: 200,
            width: 200,
          ),
        ),
      ),
    );
  }
}
