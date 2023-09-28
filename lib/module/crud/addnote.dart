import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add note"),
      ),
      body: Container(
          child: Column(
        children: [
          Form(
              child: Column(
            children: [
              TextFormField(
                maxLength: 30,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "title note",
                    prefixIcon: Icon(Icons.note)),
              ),
              TextFormField(
                minLines: 1,
                maxLines: 4,
                maxLength: 200,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: " note",
                    prefixIcon: Icon(Icons.note)),
              ),
              ElevatedButton(
                onPressed: () {
                  showbuttomSheet();
                },
                child: Text("add image for note"),
              ),
              Container(
                width: 300,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "add note",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ))
        ],
      )),
    );
  }

  showbuttomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20),
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "please chooes image",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(Icons.photo),
                          SizedBox(
                            width: 20,
                          ),
                          Text("from Gallery", style: TextStyle(fontSize: 20)),
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(Icons.camera),
                          SizedBox(
                            width: 20,
                          ),
                          Text("from camera", style: TextStyle(fontSize: 20)),
                        ],
                      )),
                ),
              ],
            ),
          );
        });
  }
}
