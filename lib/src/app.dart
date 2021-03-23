import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:genius_radio/resources/app_config.dart';
import 'package:genius_radio/src/home/ui/view/home_page.dart';
import 'package:genius_radio/src/stores/base_store.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        Provider<BaseStore>(
          create: (_) => BaseStore(),
        )
      ],
      child: AppConfig(host, env: env, child: HomePage()),
    );
  }
}
