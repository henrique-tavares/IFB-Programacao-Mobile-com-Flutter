import 'package:cloud_firestore/cloud_firestore.dart';

import '../dao/consulta_dao.dart';
import '../model/consulta.dart';

class ConsultaController {
  ConsultaDao consluta = ConsultaDao();
  final databaseReference = FirebaseFirestore.instance;

  Future<String> salvar(Consulta consulta) async {
    final consultas = await consluta.findAll();
    if (consultas
            .where((c) => c.data == consulta.data && c.especialidade == consulta.especialidade && c.ubs == consulta.ubs)
            .length >=
        20) {
      return Future.error("Limite de consultas para essa Ubs, nessa especialidade, nesse dia atingido.");
    }

    if (consulta.id == null) {
      return consluta.inserir(consulta);
    } else {
      return consluta.alterar(consulta);
    }
  }

  Future<List<Consulta>> findAll() async {
    return consluta.findAll();
  }

  Future<String> excluir(String id) {
    return consluta.excluir(id);
  }
}
