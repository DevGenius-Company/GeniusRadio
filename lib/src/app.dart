import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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
    return NeumorphicTheme(
      theme: NeumorphicThemeData(
        baseColor: Color.fromRGBO(248,247,247,1),
        shadowLightColor: Colors.white,
        accentColor: Colors.cyan,
        depth: 6,
        intensity: 0.5,
      ),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(248,247,247,1),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  NeumorphicButton(
                      padding: EdgeInsets.all(0),
                      style: NeumorphicStyle(
                        shadowLightColor: Colors.white,
                        surfaceIntensity: 0.15,
                        boxShape: NeumorphicBoxShape.circle(),
                        shape: NeumorphicShape.flat,
                      ),
                      child: CircleAvatar(radius:40,backgroundImage: Image.network("https://avatars.githubusercontent.com/u/80033394?s=400&u=c7ab6ed6420f6a3bfd7a06b77823e6330a4de7f4&v=4").image,),
                      onPressed: () {}),
                  Spacer(),
                  NeumorphicButton(
                      style: NeumorphicStyle(
                        surfaceIntensity: 0.15,
                        boxShape: NeumorphicBoxShape.circle(),
                        shadowLightColor: Colors.white,
                        shape: NeumorphicShape.flat,
                      ),
                      child: Icon(Icons.share_outlined,size: 40,color: Color.fromRGBO(26,41,75,1),),
                      onPressed: () {}),
                ],
              ),
            ),
            Neumorphic(
                padding: EdgeInsets.all(10),
                style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.circle(),
                    depth: 8,
                    lightSource: LightSource.topLeft,
                    color: Colors.white
                ),
                child: CircleAvatar(radius:200,backgroundImage: Image.network("https://avatars.githubusercontent.com/u/80033394?s=400&u=c7ab6ed6420f6a3bfd7a06b77823e6330a4de7f4&v=4").image,)
            ),
          ],
        ),
      ),
    );
  }
}
