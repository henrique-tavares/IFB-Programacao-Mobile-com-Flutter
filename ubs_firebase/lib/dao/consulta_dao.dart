import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/consulta.dart';

class ConsultaDao {
  final databaseReference = FirebaseFirestore.instance;
  static const colecao = "consultas";

  Future<String> inserir(Consulta consulta) async {
    try {
      DocumentReference ref = await databaseReference.collection(colecao).add(consulta.toMap());
      return ref.id;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> alterar(Consulta consluta) async {
    try {
      await databaseReference.collection(colecao).doc(consluta.id).update(consluta.toMap());
      return "Registro atualizado";
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Consulta>> findAll() async {
    QuerySnapshot consultas = await databaseReference.collection(colecao).get();
    List<Consulta> listaConsultas = [];
    for (final elemento in consultas.docs) {
      listaConsultas.add(Consulta.fromJson(elemento.data() as Map<String, dynamic>, elemento.id));
    }
    return listaConsultas;
  }

  Future<String> excluir(String id) async {
    try {
      await databaseReference.collection(colecao).doc(id).delete();
      return "Registro excluído com projeto";
    } catch (e) {
      return e.toString();
    }
  }
}
