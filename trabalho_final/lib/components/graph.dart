import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:trabalho_final/models/covid_case.dart';

enum GraphMetric {
  cases,
  death,
}

enum GraphPeriod {
  week,
  month,
  semester,
  year,
  all,
}

class Graph extends StatefulWidget {
  const Graph({Key? key, required this.metric, required this.data, required this.period}) : super(key: key);

  final GraphMetric metric;
  final List<CovidCase> data;
  final GraphPeriod period;

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  var seriesData = <charts.Series<CovidCase, DateTime>>[];

  @override
  void initState() {
    super.initState();

    setState(() {
      _fetchData() {
        final casesInPeriod = widget.data.where((covidCase) {
          final differenceFromNow = DateTime.now().difference(covidCase.date);
          switch (widget.period) {
            case GraphPeriod.week:
              return differenceFromNow.inDays <= 7;
            case GraphPeriod.month:
              return differenceFromNow.inDays <= 31;
            case GraphPeriod.semester:
              return differenceFromNow.inDays <= 182;
            case GraphPeriod.year:
              return differenceFromNow.inDays <= 365;
            case GraphPeriod.all:
              return true;
          }
        }).toList();

        switch (widget.metric) {
          case GraphMetric.cases:
            return [
              charts.Series(
                id: 'cases chart',
                data: casesInPeriod,
                domainFn: (CovidCase covidCase, _) => covidCase.date,
                measureFn: (CovidCase covidCase, _) => covidCase.confirmed,
                colorFn: (CovidCase covidCase, _) => charts.Color.fromHex(code: '#ff0000'),
              )
            ];
          case GraphMetric.death:
            return [
              charts.Series(
                id: 'cases chart',
                data: casesInPeriod,
                domainFn: (CovidCase covidCase, _) => covidCase.date,
                measureFn: (CovidCase covidCase, _) => covidCase.deaths,
                colorFn: (CovidCase covidCase, _) => charts.Color.fromHex(code: '#282a36'),
              )
            ];
        }
      }

      seriesData = _fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: charts.TimeSeriesChart(
            seriesData,
            animate: true,
          ),
        ),
      ),
    );
  }
}
