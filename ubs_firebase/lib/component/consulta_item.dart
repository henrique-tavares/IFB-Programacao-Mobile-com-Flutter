import 'package:flutter/material.dart';
import '../controller/consulta_controller.dart';
import '../model/consulta.dart';
import '../view/cadastro_consulta.dart';
import '../view/lista_consulta.dart';

class ConsultaItem extends StatefulWidget {
  final Consulta _consulta;
  final List<Consulta> _listaConsulta;
  final int _index;

  const ConsultaItem(this._consulta, this._listaConsulta, this._index, {Key? key}) : super(key: key);

  @override
  _ConsultaItemState createState() => _ConsultaItemState();
}

class _ConsultaItemState extends State<ConsultaItem> {
  Consulta? _ultimoRemovido;

  final _consultaController = ConsultaController();

  _atualizarLista() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListaConsulta(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: Card(
        color: Colors.grey[200],
        child: ListTile(
          title: Text(
            widget._consulta.ubs,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget._consulta.especialidade,
                style: const TextStyle(fontSize: 13.0),
              ),
              Text(
                widget._consulta.data,
                style: const TextStyle(
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CadastroCurso(
                  curso: widget._listaConsulta[widget._index],
                ),
              ),
            );
          },
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          mostrarAlerta(context);
        });
      },
    );
  }

  mostrarAlerta(BuildContext context) {
    Widget botaoNao = TextButton(
      child: const Text(
        "Não",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        _atualizarLista();
      },
    );
    Widget botaoSim = TextButton(
      child: const Text(
        "Sim",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () {
        _ultimoRemovido = widget._listaConsulta[widget._index];
        widget._listaConsulta.removeAt(widget._index);
        _consultaController.excluir(_ultimoRemovido!.id!);
        _atualizarLista();
      },
    );
    AlertDialog alerta = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: Colors.orange[800],
      title: const Text(
        "Aviso",
        style: TextStyle(color: Colors.black),
      ),
      content: const Text(
        "Deseja apagar o registro?",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        botaoNao,
        botaoSim,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
}
