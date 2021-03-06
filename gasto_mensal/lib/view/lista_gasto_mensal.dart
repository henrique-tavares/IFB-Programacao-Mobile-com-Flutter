import 'package:flutter/material.dart';
import 'package:gasto_mensal/controller/gasto_controller.dart';
import 'package:gasto_mensal/model/gasto_mensal.dart';
import 'package:gasto_mensal/view/cadastro_gasto_mensal.dart';
import 'package:gasto_mensal/view/gasto_item.dart';

class ListaGastoMensal extends StatefulWidget {
  @override
  _ListaGastoMensalState createState() => _ListaGastoMensalState();
}

class _ListaGastoMensalState extends State<ListaGastoMensal> {
  GastoController _gastoController = GastoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "\$ Gasto mensal \$",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<GastoMensal>>(
        initialData: [],
        future: _gastoController.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("Carregando..."),
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<GastoMensal> gastos = snapshot.data!;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final GastoMensal gastoMensal = gastos[index];
                  return Dismissible(
                    key: Key(index.toString()),
                    child: GastoItem(gastoMensal),
                    background: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.red),
                        child: Align(
                          alignment: Alignment(-0.9, 0.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {
                      _gastoController.excluir(gastoMensal.id);
                    },
                  );
                },
                itemCount: gastos.length,
              );
              break;
          }
          return Text("Erro");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Cadastro(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.amber,
      ),
    );
  }
}
