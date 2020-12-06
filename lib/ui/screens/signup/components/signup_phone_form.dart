import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:selendra_marketplace_app/core/services/app_services.dart';

String _phone, _password;

class SignUpPhoneForm extends StatelessWidget {
  final Function signUpPhoneFunc;
  final Function facebookSignIn;
  final Function googleSignIn;

  SignUpPhoneForm(this.signUpPhoneFunc, this.facebookSignIn, this.googleSignIn);

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _phoneFormKey = GlobalKey<FormState>();

  void validateAndSubmit() {
    if (_phoneFormKey.currentState.validate()) {
      _phoneFormKey.currentState.save();
      signUpPhoneFunc(_phone, _password);

      _phoneController.text = '';
      _passwordController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _phoneFormKey,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              child: IntlPhoneField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: _lang.translate('phone_hint'),
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kDefaultColor),
                    borderRadius: BorderRadius.all(
                      Radius.circular(kDefaultRadius),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent),
                      borderRadius:
                          BorderRadius.all(Radius.circular(kDefaultRadius))),
                ),
                autoValidate: false,
                initialCountryCode: 'KH',
                validator: (value) => value.isEmpty ? "Phone is empty" : null,
                onChanged: (phone) {
                  _phone = "+855" +
                      AppServices.removeZero(_phoneController.text.toString());
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ReusePwField(
              controller: _passwordController,
              labelText: _lang.translate('password'),
              validator: (value) => value.isEmpty || value.length < 6
                  ? _lang.translate('password_is_empty')
                  : null,
              onSaved: (value) => _password = value,
            ),
            SizedBox(
              height: 40,
            ),
            ReuseButton.getItem(_lang.translate('signup_string'), () {
              validateAndSubmit();
            }, context),
            SizedBox(height: 10),
            ReuseFlatButton.getItem(_lang.translate('had_an_account'),
                _lang.translate('signin_string'), () {
              Navigator.pushReplacementNamed(context, SignInView);
            }),
            SizedBox(
              height: 10,
            ),
            Text(
              _lang.translate('or_string'),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            _buildBtnSocialRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildBtnSocialRow() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BtnSocial(() {
            facebookSignIn();
          }, AssetImage('images/facebook.jpg')),
          SizedBox(width: 20),
          BtnSocial(() {
            googleSignIn();
          }, AssetImage('images/google.jpg')),
        ],
      ),
    );
  }
}
