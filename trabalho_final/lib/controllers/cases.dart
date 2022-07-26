import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:trabalho_final/models/covid_case.dart';

class CasesController {
  Future<List<CovidCase>> fromState(String state) async {
    final uri = Uri.https('api.brasil.io', '/v1/dataset/covid19/caso/data', {'place_type': 'state', 'state': state});
    final response = await http.get(uri, headers: {'Authorization': 'Token ${dotenv.get('BRASIL_IO_TOKEN')}'});

    final parsedBody = jsonDecode(utf8.decode(response.bodyBytes));

    if (parsedBody['results'] == null) {
      return Future.error("O limite de consumo da API foi atingido! Tente novamente daqui há alguns instantes.");
    }

    final List<CovidCase> covidCases =
        parsedBody['results'].map((json) => CovidCase.fromJson(json)).toList().cast<CovidCase>();

    return covidCases;
  }

  Future<List<CovidCase>> topCitiesFromState(String state) async {
    final uri = Uri.https(
      'api.brasil.io',
      '/v1/dataset/covid19/caso/data',
      {'place_type': 'city', 'state': state, 'is_last': 'True'},
    );
    final response = await http.get(uri, headers: {'Authorization': 'Token ${dotenv.get('BRASIL_IO_TOKEN')}'});

    final parsedBody = jsonDecode(utf8.decode(response.bodyBytes));

    if (parsedBody['results'] == null) {
      return Future.error("O limite de consumo da API foi atingido! Tente novamente daqui há alguns instantes.");
    }

    final List<CovidCase> covidCases =
        parsedBody['results'].map((json) => CovidCase.fromJson(json)).toList().cast<CovidCase>();

    covidCases.sort(
      (a, b) => a.confirmed.compareTo(b.confirmed),
    );

    final topCities = covidCases.reversed.toList().getRange(0, 10).toList();

    return topCities;
  }
}
