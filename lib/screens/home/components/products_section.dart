import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruit_basket/components/nothingtoshow_container.dart';
import 'package:fruit_basket/components/product_card.dart';
import 'package:fruit_basket/screens/home/components/section_tile.dart';
import 'package:fruit_basket/services/data_streams/data_stream.dart';
import 'package:flutter/material.dart';
import 'package:fruit_basket/services/firestore_files_access/firestore_files_access_service.dart';
import 'package:logger/logger.dart';
import '../../../size_config.dart';

class ProductsSection extends StatelessWidget {
  final String sectionTitle;
  final DataStream productsStreamController;
  final String emptyListMessage;
  final Function onProductCardTapped;
  const ProductsSection({
    Key key,
    @required this.sectionTitle,
    @required this.productsStreamController,
    this.emptyListMessage = "No Products to show here",
    @required this.onProductCardTapped,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF5F6F9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          SectionTile(
            title: sectionTitle,
            press: () {},
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          Expanded(child: buildProductsList(),
            // child: GridView.count(
            //   crossAxisCount: 2,
            // crossAxisSpacing: 10,
            //   children: [
            //     GestureDetector(
            //         onTap: ()=>buildProductGrid(x[0]),
            //       child:Image.asset('assets/images/kiwi.jpg') ,
            //     ),
            //     Image.asset('assets/images/banana.jpg'),
            //     Image.asset('assets/images/mango.jpg'),
            //     Image.asset('assets/images/orange.jpg'),
            //   ],
            // ),
          ),
        ],
      ),
    );
  }

  Widget buildProductsList() {
    List<String>x=['1','2','3'];
    return StreamBuilder<QuerySnapshot>(
      stream:FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.size == 0) {
            return Center(
              child: NothingToShowContainer(
                secondaryMessage: emptyListMessage,
              ),
            );
          }
          List<String> images=snapshot.data.docs.map((e) => e.id).toList();

          return buildProductGrid(images);
        } else if (snapshot.data==null) {
          return Center(
           child:CircularProgressIndicator()
          );
        } else if (snapshot.hasError) {
          final error = snapshot.error;
          Logger().w(error.toString());
        }
        return Center(
          child: NothingToShowContainer(
            iconPath: "assets/icons/network_error.svg",
            primaryMessage: "Something went wrong",
            secondaryMessage: "Unable to connect"
          ),
        );
      },
    );
  }

  Widget buildProductGrid(List<String> productsId) {
    return GridView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: productsId.length,
      itemBuilder: (context, index) {
        return  ProductCard(
          productId: productsId[index],
          press: () {
            if(productsId !=null) {
              onProductCardTapped.call(productsId[index]);
            }
            else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            },
        );
      },
    );
  }
}
