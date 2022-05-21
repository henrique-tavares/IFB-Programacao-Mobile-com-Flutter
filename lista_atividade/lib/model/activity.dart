class Activity {
  String _name;
  bool _finished;

  Activity(this._name, this._finished);

  bool get finished => _finished;

  String get name => _name;

  Map<String, dynamic> getActivity() {
    return {
      'name': _name,
      'finished': _finished
    };
  }

}