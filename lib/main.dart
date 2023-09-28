import 'package:firebase_training/module/auth/login.dart';
import 'package:firebase_training/module/auth/signup.dart';
import 'package:firebase_training/module/crud/addnote.dart';
import 'package:firebase_training/module/home/homepage.dart';
import 'package:firebase_training/sharedprefrens/sharedpreferans.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

bool? islogin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    islogin = false;
  } else {
    islogin = true;
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.blue,
          primarySwatch: Colors.blue,
          buttonTheme: ButtonThemeData(buttonColor: Colors.blue),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue,
            iconTheme: IconThemeData(color: Colors.black, size: 40),
          )),
      //    home: this.tokenuser != null ? HomePage() : LoginScreen(),
      home: islogin == false ? LoginScreen() : HomePage(),
      routes: {
        "login": (context) => LoginScreen(),
        'signUp': (context) => SignUpScreen(),
        "homepage": (context) => HomePage(),
        "addnote": (context) => AddNote()
      },
    );
  }
}
