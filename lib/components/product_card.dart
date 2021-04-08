

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruit_basket/models/Product.dart';
import 'package:fruit_basket/services/database/product_database_helper.dart';
import 'package:logger/logger.dart';
import '../constants.dart';

class ProductCard extends StatefulWidget {
  final String productId;
  final GestureTapCallback press;
  const ProductCard({
    Key key,
    @required this.productId,
    @required this.press,
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
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

    return GestureDetector(
      onTap: widget.press,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: kTextColor.withOpacity(0.15)),
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child :widget.productId !=null?buildProductCardItems(
           image,title,price,oldPrice,description
             ): Center(
                child: Icon(
                  Icons.error,
                  color: kTextColor,
                  size: 60,
                ),
              ))));

  }

  Column buildProductCardItems(List<String> product,String title,price,oldPrice,description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              product[0],
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: 10),
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  "${title}\n",
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ),
              SizedBox(height: 5),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 5,
                      child: Text.rich(
                        TextSpan(
                         text: "\₹${price}\n",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                          children: [
                            TextSpan(
                            text: "\₹${oldPrice}",
                              style: TextStyle(
                                color: kTextColor,
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.normal,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/DiscountTag.svg",
                            color: kPrimaryColor,
                          ),
                          Center(
                            // child: Text(
                            //   "${description()}%Off",
                            //   style: TextStyle(
                            //     color: Colors.white,
                            //     fontSize: 8,
                            //     fontWeight: FontWeight.w900,
                            //   ),
                            //   textAlign: TextAlign.center,
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
