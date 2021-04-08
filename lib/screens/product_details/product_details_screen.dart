
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fruit_basket/screens/product_details/provider_models/ProductActions.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';
import 'components/fab.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;

  const ProductDetailsScreen({
    Key key,
    @required this.productId,
  }) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
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
    return ChangeNotifierProvider(
      create: (context) => ProductActions(),
      child: Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        appBar: AppBar(
          backgroundColor: Color(0xFFF5F6F9),
        ),
        body: Body(
          productId: widget.productId,
        ),
        floatingActionButton: AddToCartFAB(productId: widget.productId),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
