import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  ProductCard(
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
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: productView,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      imageUrl: '$image',
                      width: context.screenWidth,
                      fit: BoxFit.cover,
                      height: 180,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Icon(Icons.wifi_off_rounded),
                      ),
                    )
                    // Image.network(
                    //   '$image',
                    //   fit: BoxFit.cover,
                    //   width: context.screenWidth,
                    //   height: 180,
                    // ),
                    ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title!.length > 33
                        ? '${title!.substring(0, 34)}...'
                            .text
                            .size(context.screenWidth * 0.045)
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
