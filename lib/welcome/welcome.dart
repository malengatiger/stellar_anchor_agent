import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stellar_anchor_agent/ui/login.dart';
import 'package:stellar_anchor_agent/welcome/pages.dart';
import 'package:stellar_anchor_library/models/stokvel.dart';
import 'package:stellar_anchor_library/util/functions.dart';

class Welcome extends StatefulWidget {
  final Member member;

  Welcome(this.member);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  var _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
//    final AnchorBloc bloc = Provider.of<AnchorBloc>(context);
    return SafeArea(
      child: WillPopScope(
          onWillPop: () async {
            return Future.value(false);
          },
          child: Scaffold(
            key: _key,
            appBar: AppBar(
              leading: Container(),
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Anchor Network',
                style: TextStyle(fontSize: 16),
              ),
              bottom: widget.member == null
                  ? PreferredSize(
                      preferredSize: Size.fromHeight(40),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              color: Colors.pink,
                              elevation: 8,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.scale,
                                        curve: Curves.easeInOut,
                                        duration: Duration(seconds: 2),
                                        child: Login()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Sign in/up',
                                  style: Styles.whiteSmall,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                          ],
                        ),
                      ),
                    )
                  : PreferredSize(
                      preferredSize: Size.fromHeight(0),
                      child: Container(),
                    ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    _navigateOut(context);
                  },
                ),
              ],
            ),
            body: PageView(
              children: <Widget>[
                PageOne(widget.member),
                PageTwo(widget.member),
                PageThree(widget.member),
                PageFour(widget.member),
                PageFive(widget.member)
              ],
            ),
          )),
    );
  }

  void _navigateOut(BuildContext context) async {
    Navigator.pop(context);
//    if (widget.member == null) {
//      Navigator.push(context, SlideRightRoute(widget: SignUp()));
//    } else {
//      Navigator.push(context, SlideRightRoute(widget: Dashboard()));
//    }
  }
}
