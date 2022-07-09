import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'view/lista_consulta.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const UBSApp());
}

class UBSApp extends StatelessWidget {
  const UBSApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.red, // Your accent color
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.red,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: const ListaConsulta(),
    );
  }
}
