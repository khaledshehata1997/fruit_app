import 'package:fruit_basket/screens/activate_account.dart';
import 'package:fruit_basket/screens/admin/admin_home.dart';
import 'package:fruit_basket/screens/home/home_screen.dart';
import 'package:fruit_basket/wrappers/authentification_wrapper.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home:HomeScreen()
      //AuthentificationWrapper()
        //AdminHome()
       //  ActivateAccount()

        //home: AuthentificationWrapper(),
        );
  }
}
