import 'ui.dart';
import 'package:flutter/material.dart';
import './data/bookshelper.dart';
import 'favoriteScreen.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Books',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  BooksHelper helper;
  List<dynamic> books = <dynamic>[];
  int booksCount;
  TextEditingController txtSearchController;

  @override
  void initState() {
    helper = BooksHelper();
    txtSearchController = TextEditingController();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isSmall = false;
    if (MediaQuery
        .of(context)
        .size
        .width < 600) {
      isSmall = true;
    }
    return Scaffold(

        body: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(children: [
                  Text('Search book'),
                  Container(
                      padding: EdgeInsets.all(20),
                      width: 200,
                      child: TextField(
                        controller: txtSearchController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (text) {
                          helper.getBooks(text).then((value) {
                            books = value;
                            setState(() {
                              books = books;
                            });
                          });
                        },
                      )),
                  Container(
                      padding: EdgeInsets.all(20),
                      child: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () =>
                              helper.getBooks(txtSearchController.text))),
                ]),
              ),
              Padding(
                  padding: EdgeInsets.all(20),
                  child: (isSmall)
                      ? BooksList(books, false)
                      : BooksTable(books, false)),
            ])));
  }

  Future initialize() async {
    books = (await helper.getBooks('Flutter'));
    setState(() {
      booksCount = books.length;
      books = books;
    });
  }
}