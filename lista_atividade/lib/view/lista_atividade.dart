import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lista_atividade/model/activity.dart';
import 'package:lista_atividade/persistence/manipula_arquivo.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var manipulaArquivo = ManipulaArquivo('atividades.json');
  final _activityController = TextEditingController();
  Map<String, dynamic>? _lastRemoved;
  int? _lastRemovedPos;
  var _activities = [];

  @override
  void initState() {
    super.initState();
    manipulaArquivo.readFile().then((data) {
      setState(() {
        _activities = jsonDecode(data);
      });
    });
  }

  void _addActivity() {
    setState(() {
      Map<String, dynamic> newActivity = {};
      print(_activityController.text);
      var activity = Activity(_activityController.text, false);
      newActivity = activity.getActivity();
      _activityController.text = "";
      _activities.add(newActivity);
      manipulaArquivo.saveJsonFile(_activities);
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _activities.sort((a, b) {
        if (a["finished"] && !b["finished"]) {
          return 1;
        } else if (!a["finished"] && b["finished"]) {
          return -1;
        } else {
          return 0;
        }
      });

      manipulaArquivo.saveJsonFile(_activities);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(17, 1, 7, 1),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _activityController,
                    decoration:
                        const InputDecoration(labelText: "Nova Atividade"),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _addActivity();
                  },
                  child: const Text("+"),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.0),
                  itemCount: _activities.length,
                  itemBuilder: buildItem),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return Dismissible(
      key: Key(
        DateTime.now().millisecondsSinceEpoch.toString(),
      ),
      background: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(_activities[index]["name"]),
        value: _activities[index]["finished"],
        secondary: CircleAvatar(
          child:
              Icon(_activities[index]["finished"] ? Icons.check : Icons.error),
        ),
        onChanged: (c) {
          setState(() {
            _activities[index]["finished"] = c;
            manipulaArquivo.saveJsonFile(_activities);
          });
        },
      ),
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(_activities[index]);
          _lastRemovedPos = index;
          _activities.removeAt(index);
          manipulaArquivo.saveJsonFile(_activities);
          final snack = SnackBar(
            content: Text("Atividade \"${_lastRemoved!["name"]}\" removida!"),
            action: SnackBarAction(
                label: "Desfazer",
                onPressed: () {
                  setState(() {
                    _activities.insert(_lastRemovedPos!, _lastRemoved);
                    manipulaArquivo.saveJsonFile(_activities);
                  });
                }),
            duration: const Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(snack);
        });
      },
    );
  }
}
