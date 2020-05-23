import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'ProductScreen.dart';

class ProductAdd extends StatefulWidget {
  static final route = '/product-add';

  @override
  _ProductAddState createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  var _initialProduct = {
    "key": null,
    "title": '',
    "price": '',
    "description": '',
    "image": ''
  };

  File _image;
  String _imageUrl = '';
  final _priceFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final _descriptionFocusNode = FocusNode();

  _saveProduct() async {
    _form.currentState.save();
    var key = _initialProduct['key'];

    if (key == null) {
      await http.post('https://flutter-cart-2658d.firebaseio.com/product.json',
          body: json.encode(_initialProduct));
    } else {
      await http.patch(
          'https://flutter-cart-2658d.firebaseio.com/product/$key.json',
          body: json.encode(_initialProduct));
    }
    Navigator.of(context).pushReplacementNamed(ProductScreen.route);
  }

  Future getImage() async {
    _image = await ImagePicker.pickImage(source: ImageSource.camera);

    List<int> imageBytes = _image.readAsBytesSync();
    _imageUrl = base64Encode(imageBytes);

    setState(() {
      _initialProduct = {..._initialProduct, 'image': _imageUrl};
    });
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context).settings.arguments;
    if (routeArg != null) {
      this.setState(() {
        _initialProduct = routeArg;
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Add Product'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.save), onPressed: _saveProduct)
          ],
        ),
        body: Form(
            key: _form,
            child: ListView(
              padding: EdgeInsets.all(20),
              children: <Widget>[
                TextFormField(
                  initialValue: _initialProduct['title'],
                  decoration: InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onSaved: (val) {
                    _initialProduct['title'] = val;
                  },
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_priceFocusNode),
                ),
                TextFormField(
                  initialValue: _initialProduct['price'],
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocusNode,
                  onSaved: (val) {
                    _initialProduct['price'] = val;
                  },
                  onFieldSubmitted: (_) => FocusScope.of(context)
                      .requestFocus(_descriptionFocusNode),
                ),
                TextFormField(
                  initialValue: _initialProduct['description'],
                  decoration: InputDecoration(labelText: 'Description'),
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  onSaved: (val) {
                    _initialProduct['description'] = val;
                  },
                  maxLines: 3,
                ),
                RaisedButton(onPressed: getImage, child: Text('Take Picture')),
                if (_initialProduct['image'] != '')
                  Image.memory(
                    base64Decode(_initialProduct['image']),
                    height: 200,
                    fit: BoxFit.cover,
                  )
              ],
            )));
  }
}
