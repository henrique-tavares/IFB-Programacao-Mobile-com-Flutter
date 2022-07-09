import 'package:flutter/material.dart';
import '../component/consulta_item.dart';
import '../controller/consulta_controller.dart';
import '../model/consulta.dart';
import 'cadastro_consulta.dart';

class ListaConsulta extends StatefulWidget {
  const ListaConsulta({Key? key}) : super(key: key);

  @override
  _ListaConsultaState createState() => _ListaConsultaState();
}

class _ListaConsultaState extends State<ListaConsulta> {
  List<Consulta> _listaConsulta = [];
  final _consultaController = ConsultaController();

  @override
  void initState() {
    super.initState();
    _consultaController.findAll().then((dados) {
      setState(() {
        _listaConsulta = dados;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Lista de consultas"),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<Consulta>>(
        initialData: _listaConsulta,
        future: _consultaController.findAll(),
// ignore: missing_return
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    CircularProgressIndicator(),
                    Text("Carregando..."),
                  ],
                ),
              );
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Consulta>? cursos = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Consulta curso = cursos![index];
                  return ConsultaItem(curso, _listaConsulta, index);
                },
                itemCount: cursos!.length,
              );
          }
          return const Text("Erro");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CadastroCurso(),
              ),
            );
          });
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }
}
