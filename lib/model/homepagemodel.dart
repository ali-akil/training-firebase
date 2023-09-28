import 'package:flutter/material.dart';

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
              title: Text("${notes['note']}"),
              trailing: IconButton(onPressed: () {}, icon: Icon(Icons.edit))),
        )
      ]),
    );
  }
}
