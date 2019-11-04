import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  String _saudacao = "";
  String _infoText = "Informe seus dados!";
  String _categoria = "";
  MaterialColor cor = Colors.lightGreen;

  TextEditingController weightController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _categoria = "";
      cor = Colors.lightGreen;
    });
  }

  void _calculaImc() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      _infoText = "IMC: " + imc.toStringAsPrecision(3);
      if (imc < 18.6) {
        _categoria = "Abaixo do peso";
        cor = Colors.amber;
      } else if (imc >= 18.6 && imc <= 24.9) {
        _categoria = "Peso ideal";
        cor = Colors.lightGreen;
      } else if (imc >= 24.9 && imc <= 29.9) {
        _categoria = "Levemente acima do peso";
        cor = Colors.yellow;
      } else if (imc >= 29.9 && imc <= 34.9) {
        _categoria = "Obesidade Grau I";
        cor = Colors.orange;
      } else if (imc >= 24.9 && imc <= 39.9) {
        _categoria = "Obesidade Grau II";
        cor = Colors.deepOrange;
      } else if (imc >= 40) {
        _categoria = "Obesidade Grau III";
        cor = Colors.red;
      }
    });
  }

  void setSaudacao(DateTime data) {
    setState(() {
      if (data.hour < 5 && data.hour > 18) {
        _saudacao = "Boa noite!";
      } else if (data.hour > 4 && data.hour < 13) {
        _saudacao = "Bom dia!";
      } else {
        _saudacao = "Boa tarde!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setSaudacao(DateTime.now());
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _resetFields();
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10, top: 20, bottom: 40),
                child: Text(
                  _saudacao,
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
              Icon(
                Icons.person_pin,
                size: 120.0,
                color: cor,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso Kg",
                    labelStyle:
                        TextStyle(color: Colors.lightGreen, fontSize: 25)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightGreen, fontSize: 25),
                controller: weightController,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura cm",
                      labelStyle:
                          TextStyle(color: Colors.lightGreen, fontSize: 25)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.lightGreen, fontSize: 25),
                  controller: heightController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      _calculaImc();
                      FocusScope.of(context).unfocus();
                    },
                    child: Text("Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                    color: Colors.lightGreen,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  _infoText,
                  style: TextStyle(color: Colors.lightGreen, fontSize: 25),
                ),
              ),
              Text(
                _categoria,
                style: TextStyle(color: Colors.lightGreen, fontSize: 25),
              )
            ],
          ),
        ));
  }
}
