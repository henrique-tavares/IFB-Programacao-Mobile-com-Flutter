import 'package:controle_veiculo/model/veiculo.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _placaController = TextEditingController();
  final _anoController = TextEditingController();
  final _corController = TextEditingController();
  final _marcaController = TextEditingController();
  final _modeloController = TextEditingController();

  final veiculos = [Veiculo('ABC1234', '2009', 'Prata', 'Volkswagen', 'Fox')];

  void _inserir() {
    setState(() {
      veiculos.insert(
        0,
        Veiculo(
            _placaController.text,
            int.tryParse(_anoController.text) != null
                ? _anoController.text
                : "",
            _corController.text,
            _marcaController.text,
            _modeloController.text),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de veiculos"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: _placaController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Placa',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: _anoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ano',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: _corController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Cor',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: _marcaController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Marca',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: _modeloController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Modelo',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _inserir,
                child: const Text("Inserir"),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: veiculos.map((veiculo) {
                    return Container(
                      margin: const EdgeInsets.all(2.0),
                      height: 50,
                      color: Colors.grey,
                      child: Center(
                        child: Text(
                          veiculo.toString(),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    );}
                  ).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
