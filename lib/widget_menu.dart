import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  @override
  _Menu createState() => _Menu();
}

class _Menu extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Menu"),
            centerTitle: true,
            backgroundColor: Colors.red,
            actions: null,
            automaticallyImplyLeading: false),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                  child: Text(
                    'Estados',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.red,
                  onPressed: () {
                    Navigator.pushNamed(context, '/Estados');
                  }),
              RaisedButton(
                  child: Text(
                    'Sintomas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.red,
                  onPressed: () {
                    Navigator.pushNamed(context, '/Sintomas');
                  }),
              RaisedButton(
                  child: Text(
                    'Emergência',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.red,
                  onPressed: () {
                    Navigator.pushNamed(context, '/Emergencia');
                  }),
              RaisedButton(
                  child: Text(
                    'Alterar Senha',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.red,
                  onPressed: () {
                    Navigator.pushNamed(context, '/AlterarSenha');
                  }),
              RaisedButton(
                  child: Text(
                    'Sobre',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.red,
                  onPressed: () {
                    Navigator.pushNamed(context, '/Sobre');
                  }),
              RaisedButton(
                child: Text(
                  'Sair',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Colors.red[500],
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
        backgroundColor: Colors.white);
  }
}
