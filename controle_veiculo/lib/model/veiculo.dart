class Veiculo {
  final String _placa;
  final String _ano;
  final String _cor;
  final String _marca;
  final String _modelo;

  Veiculo(this._placa, this._ano, this._cor, this._marca, this._modelo);

  String get modelo => _modelo;

  String get marca => _marca;

  String get cor => _cor;

  String get ano => _ano;

  String get placa => _placa;

  @override
  String toString() {
    return "$_modelo $_cor $_ano";
  }
}