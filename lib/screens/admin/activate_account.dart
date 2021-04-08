
import 'package:flutter/material.dart';

class ActivateAccount extends StatefulWidget {
  @override
  _ActivateAccountState createState() => _ActivateAccountState();
}

class _ActivateAccountState extends State<ActivateAccount> {
  Color fColor=Colors.black;
  Color secColor=Colors.black;
  Color thColor=Colors.black;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activate Account'),
      ),
      body: ListView(
        children: [
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Colors.deepOrange[100],
                  borderRadius: BorderRadius.circular(20)
              ),
              margin: EdgeInsets.all(15),
              height: 190,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/7cc7a630624d20f7797cb4c8e93c09c1.png'),
                        maxRadius: 43,
                      ),
                      Icon(Icons.wb_incandescent_outlined,color: fColor,size: 40,),
                      Text('Ahmed Ali',style: TextStyle(
                        fontSize: 23,color: Colors.black
                      ),)
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        child: Text('Activate Account'),
                        onPressed: (){
                          setState(() {
                            fColor=Colors.greenAccent[400];
                          });
                          return ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                elevation: 10,
                                  content: Text('Account is  Activated')),
                          );

                        },
                      ),
                      ElevatedButton(
                          child: Text('Deactivate Account'),
                          onPressed: (){
                            setState(() {
                              fColor=Colors.red[400];
                            });
                            return ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Account is  Deactivated'))
                            );
                          },
                          ),
                    ],
                  ),
                ],
              ),
            ),
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.deepOrange[100],
                borderRadius: BorderRadius.circular(20)
            ),
            margin: EdgeInsets.all(15),
            height: 190,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/194938.png'),
                      maxRadius: 43,
                    ),
                    Icon(Icons.wb_incandescent_outlined,color: secColor,size: 40,),
                    Text('Aya Khaled',style: TextStyle(
                        fontSize: 22,color: Colors.black
                    ),)
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      child: Text('Activate Account'),
                      onPressed: (){
                        setState(() {
                          secColor=Colors.greenAccent[400];
                        });
                        return ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              elevation: 10,
                              content: Text('Account is  Activated')),
                        );

                      },
                    ),
                    ElevatedButton(
                      child: Text('Deactivate Account'),
                      onPressed: (){
                        setState(() {
                          secColor=Colors.red[400];
                        });
                        return ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Account is  Deactivated'))
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.deepOrange[100],
                borderRadius: BorderRadius.circular(20)
            ),
            margin: EdgeInsets.all(15),
            height: 190,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/7_avatar-512.png'),
                      maxRadius: 42,
                    ),
                    Icon(Icons.wb_incandescent_outlined,color: thColor,size: 40,),
                    Text('Mahmoud Alaa',style: TextStyle(
                        fontSize: 20,color: Colors.black
                    ),)
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      child: Text('Activate Account'),
                      onPressed: (){
                        setState(() {
                          thColor=Colors.greenAccent[400];
                        });
                        return ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              elevation: 10,
                              content: Text('Account is  Activated')),
                        );

                      },
                    ),
                    ElevatedButton(
                      child: Text('Deactivate Account'),
                      onPressed: (){
                        setState(() {
                          thColor=Colors.red[400];
                        });
                        return ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Account is  Deactivated'))
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
