import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stellar_anchor_agent/ui/dashboard.dart';
import 'package:stellar_anchor_agent/welcome/welcome.dart';
import 'package:stellar_anchor_library/util/prefs.dart';
import 'package:stellar_anchor_library/util/slide_right.dart';
import 'package:stellar_anchor_library/util/util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anchor Agent',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.ralewayTextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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
    var agent = await Prefs.getAgent();
    p('🔥 ...... Checking agent cache .....');
    if (agent != null) {
      Navigator.push(context, SlideRightRoute(widget: Dashboard(agent: agent)));
    } else {
      Navigator.push(context, SlideRightRoute(widget: Welcome(null)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anchor Network'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Agent',
              style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
