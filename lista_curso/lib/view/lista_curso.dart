import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lista_curso/model/curso.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _cursoController = TextEditingController();
  var _cargaHorariaController = TextEditingController();

  final cursos = [
    Curso("Java básico", 40),
    Curso("Python avançado", 30),
    Curso("Angular básico", 20)
  ];


  void _inserir() {
    setState(() {
      cursos.insert(0, Curso(_cursoController.text, int.tryParse(_cargaHorariaController.text) ?? 0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de cursos"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: _cursoController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Curso',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: _cargaHorariaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Carga Horrária',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _inserir,
            child: const Text("Inserir"),
            style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: cursos.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    margin: const EdgeInsets.all(2.0),
                    color: cursos[index].cargaHoraria >= 40
                        ? Colors.blue[400]
                        : cursos[index].cargaHoraria >= 30
                            ? Colors.blue[100]
                            : Colors.grey,
                    child: Center(
                      child: Text(
                        cursos[index].toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
