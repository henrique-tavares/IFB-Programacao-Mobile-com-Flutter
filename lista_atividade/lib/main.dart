import 'package:flutter/material.dart';
import 'package:lista_atividade/view/lista_atividade.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.amber[900],
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary:Colors.blueAccent
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary
        )
      ),
      home: const Home(title: 'Lista de Atividades'),
    );
  }
}