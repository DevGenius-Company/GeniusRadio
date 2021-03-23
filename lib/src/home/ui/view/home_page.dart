import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:genius_radio/resources/app_config.dart';
import 'package:provider/provider.dart';
import 'package:genius_radio/src/stores/base_store.dart';

class HomePage extends StatefulWidget {
  final BaseStore baseStore;
  HomePage(this.baseStore);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final BaseStore baseStore; // <- Noooooooo!!!!!
  // _HomePageState(this.baseStore) // <- Noooooooo!!!!!

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => MaterialApp(
        title: 'GeniusRadio',
        theme: ThemeData(
          primarySwatch: widget.baseStore.blue ? Colors.blue : Colors.red,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Welcome to Codemotion'),
            centerTitle: true,
          ),
          body: Center(
            child: Text('Codemotion 2021!'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: widget.baseStore.toggleBlue,
            tooltip: 'Change color',
            child: Icon(Icons.refresh),
          ),
        ),
      ),
    );
  }
}
