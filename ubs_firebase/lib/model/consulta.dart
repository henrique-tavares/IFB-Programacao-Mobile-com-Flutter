class Consulta {
  String? id;
  String ubs;
  String especialidade;
  String data;

  Consulta(this.ubs, this.data, this.especialidade, {this.id});

  Map<String, dynamic> toMap() => {
        "UBS": ubs,
        "especialidade": especialidade,
        "data": data,
      };

  @override
  String toString() {
    return "UBS: $ubs \nData: $data \nEspecialidade: $especialidade";
  }

  Consulta.fromJson(Map<String, dynamic> json, String idFirebase)
      : ubs = json["UBS"],
        data = json["data"],
        especialidade = json["especialidade"],
        id = idFirebase;
}
