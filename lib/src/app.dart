import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:genius_radio/src/home/ui/view/home_page.dart';
import 'package:genius_radio/src/stores/base_store.dart';

final baseStore = BaseStore();

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
    return HomePage(baseStore);
  }
}
