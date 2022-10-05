import 'package:LiBook/Login.dart';
import 'package:LiBook/SignUp.dart';
import 'package:LiBook/Start.dart';
import 'package:LiBook/notes_edit.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import '../Home.dart';
import '../notes_edit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   runApp(MyApp());
   }

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        primaryColor: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      home:

      HomePage(),

      routes: <String,WidgetBuilder>{

        "Login" : (BuildContext context)=>Login(),
        "SignUp":(BuildContext context)=>SignUp(),
        "start":(BuildContext context)=>Start(),
        "/notes_edit":(BuildContext context)=>NotesEdit(['new', [{}],]),
      },
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


