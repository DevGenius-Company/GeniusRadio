import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:genius_radio/resources/app_config.dart';
import 'package:provider/provider.dart';
import 'package:genius_radio/src/stores/base_store.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BaseStore baseStore;

  @override
  void initState() {
    super.initState();
    baseStore = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => MaterialApp(
        title: 'GeniusRadio',
        theme: ThemeData(
          primarySwatch: baseStore.blue ? Colors.blue : Colors.red,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Welcome to Codemotion'),
            centerTitle: true,
          ),
          body: Center(
            child: Text('Hello from: ' + AppConfig.of(context).env),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: baseStore.toggleBlue,
            tooltip: 'Change color',
            child: Icon(Icons.refresh),
          ),
        ),
      ),
    );
  }
}
