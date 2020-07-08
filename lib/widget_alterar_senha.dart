import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_covid/app_covid_icons.dart';
import 'globals.dart' as globals;
import 'package:crypto/crypto.dart';
import 'dart:convert';

class AlterarSenha extends StatefulWidget {
  @override
  _AlterarSenha createState() => _AlterarSenha();
}

class _AlterarSenha extends State<AlterarSenha> {
  GlobalKey<FormState> _formAlterarSenhaKey = GlobalKey<FormState>();

  TextEditingController txtNovaSenha = TextEditingController();
  TextEditingController txtConfirmaNovaSenha = TextEditingController();

  var db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Alterar Senha"),
          centerTitle: true,
          backgroundColor: Colors.red,
          actions: null,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: _formAlterarSenhaKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  campoSenha(
                      "Nova Senha", txtNovaSenha, "Informe a Nova Senha"),
                  campoSenha("Confirmar Nova Senha", txtConfirmaNovaSenha,
                      "Confirme a Nova Senha"),
                  botaoSalvar(context),
                ],
              )),
        ),
        backgroundColor: Colors.white);
  }

  campoSenha(rotulo, controle, mensagem) {
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
          return (value.isEmpty) ? mensagem : null;
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
            if (_formAlterarSenhaKey.currentState.validate()) {
              if (txtNovaSenha.text != txtConfirmaNovaSenha.text) {
                showAlertDialog(context, "Alerta!",
                    "Nova senha deve ser igual a confirmação", false);
              } else {
                var byteSenha = utf8.encode(txtNovaSenha.text);
                var cryptoSenha = sha1.convert(byteSenha);

                String id = "";
                bool runAux = false;

                db
                    .collection('users')
                    .where("user", isEqualTo: globals.user)
                    .snapshots()
                    .listen((data) {
                  data.documents.forEach((doc) {
                    id = doc.documentID.toString();
                  });
                  if (!runAux) {
                    runAux = true;
                    db
                        .collection("users")
                        .document(id)
                        .updateData({"password": "$cryptoSenha"});
                    showAlertDialog(context, "Sucesso!",
                        "Senha alterada com sucesso", true);
                  }
                });
              }
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
