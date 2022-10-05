import 'package:LiBook/Login.dart';
import 'package:LiBook/Start.dart';
import 'package:LiBook/main.dart';
import 'package:LiBook/searchpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Home.dart';
import '../notes_edit.dart';
import '../searchpage.dart';
import '../favoriteScreen.dart';
import '../bookread.dart';

class HomePage extends StatefulWidget {
  const HomePage({key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("start");
      }
    });
  }
 
  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();

    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  int _selectedIndex = 0;
  static const List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[

    BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Search',
        backgroundColor: Colors.blue
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.library_books),
        label: 'Notes',
        backgroundColor: Colors.blue

    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.leaderboard),
      label: 'Shelf',
      backgroundColor: Colors.blue,
    ),
  ];

  static const List<Widget> widgets = [
    SearchPage(),//Text("Search Screen", style: TextStyle(color: Colors.black),),
    Home(),//Text("Notes Screen", style: TextStyle(color: Colors.black),),//Notes(),
    Shelf(),//Text("Bag", style: TextStyle(color: Colors.black),),
  ];

  void onIndexChanged(int index){
    setState(() {
      _selectedIndex = index;
    });
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
      appBar: AppBar(
        title: Text("LiBook"),
        actions: <Widget>[

          InkWell(
            child: Padding(
                padding: EdgeInsets.all(20.0),
                child: (isSmall) ? Icon(Icons.shopping_bag) : Text('Favorites')),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoriteScreen()));
            },
          ),
        ],
      ),






      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("${user.displayName}"),
              accountEmail: Text("${user.email}"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("images/icon.png"),
              ),
            ),

            ListTile(
              leading: Icon(Icons.exit_to_app_rounded),
              title: Text("Sign Out"),
              onTap: signOut,

            ),
          ],
        ),
      ),
      body: widgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: _selectedIndex,
        onTap: onIndexChanged,
      ),
    );
  }
}

class GenerateAllRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings, ) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => Home());
      case '/notes_edit':
        return MaterialPageRoute(builder: (context) => NotesEdit(settings.arguments));
      default:
        return _unknownRoute();
    }
  }
}

Route<dynamic> _unknownRoute() {
  return MaterialPageRoute(builder: (context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oops!'),
      ),
      body: Center(
        child: Text('Page not found'),
      ),
    );
  });
}