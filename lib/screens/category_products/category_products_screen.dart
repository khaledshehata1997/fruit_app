

import 'package:flutter/material.dart';
import 'package:fruit_basket/models/Product.dart';

import 'components/body.dart';

class CategoryProductsScreen extends StatelessWidget {
  final ProductType productType;

  const CategoryProductsScreen({
    Key key,
    @required this.productType,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        productType: productType,
      ),
    );
  }
}
