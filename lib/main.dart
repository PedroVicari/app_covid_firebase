import 'package:flutter/material.dart';
import 'package:app_covid/widget_login.dart';
import 'package:app_covid/widget_novo_usuario.dart';
import 'package:app_covid/widget_menu.dart';
import 'package:app_covid/widget_sobre.dart';
import 'package:app_covid/widget_sintomas.dart';
import 'package:app_covid/widget_estados.dart';
import 'package:app_covid/widget_emergencia.dart';
import 'package:app_covid/widget_alterar_senha.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Informações - COVID-19",
      initialRoute: '/Login',
      routes: {
        '/Login': (context) => Login(),
        '/NovoUsuario': (context) => NovoUsuario(),
        '/Menu': (context) => Menu(),
        '/Sobre': (context) => Sobre(),
        '/Estados': (context) => Estados(),
        '/Sintomas': (context) => Sintomas(),
        '/Emergencia': (context) => Emergencia(),
        '/AlterarSenha': (context) => AlterarSenha(),
      },
    );
  }
}
