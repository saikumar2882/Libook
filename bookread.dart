import 'package:flutter/material.dart';

class Shelf extends StatefulWidget {
  const Shelf({key}) : super(key: key);

  @override
  State<Shelf> createState() => _ShelfState();
}

class _ShelfState extends State<Shelf> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
          children: const <Widget>[

            Card(
              child: ListTile(
                leading: Icon(Icons.book_outlined, size: 56.0),
                title: Text('Harry Potter and the Order of Phoenix'),
                subtitle: Text('Fictional'),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.book_outlined, size: 56.0),
                title: Text('The Immortals of Meluha'),
                subtitle: Text('Fantasy fictional'),
                trailing: Icon(Icons.more_vert),
              ),
        ),
            Card(
              child: ListTile(
                leading: Icon(Icons.book_outlined, size: 56.0),
                title: Text('Fundamentals of software Engineering'),
                subtitle: Text('Software Engineering'),
                trailing: Icon(Icons.more_vert),

              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.book_outlined, size: 56.0),
                title: Text('FriendZoned'),
                subtitle: Text('Love Story'),
                trailing: Icon(Icons.more_vert),
              ),

            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.book_outlined, size: 56.0),
                title: Text('The girl in the room number 105'),
                subtitle: Text('Thriller'),
                trailing: Icon(Icons.more_vert),
              ),

            ),

          ],
        )
    );
  }
}
