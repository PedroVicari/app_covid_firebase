import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_covid/app_covid_icons.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class NovoUsuario extends StatefulWidget {
  @override
  _NovoUsuario createState() => _NovoUsuario();
}

class _NovoUsuario extends State<NovoUsuario> {
  GlobalKey<FormState> _formNovoUsuarioKey = GlobalKey<FormState>();

  TextEditingController txtUsuario = TextEditingController();
  TextEditingController txtSenha = TextEditingController();

  var db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Novo Usuário"),
          centerTitle: true,
          backgroundColor: Colors.red,
          actions: null,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: _formNovoUsuarioKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  campoUsuario("Usuário", txtUsuario),
                  campoSenha("Senha", txtSenha),
                  botaoSalvar(context),
                ],
              )),
        ),
        backgroundColor: Colors.white);
  }

  campoUsuario(rotulo, controle) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black, fontSize: 20),
        decoration: InputDecoration(
          labelText: rotulo,
          labelStyle: TextStyle(
            color: Colors.red[500],
            fontSize: 12,
          ),
          prefixIcon: Icon(AppCovid.virus),
        ),
        controller: controle,
        validator: (value) {
          return (value.isEmpty) ? "Informe o Novo Usuário" : null;
        },
      ),
    );
  }

  campoSenha(rotulo, controle) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black, fontSize: 20),
        obscureText: true,
        decoration: InputDecoration(
          labelText: rotulo,
          labelStyle: TextStyle(
            color: Colors.red[500],
            fontSize: 12,
          ),
          prefixIcon: Icon(AppCovid.enhanced_encryption),
        ),
        controller: controle,
        validator: (value) {
          return (value.isEmpty) ? "Informe a Senha" : null;
        },
      ),
    );
  }

  botaoSalvar(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20),
        child: RaisedButton(
          child: Text(
            "Salvar",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          color: Colors.red[500],
          onPressed: () {
            if (_formNovoUsuarioKey.currentState.validate()) {
              var byteSenha = utf8.encode(txtSenha.text);
              var cryptoSenha = sha1.convert(byteSenha);

              bool existeUser = false;
              bool runAux = false;

              db
                  .collection('users')
                  .where("user", isEqualTo: txtUsuario.text)
                  .snapshots()
                  .listen((data) {
                data.documents.forEach((doc) {
                  existeUser = true;
                });
                if (!runAux) {
                  runAux = true;
                  if (!existeUser) {
                    db.collection("users").document().setData({
                      "user": "${txtUsuario.text}",
                      "password": "$cryptoSenha"
                    });
                    showAlertDialog(context, "Sucesso!",
                        "Usuário criado com sucesso", true);
                  } else {
                    showAlertDialog(
                        context, "Alerta!", "Usuário já existe", false);
                  }
                }
              });
            }
          },
        ));
  }

  showAlertDialog(BuildContext dialogContext, String title, String content,
      bool redirecionar) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(dialogContext).pop();
        if (redirecionar) {
          Navigator.pop(context);
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: dialogContext,
      builder: (BuildContext dialogContext) {
        return alert;
      },
    );
  }
}
