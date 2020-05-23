import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './ProductAdd.dart';
import '../Widget/MyDrawer.dart';
import '../Widget/ProductItem.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ShopMandu'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                 
                })
          ],
        ),
        drawer: MyDrawer(),
        body: FutureBuilder(
            future: http
                .get('https://flutter-cart-2658d.firebaseio.com/product.json'),
            builder: (ctx,data){
                if(data.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }else{
                  List<Map<String, String>> productList=[];
                  var productsMap=json.decode(data.data.body) as Map<String,dynamic>;
                  productsMap.forEach((key, value) {
                    productList.add({...productsMap[key],'key':key});
                  });
                  return ProductItem(productList);
                }
            }));
  }
}
