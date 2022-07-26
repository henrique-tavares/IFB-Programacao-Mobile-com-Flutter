import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:trabalho_final/views/home.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await initializeDateFormatting('pt_BR', null);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const Home(title: 'Mini Covid19 Dashboard'),
    );
  }
}
