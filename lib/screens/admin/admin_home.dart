import 'package:flutter/material.dart';
import 'package:fruit_basket/app.dart';
import 'package:fruit_basket/screens/activate_account.dart';
import 'package:fruit_basket/screens/admin/add_information.dart';
import 'package:fruit_basket/screens/admin/edit_information.dart';
class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Admin Home',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          Container(
            width: MediaQuery.of(context).size.width*.8,
            child: ElevatedButton(
              onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=>ActivateAccount()));
                },
              child: Text('Activate or De Activate Account'),
            ),
          ),
          SizedBox(
            height: 15,
          ), Container(
      width: MediaQuery.of(context).size.width*.8,
      child:ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>EditInformation()));
            },
            child: Text('Edit Information'),
          )),
          SizedBox(
            height: 15,
          ), Container(
    width: MediaQuery.of(context).size.width*.8,
    child:ElevatedButton(
            onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddInformation()));
            },
            child: Text('Add information'),
          ))
        ],
      ),
    );
  }
}
