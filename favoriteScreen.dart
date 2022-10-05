import 'package:LiBook/searchpage.dart';
import 'package:flutter/material.dart';
import 'ui.dart';
import 'data/bookshelper.dart';
import 'main.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  BooksHelper helper;
  List<dynamic> books = <dynamic>[];
  int booksCount;

  @override
  void initState() {
    helper = BooksHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isSmall = false;
    if (MediaQuery
        .of(context)
        .size
        .width < 700) {
      isSmall = true;
    }
    return Scaffold(
      appBar: AppBar(title: Text('Bag'),
        actions: <Widget>[

          InkWell(
            child: Padding(
                padding: EdgeInsets.all(20.0),
                child: (isSmall) ? Icon(Icons.shopping_bag) : Text('Favorites')),
          ),
        ],),
      body: Column(children: <Widget>[
        Padding(
            padding: EdgeInsets.all(20),
            child: Text('My Favourite Books')
        ),
        Padding(
            padding: EdgeInsets.all(20),
            child: (isSmall) ? BooksList(books, true) : BooksTable(books, true)
        ),

      ],),

    );
  }

  Future initialize() async {
    books = await helper.getFavorites();
    setState(() {
      booksCount = books.length;
      books = books;
    });
  }


}