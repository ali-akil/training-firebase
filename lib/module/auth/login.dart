import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_training/module/component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_training/sharedprefrens/sharedpreferans.dart';

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? myemail, mypassword;
  var keyform = GlobalKey<FormState>();
  bool obscure = true;

  signIn() async {
    var formdata = keyform!.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: myemail!, password: mypassword!);
        return credential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.scale,
            title: 'error',
            desc: 'No user found for that email.',
          )..show();
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.scale,
              title: 'error',
              desc: 'Wrong password provided for that user.')
            ..show();
          print('Wrong password provided for that user.');
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.scale,
            title: 'error',
            desc: e.message,
          )..show();
        }
      }
    } else {
      print("not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 150,
              width: 150,
              child: Image(
                image: AssetImage('images/login.jpg'),
              ),
            ),
          ),
          Form(
              key: keyform,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (value) {
                        myemail = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "the email just be not empty";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: " Email",
                        prefixIcon: Icon(
                          Icons.person,
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        onSaved: (value) {
                          mypassword = value;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "the password just be not empty";
                          }
                          if (value.length < 8) {
                            return "password can't less than 8 letter";
                          }
                          return null;
                        },
                        obscureText: obscure,
                        decoration: InputDecoration(
                          labelText: " password",
                          border: const OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.lock_outlined,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscure
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.remove_red_eye,
                            ),
                            onPressed: () {
                              setState(() {
                                obscure = !obscure;
                              });
                            },
                          ),
                        )),
                    Container(
                      child: Row(
                        children: [
                          Text("don't have an account"),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed("signUp");
                              },
                              child: Text(
                                "register now",
                                style: TextStyle(color: Colors.blue),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      child: ElevatedButton(
                          onPressed: () async {
                            var userdata = await signIn();
                            if (userdata != null) {
                              var user = FirebaseAuth.instance.currentUser;
                              if (user!.uid != null)
                                CachHelper.saveData(
                                    key: 'token', value: user!.uid);
                              Navigator.of(context)
                                  .pushReplacementNamed("homepage");
                            }
                          },
                          child: Text(
                            "login",
                            style: TextStyle(fontSize: 20),
                          )),
                    )
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}
