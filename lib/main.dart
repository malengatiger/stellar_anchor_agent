import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stellar_anchor_agentx/ui/dashboard.dart';
import 'package:stellar_anchor_agentx/welcome/welcome.dart';
import 'package:stellar_anchor_library/api/auth.dart';
import 'package:stellar_anchor_library/util/functions.dart';
import 'package:stellar_anchor_library/util/prefs.dart';
import 'package:stellar_anchor_library/util/util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AnchorAdmin',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          textTheme: GoogleFonts.ralewayTextTheme()),
      home: AgentHome(),
    );
  }
}

class AgentHome extends StatefulWidget {
  AgentHome({Key key}) : super(key: key);

  @override
  _AgentHomeState createState() => _AgentHomeState();
}

class _AgentHomeState extends State<AgentHome> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  void _checkAuth() async {
    try {
      var agent = await Prefs.getAgent();

      Navigator.pop(context);
      if (agent != null) {
        p('🔥 ...... navigating agent to dashboard .....');
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.scale,
            curve: Curves.easeInOut,
            duration: Duration(seconds: 1),
            child: Dashboard(agent: agent),
          ),
        );
      } else {
        p('🔥 ...... navigating agent to Welcome .....');
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.scale,
            curve: Curves.easeInOut,
            duration: Duration(seconds: 1),
            child: Welcome(null),
          ),
        );
      }
    } catch (e) {
      p('Coughing and sneezing .... 😡 😡 😡 😡 catching Corona ... 😡 😡');
      p(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          title: Text('Anchor Network'),
          backgroundColor: secondaryColor,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Agent',
                style: TextStyle(
                    fontSize: 66,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    p('🍎 🍎 🍎 _MyHomePageState get cached agent ....');
    var isOK = await Auth.checkAuthenticated();
    if (isOK) {
      p('🍎 🍎 🍎 We ARE NOT authenticated ....');
    } else {
      p('😡 😡 😡 We ARE NOT authenticated ....');
    }
    var agent = await Prefs.getAgent();
    if (agent == null) {
      p('🍎 🍎 🍎 We DO NOT have an agent ....');
    } else {
      p('🍎 🍎 🍎 We have an agent .... ${agent.toJson()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agent App Splash'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: Styles.pinkBoldSmall,
            ),
            Text(
              '$_counter',
              style: Styles.blackBoldReallyLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
