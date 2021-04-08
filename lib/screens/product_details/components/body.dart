
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fruit_basket/models/Product.dart';
import 'package:fruit_basket/screens/product_details/components/product_actions_section.dart';
import 'package:fruit_basket/screens/product_details/components/product_images.dart';
import 'package:fruit_basket/services/database/product_database_helper.dart';
import 'package:logger/logger.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'product_review_section.dart';

class Body extends StatefulWidget {
  final String productId;

  const Body({
    Key key,
    @required this.productId,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<String> image;
  String title,oldPrice,price,description;
  @override
  void initState() {
    var doc=FirebaseFirestore.instance.collection('products').doc(widget.productId).get().then((value) {
      setState(() {
        image=List<String>.from(value["image"]);
        title=value['name'];
        oldPrice=value['oldPrice'];
        price=value['price'];
        description=value['desc'];
      });
      print(image);
    });    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(screenPadding)),
          child:widget.productId !=null?Center(
            child: Column(
    children: [
      Text('$title',style: TextStyle(fontSize: 20,color: Colors.deepOrange)),
      Text('price : $price',style: TextStyle(fontSize: 20,color: Colors.deepOrange)),
      SizedBox(height: 25,),
      Text('$description',style: TextStyle(fontSize: 18,color: Colors.black)),
       for(int i=0; i<image.length ;i++)...[
         Image.network(image[i],height: 200,width: 200,)
    ]


    ],

    ),
          ): Center(
                child: Icon(
                  Icons.error,
                  color: kTextColor,
                  size: 60,
                ),
              )
          ),
        ),
    );
  }
}
