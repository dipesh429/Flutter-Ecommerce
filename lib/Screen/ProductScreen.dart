import 'dart:convert';

import 'package:cart/Screen/ProductAdd.dart';
import 'package:cart/Widget/MyDrawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductScreen extends StatefulWidget {
  static final route = '/products';

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  _deleteProduct(key, context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Are you sure want to delete?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              await http.delete('https://flutter-cart-2658d.firebaseio.com/product/$key.json');
              this.setState(() { });
              Navigator.of(context).pop();
              },
            child: Text('YES'),
          ),
          FlatButton(
            onPressed: () {Navigator.of(context).pop();},
            child: Text('NO'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Products'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed(ProductAdd.route);
                })
          ],
        ),
        drawer: MyDrawer(),
        body: FutureBuilder(
            future: http
                .get('https://flutter-cart-2658d.firebaseio.com/product.json'),
            builder: (ctx, data) {
              if (data.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                List<Map<String, String>> productList = [];
                var productsMap =
                    json.decode(data.data.body) as Map<String, dynamic>;
                productsMap.forEach((key, value) {
                  productList.add({...productsMap[key], 'key': key});
                });

                return ListView.builder(
                    itemCount: productsMap.length,
                    itemBuilder: (ctx, index) {
                      return ListTile(
                          leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: MemoryImage(
                                  base64Decode(productList[index]['image']))),
                          title: Text(productList[index]['title']),
                          subtitle: Text('\$${productList[index]['price']}'),
                          trailing: Container(
                            width: 100,
                            child: Row(children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      ProductAdd.route,
                                      arguments: productList[index]);
                                },
                                icon: Icon(Icons.edit),
                                color: Theme.of(context).accentColor,
                              ),
                              IconButton(
                                onPressed: () {
                                  _deleteProduct(
                                      productList[index]['key'], context);
                                },
                                color: Theme.of(context).errorColor,
                                icon: Icon(Icons.delete),
                              )
                            ]),
                          ));
                    });
              }
            }));
  }
}
