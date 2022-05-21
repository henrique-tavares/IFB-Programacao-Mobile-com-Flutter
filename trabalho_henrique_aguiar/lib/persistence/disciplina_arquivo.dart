import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class DisciplinaArquivo {
  static const _fileName = 'disciplina.json';

  static Future<File> createFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/$_fileName");
  }

  static Future<String> readFile() async {
    try {
      final file = await createFile();
      return file.readAsString();
    } catch (e) {
      return "Erro ao ler o arquivo";
    }
  }

  static Future<File> writeFile(Object data) async {
    final file = await createFile();
    final encodedData = jsonEncode(data);
    return file.writeAsString(encodedData);
  }
}
