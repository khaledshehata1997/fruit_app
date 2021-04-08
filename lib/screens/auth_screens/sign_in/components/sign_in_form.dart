
import 'package:fruit_basket/components/custom_suffix_icon.dart';
import 'package:fruit_basket/components/default_button.dart';
import 'package:fruit_basket/exceptions/firebaseauth/messeged_firebaseauth_exception.dart';
import 'package:fruit_basket/exceptions/firebaseauth/signin_exceptions.dart';
import 'package:fruit_basket/screens/forgot_password/forgot_password_screen.dart';
import 'package:fruit_basket/screens/home/home_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:fruit_basket/services/auth.dart';
import 'package:fruit_basket/services/authentification/authentification_service.dart';
import 'package:fruit_basket/services/model_hud.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:logger/logger.dart';
import 'package:fruit_basket/models/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fruit_basket/services/admin_mode.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import 'package:fruit_basket/screens/admin/admin_home.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  final _auth=Auth();
  final _formKey = GlobalKey<FormState>();
  bool keepMeLoggedIn = false;
  final kKeepMeLoggedIn = 'KeepMeLoggedIn';
  String email;
  String password;
  bool remember = false;
  bool modalhud = false;
  bool isAdmin = false;
  bool isloading = false;
String adminEmail='admin@gmail.com';
String adminPassword='123456789';

  @override
  Widget build(BuildContext context) {
    final auth2 = Provider.of<AuthViewModel>(context);
    return  ModalProgressHUD(
      inAsyncCall: isloading,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            buildEmailFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildPasswordFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildForgotPasswordWidget(context),
            SizedBox(height: getProportionateScreenHeight(30)),
            DefaultButton(
              text: "Sign in",
              press:()=> signin()
            ),
          ],
        ),
      ));
  }

  Row buildForgotPasswordWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 15,
            ),
           Checkbox(value: isAdmin,
               onChanged: (value){
              setState(() {
                isAdmin=value;;
              });
               }),
          Text('I am admin'),
          SizedBox(width: MediaQuery.of(context).size.width*.2,)      ,
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen(),
                    ));
              },
              child: Text(
                "Forgot Password",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget buildPasswordFormField() {
    return TextFormField(
      onChanged: (value){
        password=value;
      },
      controller: _passController,
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
        if (_passController.text.isEmpty) {
          return kPassNullError;
        } else if (_passController.text.length < 8) {
          return kShortPassError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildEmailFormField() {
    return TextFormField(
      onChanged: (value){
        email=value;
      },
      controller: _emailController,
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
        if (_emailController.text.isEmpty) {
          return kEmailNullError;
        } else if (!emailValidatorRegExp.hasMatch(_emailController.text)) {
          return kInvalidEmailError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Future<void> signInButtonCallback() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final AuthentificationService authService = AuthentificationService();
      bool signInStatus = false;
      String snackbarMessage;
      try {
        final signInFuture = authService.signIn(
          email: _emailController.text.trim(),
          password: _passController.text.trim(),
        );
        signInFuture.then((value) => signInStatus = value);
        signInStatus = await showDialog(
          context: context,
          builder: (context) {
            return FutureProgressDialog(
              signInFuture,
              message: Text("Signing in to account"),
            );
          },
        );
        if (signInStatus == true) {
          snackbarMessage = "Signed In Successfully";
        } else {
          throw FirebaseSignInAuthUnknownReasonFailure();
        }
      } on MessagedFirebaseAuthException catch (e) {
        snackbarMessage = e.message;
      } catch (e) {
        snackbarMessage = e.toString();
      } finally {
        Logger().i(snackbarMessage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(snackbarMessage),
          ),
        );
      }
    }
  }
   signin() async {
    if(isAdmin==true){
      await _auth.signIn(email.trim(), password.trim());
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminHome()),
        );
    }
      else{
      await _auth.signIn(email, password);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
    }
    }

  }

  

