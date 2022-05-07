class Curso {
  final String _nome;
  final int _cargaHoraria;

  Curso(this._nome, this._cargaHoraria);

  int get cargaHoraria => _cargaHoraria;

  String get nome => _nome;

  @override
  String toString() {
    return '$_nome ($_cargaHoraria)';
  }
}