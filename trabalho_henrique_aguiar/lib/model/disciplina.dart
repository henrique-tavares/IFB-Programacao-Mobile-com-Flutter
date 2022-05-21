class Disciplina {
  final int _codigo;
  final String _descricao;
  final int _cargaHoraria;

  Disciplina(this._codigo, this._descricao, this._cargaHoraria);

  factory Disciplina.fromJson(dynamic json) {
    return Disciplina(json['codigo'], json['descricao'], json['cargaHoraria']);
  }

  int get codigo => _codigo;

  String get descricao => _descricao;

  int get cargaHoraria => _cargaHoraria;

  double transformCargaHoraria() {
    return _cargaHoraria * (5 / 6);
  }

  Map toJson() => {'codigo': codigo, 'descricao': descricao, 'cargaHoraria': cargaHoraria};
}
