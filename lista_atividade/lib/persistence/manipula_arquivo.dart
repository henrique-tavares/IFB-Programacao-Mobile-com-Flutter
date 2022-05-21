
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ManipulaArquivo {
  String _fileName;

  String get fileName => _fileName;

  ManipulaArquivo(this._fileName);

  Future<File> createFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/$fileName");
  }

  Future<String> readFile() async {
    try {
      final file = await createFile();
      return file.readAsString();
    } catch (err) {
      return "Erro ao ler arquivo";
    }
  }

  Future<File> saveJsonFile(Object data) async {
    final encodedData = jsonEncode(data);
    final file = await createFile();
    return file.writeAsString(encodedData);
  }

}