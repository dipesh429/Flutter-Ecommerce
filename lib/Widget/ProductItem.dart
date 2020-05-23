import 'dart:convert';

import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final List<Map<String, String>> products;
  const ProductItem(this.products);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            childAspectRatio: 3 / 2.5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemBuilder: ((ctx, index) {
          return GridTile(
              child: Image.memory(base64.decode(products[index]['image']),
                  fit: BoxFit.cover),
              footer: GridTileBar(
                backgroundColor: Colors.black.withOpacity(0.5),
                leading: Icon(Icons.shopping_cart),
                title: Text(products[index]['title'],textAlign: TextAlign.center),
                trailing: Icon(Icons.favorite),
              ));
        }),
        itemCount: products.length);
  }
}
