import 'package:flutter/material.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Pagamento de autônomo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _information = "";

  var taxController = TextEditingController();
  var rawValueController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  void _clearForm() {
    taxController.text = "";
    rawValueController.text = "";
    setState(() {
      _information = "Digite os valores";
    });
  }

  void _calculate() {
    setState(() {
      var tax = double.parse(taxController.text);
      var rawValue = double.parse(rawValueController.text);
      var discount = rawValue * (tax / 100.0);
      var realValue = rawValue - discount;

      _information = "Valor bruto: ${rawValue.toStringAsFixed(2)}\n"
          "Desconto: ${discount.toStringAsFixed(2)}\n"
          "Valor líquido: ${realValue.toStringAsFixed(2)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          IconButton(onPressed: _clearForm, icon: const Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Taxa",
                      labelStyle: TextStyle(color: Colors.orangeAccent)),
                  textAlign: TextAlign.center,
                  style:
                      const TextStyle(color: Colors.orangeAccent, fontSize: 18),
                  controller: taxController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Valor da taxa não pode ser nulo";
                    }
                    if (double.tryParse(value) == null) {
                      return "Valor inválido";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Valor bruto",
                      labelStyle: TextStyle(color: Colors.orangeAccent)),
                  textAlign: TextAlign.center,
                  style:
                      const TextStyle(color: Colors.orangeAccent, fontSize: 18),
                  controller: rawValueController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Valor bruto não pode ser nulo";
                    }
                    if (double.tryParse(value) == null) {
                      return "Valor inválido";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        _calculate();
                      }
                    },
                    child: const Text("Calcular"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.orangeAccent,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        )),
                  ),
                ),
                Text(
                  _information,
                  textAlign: TextAlign.center,
                  style:
                      const TextStyle(color: Colors.orangeAccent, fontSize: 18),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
