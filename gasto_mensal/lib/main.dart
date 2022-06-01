import 'package:flutter/material.dart';
import 'package:gasto_mensal/controller/gasto_controller.dart';
import 'package:gasto_mensal/model/gasto_mensal.dart';
import 'package:gasto_mensal/view/cadastro_gasto_mensal.dart';
import 'package:gasto_mensal/view/lista_gasto_mensal.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        hintColor: Colors.deepOrangeAccent,
        primaryColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.amber)
            ),
            hintStyle: TextStyle(color: Colors.amber)
        ),
        primarySwatch: Colors.blue,
      ),
      home: ListaGastoMensal()
  ));
}
