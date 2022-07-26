import 'package:flutter/material.dart';
import 'package:trabalho_final/components/redirect_button.dart';
import 'package:trabalho_final/views/state_details.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final states = {
    "AC": "Acre",
    "AL": "Alagoas",
    "AP": 'Amapá',
    "AM": 'Amazonas',
    "BA": 'Bahia',
    "CE": 'Ceará',
    "DF": 'Distrito Federal',
    "ES": 'Espírito Santo',
    "GO": 'Goiás',
    "MA": 'Maranhão',
    "MT": 'Mato Grosso',
    "MS": 'Mato Grosso do Sul',
    "MG": 'Minas Gerais',
    "PA": 'Pará',
    "PB": 'Paraíba',
    "PR": 'Paraná',
    "PE": 'Pernambuco',
    "PI": 'Piauí',
    "RJ": 'Rio de Janeiro',
    "RN": 'Rio Grande do Norte',
    "RS": 'Rio Grande do Sul',
    "RO": 'Rondônia',
    "RR": 'Roraima',
    "SC": 'Santa Catarina',
    "SP": 'São Paulo',
    "SE": 'Sergipe',
    "TO": 'Tocantins'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.from(states.entries.map(
              (state) =>
                  RedirectButton(title: state.value, target: StateDetails(name: state.value, acronym: state.key)),
            )),
          ),
        ),
      ),
    );
  }
}
