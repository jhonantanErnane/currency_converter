import 'package:currency_converter/app/shared/enums/enum_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login to your app',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (value) => controller.changeTheme(value),
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              itemBuilder: (_) {
                return [
                  PopupMenuItem(
                    child: Text('Tema claro'),
                    value: EnumTheme.LIGHTTHEME,
                  ),
                  PopupMenuItem(
                    child: Text('Tema escuro'),
                    value: EnumTheme.DARKTHEME,
                  )
                ];
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 10),
          child: Column(
            children: <Widget>[
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      decoration:
                          InputDecoration(hintText: 'Username or Email'),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Password'),
                    ),
                    _customSizedBox(screenSize, 0.05),
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () => Modular.to.pushReplacementNamed('/home'),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text('LOG IN'),
                      ),
                    )
                  ],
                ),
              ),
              _customSizedBox(screenSize, 0.05),
              _buildDivider(screenSize),
              _customSizedBox(screenSize, 0.05),
              _buildButtonSocial(
                  Color(0xFF3C4858), 'facebook.png', 'LOGIN WITH FACEBOOK'),
              _customSizedBox(screenSize, 0.02),
              _buildButtonSocial(
                  Color(0xFF8492A6), 'twitter.png', 'LOGIN WITH TWITTER'),
              _customSizedBox(screenSize, 0.02),
              _buildButtonSocial(
                  Color(0xFFC0CCDA), 'google-plus.png', 'LOGIN WITH GOOGLE'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customSizedBox(Size screenSize, double value) {
    return SizedBox(
      height: screenSize.height * value,
    );
  }

  Widget _buildButtonSocial(
      Color buttonColor, String imageName, String labelButton) {
    return RaisedButton(
      onPressed: () {},
      color: buttonColor,
      textColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            Image.asset(
              'images/$imageName',
              height: 20,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  labelButton,
                  style: TextStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(Size screenSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          Expanded(child: Divider()),
          SizedBox(width: 8),
          Text('OR'),
          SizedBox(width: 8),
          Expanded(child: Divider())
        ],
      ),
    );
  }
}
