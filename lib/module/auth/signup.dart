import 'package:firebase_training/module/component.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? myusername, myemail, mypassword;
  var keyform = GlobalKey<FormState>();
  bool obscure = false;

  signUp() async {
    var formdata = keyform.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: myemail!,
          password: mypassword!,
        );
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.scale,
          title: 'success',
          desc: 'success create account',
        )..show();
        return credential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.scale,
            title: 'error',
            desc: 'password is weak',
          )..show();

          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.scale,
            title: 'error',
            desc: 'The account already exists for that email.',
          )..show();

          print('The account already exists for that email.');
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.scale,
            title: 'error',
            desc: e.message,
          )..show();
        }
      } catch (e) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.scale,
          title: 'error',
          desc: e.toString(),
        )..show();
      }
    } else {
      print("not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("signup"),
      ),
      body: Container(
        child: Form(
          key: keyform,
          child: Center(
            child: Container(
              height: 600,
              child: ListView(children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    child: Image(
                      image: AssetImage('images/login.jpg'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                    onSaved: (value) {
                      myusername = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "the name just be not empty";
                      }
                      if (value.length > 100) {
                        return "username can't to be larger than 100 letter ";
                      }
                      if (value.length < 2) {
                        return "username can't to be less than 2 letter ";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'user name',
                      prefixIcon: Icon(Icons.person),
                      border: const OutlineInputBorder(),
                    )),
                SizedBox(
                  height: 20,
                ),
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
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: const OutlineInputBorder(),
                    )),
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
                      labelText: 'password',
                      prefixIcon: Icon(Icons.lock),
                      border: const OutlineInputBorder(),
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
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('if you have Account'),
                    TextButton(
                        onPressed: () {
                          navegatorPushRoute(route: 'login', context: context);
                        },
                        child: Text(
                          'Click here',
                          style: TextStyle(color: Colors.blue),
                        ))
                  ],
                ),
                ElevatedButton(
                    onPressed: () async {
                      var response = await signUp();

                      if (response != null) {
                        Navigator.of(context).pushReplacementNamed("homepage");
                      }
                    },
                    child: Text('create account'))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
