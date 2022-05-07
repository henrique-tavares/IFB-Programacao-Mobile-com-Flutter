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
      home: const MyHomePage(title: 'Calculadora de Salário'),
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
  final _formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var rawSalaryController = TextEditingController();
  var dependentsController = TextEditingController();

  var show = false;
  var result = "";

  void _clearForm() {
    setState(() {
      nameController.text = "";
      rawSalaryController.text = "";
      dependentsController.text = "";
      result = "";
    });
  }

  double _calculateINSS(double salary) {
    if (salary <= 1212) {
      return salary * 0.075;
    }
    if (salary <= 2427.35) {
      return salary * 0.09;
    }
    if (salary <= 3641.03) {
      return salary * 0.12;
    }
    if (salary <= 7087.22) {
      return salary * 0.14;
    }

    return 992.22;
  }

  double _calculateIRPF(double salary) {
    if (salary <= 1903.98) {
      return salary;
    }
    if (salary <= 2826.65) {
      return salary * 0.075 - 142.80;
    }
    if (salary <= 3751.05) {
      return salary * 0.15 - 354.80;
    }
    if (salary <= 4664.68) {
      return salary * 0.225 - 636.13;
    }

    return salary * 0.275 - 869.36;
  }

  void _calculate() {
    var rawSalary = double.parse(rawSalaryController.text);
    var dependents = int.parse(dependentsController.text);

    var inss = _calculateINSS(rawSalary);
    var dependentsDiscount = dependents * 189.59;
    var irpf = _calculateIRPF(rawSalary - inss - dependentsDiscount);

    var liquidSalary = rawSalary - inss - irpf;

    setState(() {
      result = "";
      result += "Nome: ${nameController.text}\n";
      result += "Salário Bruto: R\$${rawSalary.toStringAsFixed(2)}\n";
      result += "INSS: R\$${inss.toStringAsFixed(2)}\n";
      result += "IRPF: R\$${irpf.toStringAsFixed(2)}\n";
      result += "\nSalário líquido: R\$${liquidSalary.toStringAsFixed(2)}\n";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        actions: [IconButton(onPressed: _clearForm, icon: const Icon(Icons.refresh))],
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
                  decoration: const InputDecoration(
                    labelText: "Nome",
                    labelStyle: TextStyle(color: Colors.orangeAccent),
                  ),
                  textAlign: TextAlign.left,
                  style: const TextStyle(color: Colors.orangeAccent, fontSize: 18),
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nome não pode ser nulo";
                    }

                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Salário bruto",
                    labelStyle: TextStyle(color: Colors.orangeAccent),
                  ),
                  textAlign: TextAlign.left,
                  style: const TextStyle(color: Colors.orangeAccent, fontSize: 18),
                  controller: rawSalaryController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Salário bruto não pode ser nulo";
                    }
                    if (double.tryParse(value) == null) {
                      return "Valor inválido";
                    }
                    if (double.parse(value) <= 0) {
                      return "Salário bruto não pode ser menor ou igual a zero";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Quantidade de dependentes",
                    labelStyle: TextStyle(color: Colors.orangeAccent),
                  ),
                  textAlign: TextAlign.left,
                  style: const TextStyle(color: Colors.orangeAccent, fontSize: 18),
                  controller: dependentsController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Quantidade de dependentes não pode ser nulo";
                    }
                    if (int.tryParse(value) == null) {
                      return "Valor inválido";
                    }
                    if (int.parse(value) <= 0) {
                      return "Quantidade de dependentes não pode ser menor ou igual a zero";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
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
                  result,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black54, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
