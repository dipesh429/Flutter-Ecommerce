import 'package:cart/Screen/ProductScreen.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: 100,
            color: Theme.of(context).primaryColorLight,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left:5),
            child: Text('SHOPMANDU',style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,)),
          ),
          ListTile(
            onTap: ()=>Navigator.of(context).pushReplacementNamed('/'),
            title: Text(
              'Shop',
              style: TextStyle(fontSize: 18),
            ),
            leading: Icon(
              Icons.shopping_cart,
              size: 30,
            ),
          ),
          ListTile(
            onTap: ()=>Navigator.of(context).pushReplacementNamed(ProductScreen.route),
            title: Text(
              'Products',
              style: TextStyle(fontSize: 18),
            ),
            leading: Icon(
              Icons.card_giftcard,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
