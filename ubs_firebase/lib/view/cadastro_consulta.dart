import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controller/consulta_controller.dart';
import '../model/consulta.dart';
import 'lista_consulta.dart';

class CadastroCurso extends StatefulWidget {
  final Consulta? curso;

  const CadastroCurso({Key? key, this.curso}) : super(key: key);

  @override
  _CadastroCursoState createState() => _CadastroCursoState();
}

class _CadastroCursoState extends State<CadastroCurso> {
  final _cursoController = ConsultaController();
  String? _id;
  final _dataController = TextEditingController();

  final _especialidades = [
    "Cardiologista",
    "Oftamologista",
    "Pediatra",
    "Otorrinolaringologista",
    "Clínico",
    "Dermatologista"
  ];
  final _listaUbs = [
    "Unidade Básica de Saúde de Águas Claras",
    "Unidade Básica de Saúde da Asa Norte",
    "Unidade Básica de Saúde da Asa Sul",
    "Unidade Básica de Saúde de Brazlândia",
    "Unidade Básica de Saúde da Ceilândia",
    "Unidade Básica de Saúde do Gama",
    "Unidade Básica de Saúde do Guará",
    "Unidade Básica de Saúde do Núcleo Bandeirante",
    "Unidade Básica de Saúde de Planaltina",
    "Unidade Básica de Saúde do Recando das Emas",
    "Unidade Básica de Saúde do Riacho Fundo",
    "Unidade Básica de Saúde de Samambaia",
    "Unidade Básica de Saúde de Sobradinho",
    "Unidade Básica de Saúde de Taguatinga"
  ];

  String? _especialidadeSelecionada;
  String? _ubsSelecionado;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  _displaySnackBar(BuildContext context, String mensagem) {
    final snackBar = SnackBar(
      content: Text(mensagem),
      backgroundColor: Colors.green[900],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _salvar(BuildContext context) {
    if (_ubsSelecionado == null || _especialidadeSelecionada == null) {
      return;
    }

    final curso = Consulta(_ubsSelecionado!, _dataController.text, _especialidadeSelecionada!, id: _id);

    setState(() {
      _cursoController.salvar(curso).then((res) {
        _displaySnackBar(context, res.toString());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ListaConsulta(),
          ),
        );
      }, onError: (error) {
        _displaySnackBar(context, error.toString());
      });
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.curso != null) {
      _id = widget.curso!.id;
      _ubsSelecionado = widget.curso!.ubs;
      _dataController.text = widget.curso!.data;
      _especialidadeSelecionada = widget.curso!.especialidade;
    } else {
      _id = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Cadastro de Consulta"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ListaConsulta()),
              );
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: "Unidade Básica de Saúde",
                        labelStyle: TextStyle(color: Colors.black87),
                      ),
                      items: _listaUbs
                          .map((ubs) => DropdownMenuItem(
                                child: Text(ubs),
                                value: ubs,
                              ))
                          .toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _ubsSelecionado = value;
                        });
                      },
                      value: _ubsSelecionado,
                      style: const TextStyle(color: Colors.black87, fontSize: 15),
                      validator: (value) {
                        if (value == null) {
                          return "Ubs não pode ser nula";
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: "Especialidade",
                        labelStyle: TextStyle(color: Colors.black87),
                      ),
                      items: _especialidades
                          .map((especialidade) => DropdownMenuItem(
                                child: Text(especialidade),
                                value: especialidade,
                              ))
                          .toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _especialidadeSelecionada = value;
                        });
                      },
                      value: _especialidadeSelecionada,
                      style: const TextStyle(color: Colors.black87, fontSize: 15),
                      validator: (value) {
                        if (value == null) {
                          return "Especialidade não pode ser nula";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: _dataController,
                      decoration: const InputDecoration(
                        labelText: "Data",
                        labelStyle: TextStyle(color: Colors.black87),
                      ),
                      readOnly: true,
                      onTap: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 7)),
                        );

                        if (pickedDate != null) {
                          final formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);

                          setState(() {
                            _dataController.text = formattedDate;
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Data não pode ser nula";
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      _salvar(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    onPrimary: Colors.green,
                  ),
                  label: const Text(
                    'Salvar',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  icon: const Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
