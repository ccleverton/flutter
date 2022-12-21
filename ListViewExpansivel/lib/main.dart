import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
      theme: ThemeData(
          listTileTheme: (const ListTileThemeData(
              textColor: Colors.black,
              contentPadding: EdgeInsets.fromLTRB(25, 0, 15, 0))),
          expansionTileTheme: const ExpansionTileThemeData(
            textColor: Colors.black,
            iconColor: Colors.black,
            childrenPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
          )),
    );
  }
}

class Item {
  int idx;
  String title;
  String type;
  String path;
  List<Item>? subItens;

  Item(
      {required this.idx,
      required this.title,
      required this.type,
      required this.path,
      this.subItens});
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<Item> items = [
    Item(idx: 1, title: "C\\", type: "folder", path: "/pasta", subItens: [
      Item(
        idx: 10,
        title: "Desenvolvimento",
        type: "folder",
        path: "C\\Programas",
        subItens: [
          Item(
            idx: 11,
            title: "Microsoft",
            type: "folder",
            path: "",
            subItens: [
              Item(idx: 12, title: "VsCode.msi", type: "file", path: ""),
              Item(idx: 13, title: "SqlServer.msi", type: "file", path: "")
            ],
          ),
          Item(idx: 15, title: "Google", type: 'folder', path: '', subItens: [
            Item(idx: 12, title: "Node14.msi", type: "file", path: ""),
            Item(idx: 13, title: "FlutterSDK.msi", type: "file", path: "")
          ])
        ],
      )
    ]),
    Item(idx: 10, title: "Google", type: "file", path: ""),
    Item(idx: 12, title: "D\\", type: "folder", path: ""),
    Item(idx: 13, title: "CrackOffice2019.exe", type: "file", path: ""),
    Item(
        idx: 121,
        title: "D\\ProgramasDev",
        type: "folder",
        path: "",
        subItens: [
          Item(
              idx: 122,
              title: "GlobalLink",
              type: "folder",
              path: "",
              subItens: [
                Item(idx: 123, title: "GlobalLink.doc", type: "file", path: ""),
                Item(
                    idx: 124,
                    title: "Bin",
                    type: "folder",
                    path: "",
                    subItens: [
                      Item(
                          idx: 125,
                          title: "flutter.exe",
                          type: "file",
                          path: ""),
                      Item(idx: 126, title: "dart.exe", type: "file", path: ""),
                      Item(
                          idx: 126,
                          title: "Debug",
                          type: "folder",
                          path: "",
                          subItens: [
                            Item(
                                idx: 125,
                                title: "flutter.debug.exe",
                                type: "file",
                                path: ""),
                            Item(
                                idx: 126,
                                title: "dart.debug.exe",
                                type: "file",
                                path: ""),
                          ]),
                    ]),
                Item(idx: 127, title: "GlobalLink.txt", type: "file", path: "")
              ]),
          Item(idx: 127, title: "CrackDev.exe", type: "file", path: ""),
          Item(idx: 129, title: "PokerJob", type: "folder", path: "")
        ]),
  ];

  Widget adicionarItens(Item item, ExpansionTile? pastaAtual) {
    var novaPasta = ExpansionTile(title: Text(item.title), children: []);
    var novoArquivo = ListTile(title: Text(item.title));
    var retorno = item.type == 'folder' ? novaPasta : novoArquivo;

    ExpansionTile pastaSelecionada = pastaAtual ?? novaPasta;

    if (pastaAtual != null) {
      pastaSelecionada.children.add(retorno);
    }

    item.subItens?.forEach((element) {
      if (item.type == 'folder')
        adicionarItens(element, novaPasta);
      else
        adicionarItens(element, null);
    });

    return retorno;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return adicionarItens(item, null);
                }))
      ],
    );
  }
}
