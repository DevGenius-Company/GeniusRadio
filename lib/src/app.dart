import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genius_radio/resources/app_config.dart';

void mainCommon({@required String host}) {
  WidgetsFlutterBinding.ensureInitialized();
  var configuredApp = App(host);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(configuredApp),
  );
}

class App extends StatelessWidget {
  final String host;

  App(this.host);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppConfig(
      host,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(AppConfig.of(context).host),
      ),
    );
  }
}
