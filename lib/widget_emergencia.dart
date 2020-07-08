import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Emergencia extends StatefulWidget {
  @override
  _Emergencia createState() => _Emergencia();
}

class _Emergencia extends State<Emergencia> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Emergências"),
          centerTitle: true,
          backgroundColor: Colors.red,
          actions: null,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("emergencias").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return new Text("Nenhum sintoma cadastrado");
              return new ListView(children: getExpenseItems(snapshot));
            }));
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((doc) => new ListTile(
            title: new Center(
                child: new Text(doc["caso"],
                    style: new TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 25.0))),
            subtitle: new Center(
                child: new Text(doc["instrucoes"],
                    style: new TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 20.0)))))
        .toList();
  }
}
