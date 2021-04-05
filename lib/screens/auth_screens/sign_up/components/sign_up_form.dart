
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fruit_basket/components/custom_suffix_icon.dart';
import 'package:fruit_basket/components/default_button.dart';
import 'package:fruit_basket/exceptions/firebaseauth/messeged_firebaseauth_exception.dart';
import 'package:fruit_basket/exceptions/firebaseauth/signup_exceptions.dart';
import 'package:fruit_basket/screens/home/home_screen.dart';
import 'package:fruit_basket/services/auth.dart';
import 'package:fruit_basket/services/authentification/authentification_service.dart';
import 'package:fruit_basket/services/model_hud.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';


class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // final _globalKey = GlobalKey<FormState>();
  // final TextEditingController emailFieldController = TextEditingController();
  // final TextEditingController passwordFieldController = TextEditingController();
  // final TextEditingController confirmPasswordFieldController =
  //     TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String name;
  bool remember = false;
  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(screenPadding)),
        child: Column(
          children: [
            buildConfirmPasswordFormField(),
            SizedBox(height: getProportionateScreenHeight(40)),
            buildEmailFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildPasswordFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),

            DefaultButton(
              text: "Sign up",
              press: ()=>signUp()
            ),
          ],
        ),
      ),
    );
  }

  Widget buildConfirmPasswordFormField() {
    return TextFormField(
      onChanged: (value){
        value=name;
      },
    //  controller: confirmPasswordFieldController,
      obscureText: false,
      decoration: InputDecoration(
        hintText: "name",
        labelText: "name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
      validator: (value) {
        if (value.isEmpty) return 'name is Empty';
      },
    );
  }

  Widget buildEmailFormField() {
    return TextFormField(
      controller: _emailController,
      onChanged: (value){
        value=email;
      },
     // controller: emailFieldController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "Enter your email",
        labelText: "Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Mail.svg",
        ),
      ),
      validator: (value) {
        if (value.isEmpty) return 'email is Empty';
      },
    );
  }

  Widget buildPasswordFormField() {
    return TextFormField(
      controller: _passController,
      onChanged: (value){
        value=password;
      },
      //controller: passwordFieldController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Enter your password",
        labelText: "Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
      validator: (value) {
        if (value.isEmpty) return 'password is Empty';
      },
    );
  }

  // Future<void> signUpButtonCallback() async {
  //   if (_formKey.currentState.validate()) {
  //     // goto complete profile page
  //     final AuthentificationService authService = AuthentificationService();
  //     bool signUpStatus = false;
  //     String snackbarMessage;
  //     try {
  //       final signUpFuture = authService.signUp(
  //         email: emailFieldController.text,
  //         password: passwordFieldController.text,
  //       );
  //       signUpFuture.then((value) => signUpStatus = value);
  //       signUpStatus = await showDialog(
  //         context: context,
  //         builder: (context) {
  //           return FutureProgressDialog(
  //             signUpFuture,
  //             message: Text("Creating new account"),
  //           );
  //         },
  //       );
  //       if (signUpStatus == true) {
  //         snackbarMessage =
  //             "Registered successfully, Please verify your email id";
  //       } else {
  //         throw FirebaseSignUpAuthUnknownReasonFailureException();
  //       }
  //     } on MessagedFirebaseAuthException catch (e) {
  //       snackbarMessage = e.message;
  //     } catch (e) {
  //       snackbarMessage = e.toString();
  //     } finally {
  //       Logger().i(snackbarMessage);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(snackbarMessage),
  //         ),
  //       );
  //       if (signUpStatus == true) {
  //         Navigator.pop(context);
  //       }
  //     }
  //   }
  // }
  signUp()async {
    // final modelhud =
    // Provider.of<Modelhud>(context, listen: false);
    // modelhud.changeIsLoading(true);
    // if (_globalKey.currentState.validate()) {
    //   _globalKey.currentState.save();
    //   try {
    //     final authResult = await _auth.signUp(
    //         _email.trim(), _password.trim());
    //     modelhud.changeIsLoading(false);
    //     // var userInfo = await FirebaseAuth.instance.col('users').document().setData({
    //     //   'email':authResult.user.email,
    //     //   'name':authResult.user,
    //     //   'email':authResult.user.email,
    //     //   'email':authResult.user.email,
    //     //   'email':authResult.user.email,
    //     // });
    //     Navigator.pushNamed(context, 'ChatScreen');
    //   }
    //   catch (e) {
    //     // modelhud.changeIsLoading(false);
    //     // Scaffold.of(context).showSnackBar(SnackBar(
    //     //   content: Text(e.message),
    //     // ));
    //   }
    {
      if (_globalKey.currentState.validate()) {
        _globalKey.currentState.save();
        try {
          var result = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
              email: _emailController.text,
              password: _passController.text);
          if (result.user != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }

          else {
            print('error');
          }
        }
        catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message),
          ));
        }
      }
    }
  }}



