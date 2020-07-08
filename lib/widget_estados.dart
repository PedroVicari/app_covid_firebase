import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Estados extends StatefulWidget {
  @override
  _Estados createState() => _Estados();
}

class _Estados extends State<Estados> {
  Future<List<Data>> futureListData;

  @override
  void initState() {
    super.initState();
    futureListData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infecçao da COVID-19 por estados'),
        backgroundColor: Colors.red,
        centerTitle: true,
        actions: null,
      ),
      body: Center(
        child: FutureBuilder<List<Data>>(
          future: futureListData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              setData(snapshot);
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    EntryItem(data[index]),
                itemCount: snapshot.data.length,
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

Future<List<Data>> fetchData() async {
  var dateYesterday = DateTime.now().subtract(new Duration(days: 1));

  String dateAPI = dateYesterday.year.toString() +
      dateYesterday.month.toString().padLeft(2, '0') +
      dateYesterday.day.toString().padLeft(2, '0');

  Response response = await Dio()
      .get("https://covid19-brazil-api.now.sh/api/report/v1/brazil/" + dateAPI);

  var dataObjsJson = jsonDecode(response.toString())['data'] as List;
  List<Data> dataObjs =
      dataObjsJson.map((dataJson) => Data.fromJson(dataJson)).toList();

  dataObjs.sort((a, b) => a.state.compareTo(b.state));

  return dataObjs;
}

class Data {
  int uid;
  String uf;
  String state;
  int cases;
  int deaths;

  Data(this.uid, this.uf, this.state, this.cases, this.deaths);

  factory Data.fromJson(dynamic json) {
    return Data(
      json['uid'] as int,
      json['uf'] as String,
      json['state'] as String,
      json['cases'] as int,
      json['deaths'] as int,
    );
  }

  @override
  String toString() {
    return '{ ${this.uid}, ${this.uf}, ${this.state}, ${this.cases}, ${this.deaths} }';
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

List<Entry> data = <Entry>[];
void setData(snapshot) {
  snapshot.data.forEach((element) {
    data.add(Entry(
      element.state,
      <Entry>[
        Entry(
          'Número de infectados',
          <Entry>[
            Entry(element.cases.toString()),
          ],
        ),
        Entry(
          'Número de mortos',
          <Entry>[
            Entry(element.deaths.toString()),
          ],
        ),
      ],
    ));
  });
}

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));

    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
