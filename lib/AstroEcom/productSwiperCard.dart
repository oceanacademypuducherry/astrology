import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class ProductSwiperCard extends StatelessWidget {
  ProductSwiperCard(
      {this.title,
      this.image,
      this.price,
      this.rating,
      this.addTocart,
      this.productView});

  String? image;
  num? rating = 0;
  String? title = '';
  num? price = 0;
  VoidCallback? addTocart;
  VoidCallback? productView;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 300,
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: productView,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    height: 180,
                    width: context.screenWidth,
                    imageUrl: '$image',
                    placeholder: (context, url) => Center(
                        child: Container(child: CircularProgressIndicator())),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.wifi_off_rounded),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title!.length > 34
                        ? '${title!.substring(0, 35)}...'
                            .text
                            .size(20)
                            .make()
                            .py8()
                        : '${title!}'.text.size(20).make().py8(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        VxRating(
                          onRatingUpdate: (val) {
                            print(val);
                          },
                          isSelectable: false,
                          maxRating: 5,
                          value: rating!.toDouble(),
                          size: 15,
                          count: 5,
                          selectionColor: Colors.deepOrangeAccent,
                        ).py8(),
                        'RS. ${price!.numCurrency}'.text.bold.make().py8(),
                      ],
                    ),
                    ElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.shopping_cart),
                          ),
                          Text('Add to Cart')
                        ],
                      ),
                      onPressed: addTocart != null
                          ? addTocart
                          : () {
                              print('function empty');
                            },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
