import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void mainCommon({@required String host, @required String env}) {
  WidgetsFlutterBinding.ensureInitialized();
  var configuredApp = App(host, env);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(configuredApp),
  );
}

class App extends StatelessWidget {
  final String host;
  final String env;

  App(this.host, this.env);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeniusRadio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Codemotion'),
          centerTitle: true,
        ),
        body: Center(
          child: Text('Hello from: ' + this.env),
        ),
      ),
    );
  }
}
