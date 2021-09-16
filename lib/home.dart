import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _pegarPreco() async {
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = json.decode(response.body);
    print("Resultado" + retorno.toString());

    setState(() {
      _preco = retorno["BRL"]["buy"].toString();
    });
  }

  String _preco = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[800],
        title: Text("API - Bitcoin"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/bitcoin.png"),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  "R\$" + _preco,
                  style: TextStyle(
                    fontSize: 35,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _pegarPreco,
                child: Text(
                  "Atualizar",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow[800],
                  padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
