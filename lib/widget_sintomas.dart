import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Sintomas extends StatefulWidget {
  @override
  _Sintomas createState() => _Sintomas();
}

class _Sintomas extends State<Sintomas> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Principais Sintomas"),
          centerTitle: true,
          backgroundColor: Colors.red,
          actions: null,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("sintomas").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return new Text("Nenhum sintoma cadastrado");
              return new ListView(children: getExpenseItems(snapshot));
            }));
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((doc) =>
            new ListTile(title: new Center(child: new Text(doc["sintoma"]))))
        .toList();
  }
}
