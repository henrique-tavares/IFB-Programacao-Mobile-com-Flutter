import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabalho_final/components/graph.dart';
import 'package:trabalho_final/controllers/cases.dart';
import 'package:trabalho_final/models/covid_case.dart';

class StateDetails extends StatefulWidget {
  const StateDetails({Key? key, required this.name, required this.acronym}) : super(key: key);

  final String name;
  final String acronym;

  @override
  State<StateDetails> createState() => _StateDetailsState();
}

class _StateDetailsState extends State<StateDetails> {
  final casesController = CasesController();

  late Future<List<CovidCase>> stateData;
  late Future<List<CovidCase>> topCitiesFromState;
  var lastUpdate = '';

  @override
  void initState() {
    super.initState();

    stateData = casesController.fromState(widget.acronym);
    topCitiesFromState = casesController.topCitiesFromState(widget.acronym);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Center(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 780,
                    child: FutureBuilder(
                      future: stateData,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              snapshot.error as String,
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        }

                        if (snapshot.hasData) {
                          Future.delayed(const Duration(milliseconds: 100), () {
                            setState(() {
                              lastUpdate = DateFormat.yMMMMd('pt_BR').format(
                                  (snapshot.data as List<CovidCase>).where((covidCase) => covidCase.isLast).first.date);
                            });
                          });
                        }

                        return snapshot.hasData
                            ? ContainedTabBarView(
                                tabs: const [
                                  Text(
                                    '1 Semana',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  Text(
                                    '1 Mês',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  Text(
                                    '6 Meses',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  Text(
                                    '1 Ano',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  Text(
                                    'Máximo',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ],
                                views: GraphPeriod.values
                                    .map(
                                      (period) => Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Column(
                                          children: [
                                            const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Text(
                                                  "Gráfico de Casos",
                                                  style: TextStyle(fontSize: 20),
                                                ),
                                              ),
                                            ),
                                            Graph(
                                              metric: GraphMetric.cases,
                                              data: snapshot.data as List<CovidCase>,
                                              period: period,
                                            ),
                                            const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Text(
                                                  "Gráfico de Mortes",
                                                  style: TextStyle(fontSize: 20),
                                                ),
                                              ),
                                            ),
                                            Graph(
                                              metric: GraphMetric.death,
                                              data: snapshot.data as List<CovidCase>,
                                              period: period,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              );
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Cidades com maior risco:",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: topCitiesFromState,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error as String);
                      }

                      return snapshot.hasData
                          ? Column(
                              children: (snapshot.data as List<CovidCase>)
                                  .map(
                                    (covidCase) => Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              covidCase.city!,
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Casos: ',
                                                  style: TextStyle(color: Colors.black54),
                                                ),
                                                Text(
                                                  covidCase.confirmed.toString(),
                                                  style: const TextStyle(color: Colors.redAccent),
                                                ),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                const Text(
                                                  'Mortes: ',
                                                  style: TextStyle(color: Colors.black54),
                                                ),
                                                Text(
                                                  covidCase.deaths.toString(),
                                                  style: const TextStyle(color: Colors.redAccent),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                    child: Text(
                      "Última atualização em: $lastUpdate",
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
