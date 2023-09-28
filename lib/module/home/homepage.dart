import 'package:firebase_training/sharedprefrens/sharedpreferans.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List notes = [
    {"note": "hi I am here", "image": "images/login.jpg"},
    {"note": "hi I am here", "image": "images/login.jpg"},
    {"note": "hi I am here", "image": "images/login.jpg"},
    {"note": "hi I am here", "image": "images/login.jpg"},
    {"note": "hi I am here", "image": "images/login.jpg"},
  ];

  getUser() {
    var user = FirebaseAuth.instance.currentUser;
    return user;
  }

  @override
  void initState() {
    var user = FirebaseAuth.instance.currentUser;
    print(user!.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacementNamed('login');
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                  size: 30,
                )),
          )
        ],
        title: Text("home page"),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.of(context).pushNamed("addnote");
          },
          child: Icon(Icons.add),
        ),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, i) {
              return Dismissible(
                  key: Key("$i"),
                  child: ListNotes(
                    notes: notes[i],
                  ));
            }),
      ),
    );
  }
}

class ListNotes extends StatelessWidget {
  final notes;

  ListNotes({this.notes});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(children: [
        Expanded(
            flex: 1,
            child: Container(
                width: 40,
                height: 80,
                child: Image(
                  image: AssetImage("${notes['image']}"),
                  fit: BoxFit.fill,
                ))),
        Expanded(
          flex: 2,
          child: ListTile(
              title: Text("title"),
              subtitle: Text("${notes['note']}"),
              trailing: IconButton(onPressed: () {}, icon: Icon(Icons.edit))),
        )
      ]),
    );
  }
}
