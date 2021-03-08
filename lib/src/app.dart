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
        shadowDarkColor: Colors.grey[400],
        accentColor: Colors.cyan,
        depth: 10,
        intensity: 2,
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
                  Container(
                    height: 80,
                    width: 80,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: NeumorphicButton(
                          padding: EdgeInsets.all(4),
                          style: NeumorphicStyle(
                            boxShape: NeumorphicBoxShape.circle()
                          ),
                          child: Hero(tag: 'devGenius',child: CircleAvatar(backgroundImage: Image.network("https://avatars.githubusercontent.com/u/80033394?s=400&u=c7ab6ed6420f6a3bfd7a06b77823e6330a4de7f4&v=4").image,)),
                          onPressed: () {}),
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 80,
                    width: 80,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: NeumorphicButton(
                          style: NeumorphicStyle(
                            boxShape: NeumorphicBoxShape.circle()
                          ),
                          child: Icon(Icons.share_outlined,color: Color.fromRGBO(26,41,75,1),),
                          onPressed: () {}),
                    ),
                  ),

                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Neumorphic(
                    padding: EdgeInsets.all(10),
                    style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(65)),
                      color: Colors.white
                    ),
                    child: Container()
                ),
              )
            ),
            /*Neumorphic(
                padding: EdgeInsets.all(10),
                style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.circle(),
                ),
                child: CircleAvatar(radius:200,backgroundImage: Image.network("https://upload.wikimedia.org/wikipedia/commons/b/be/Acdc_backinblack_cover.jpg").image,)
            ),*/
          ],
        ),
      ),
    );
  }
}
