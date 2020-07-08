import 'package:flutter/material.dart';

class Sobre extends StatefulWidget {
  @override
  _Sobre createState() => _Sobre();
}

class _Sobre extends State<Sobre> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sobre"),
          centerTitle: true,
          backgroundColor: Colors.red,
          actions: null,
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),

          child: Column(
            children: <Widget>[
              Text(
                'Objetivo',
                style: TextStyle(
                  fontSize: 25.0, 
                  color: Colors.red, 
                  fontWeight: FontWeight.bold
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),

                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red[200], width: 1),
                    borderRadius: BorderRadius.circular(5),

                    gradient: new LinearGradient(
                      colors: [Colors.red[200], Colors.white10],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight
                    ),
                  ),

                  padding: EdgeInsets.all(10.0),

                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Aplicativo para facilitar a consulta de informações sobre o COVID-19. O Objetivo é trazer aos usuários de forma rápida e prática os dados mais atualizados possíveis sobre a doença. Também com dicas sobre os sintomas, prevenção e o que fazer em caso de supeita de infecção.",
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Desenvolvedores',
                  style: TextStyle(
                    fontSize: 25.0, 
                    color: Colors.red, 
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),

                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red[200], width: 1),
                    borderRadius: BorderRadius.circular(5),

                    gradient: new LinearGradient(
                      colors: [Colors.red[200], Colors.white10],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight
                    ),
                  ),

                  padding: EdgeInsets.all(10.0),

                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text("Pedro Henrique Vicari"),
                        Text("825933"),
                        Image.asset("assets/imagens/pedro.jpg", scale: 1.5, fit: BoxFit.fitWidth,),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),

                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red[200], width: 1),
                    borderRadius: BorderRadius.circular(5),

                    gradient: new LinearGradient(
                      colors: [Colors.red[200], Colors.white10],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight
                    ),
                  ),

                  padding: EdgeInsets.all(10.0),

                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text("Wellington Bernardes"),
                        Text("825976"),
                        Image.asset("assets/imagens/wellington.jpg", scale: 3.5, fit: BoxFit.fitWidth,),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ),

        backgroundColor: Colors.white);
  }
}




