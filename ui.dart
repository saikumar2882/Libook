import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'data/bookshelper.dart';
import 'package:http/http.dart' as http;
class BooksTable extends StatelessWidget {
  final List<dynamic> books;
  final bool isFavorite;

  BooksTable(this.books, this.isFavorite);

  final BooksHelper helper = BooksHelper();

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(1),
      },
      border: TableBorder.all(color: Colors.blueGrey),
      children:
      books.map((book) {
        return TableRow(
            children: [
              TableCell(child: TableText(book.title)),
              TableCell(child: TableText(book.authors)),
              TableCell(child: TableText(book.publisher)),
              TableCell(
                  child: IconButton(
                      color: (isFavorite == false) ? Colors.red : Colors.amber,
                      tooltip: (isFavorite == false)
                          ? 'Remove from favorites'
                          : 'Add to favorites',
                      icon: Icon(Icons.star),
                      onPressed: () {
                        if (isFavorite == false) {

                          helper.removeFromFavorites(book, context);
                        }
                        else {
                          helper.addToFavorites(book);
                        }
                      }))
            ]
        );
      }).toList(),
    );
  }
}

class BooksList extends StatelessWidget {
  final List<dynamic> books;
  final bool isFavorite;

  BooksList(this.books, this.isFavorite);

  final BooksHelper helper = BooksHelper();

  @override
  Widget build(BuildContext context) {
    final int booksCount = books.length;
    print(booksCount);
    return Container(
        height: MediaQuery
            .of(context)
            .size
            .height / 1.4,
        child: ListView.builder(
            itemCount: (booksCount == null) ? 0 : booksCount,
            itemBuilder: (BuildContext context, int position) {
              print( "$isFavorite<---value" );
              return ListTile(
                title: Text(books[position].title),
                onTap: () async{
                  // fetch  selfUrl and get
                  http.Response result = await http.get(Uri.parse(books[position].selfLink));
                  if (result.statusCode == 200) {
                    final jsonResponse = json.decode(result.body);
                    debugPrint(jsonResponse.toString());
                    final url = jsonResponse['volumeInfo']['previewLink'];
                    _launchInBrowser(url);
                  }
                },
                subtitle: Text(books[position].authors),
                trailing: IconButton(
                    color: (isFavorite ) ? Colors.red : Colors.amber,
                    tooltip: (isFavorite)
                        ? 'Remove from favorites'
                        : 'Add to favorites',
                    icon: Icon(Icons.star),
                    onPressed: () {
                      if (isFavorite) {
                        helper.removeFromFavorites(books[position], context);
                      }
                      else {
                        helper.addToFavorites(books[position]);
                      }
                    }),
              );
            }));
  }

  Future<void> _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }

}

class TableText extends StatelessWidget {
  final String text;

   TableText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(text,
        style: TextStyle(color: Theme
            .of(context)
            .primaryColorDark),),
    );
  }
}