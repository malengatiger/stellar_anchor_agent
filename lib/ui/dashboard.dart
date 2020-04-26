import 'package:flutter/material.dart';
import 'package:stellar_anchor_agent/ui/round_logo.dart';
import 'package:stellar_anchor_library/models/agent.dart';
import 'package:stellar_anchor_library/models/balances.dart';
import 'package:stellar_anchor_library/util/functions.dart';
import 'package:stellar_anchor_library/util/image_handler/random_image.dart';
import 'package:stellar_anchor_library/util/util.dart';
import 'package:stellar_anchor_library/widgets/avatar.dart';
import 'package:stellar_anchor_library/widgets/balances_scroller.dart';
import 'package:stellar_anchor_library/bloc/agent_bloc.dart';

class Dashboard extends StatefulWidget {
  final Agent agent;

  const Dashboard({Key key, this.agent}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Balances balances;
  @override
  initState() {
    super.initState();
    _getBalances();
  }

  _getBalances() async {
    balances = await agentBloc.getBalances(widget.agent.stellarAccountId);
    p('🧡🧡🧡🧡🧡 Got ourselces some balances: 🧡 $balances');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[100],
          elevation: 0,
          title: Text('Dashboard', style: Styles.whiteSmall),
          bottom: PreferredSize(
              child: Column(
                children: <Widget>[
                  Text(
                      widget.agent == null
                          ? 'No Agent Yet'
                          : widget.agent.personalKYCFields.getFullName(),
                      style: Styles.blackBoldMedium),
                ],
              ),
              preferredSize: Size.fromHeight(40)),
        ),
        backgroundColor: Colors.brown[100],
        body: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: customShadow,
                    color: secondaryColor,
                    shape: BoxShape.circle),
              ),
            ),
            Positioned(
                child: RoundLogo(radius: 40, margin: 8), left: 20, top: 8),
            balances == null
                ? Container()
                : Positioned(
                    left: 20,
                    bottom: 20,
                    child: Container(
                      height: 60,
                      width: 300,
                      decoration: BoxDecoration(
                        boxShadow: customShadow,
                        color: secondaryColor, borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BalancesScroller(
                            direction: Axis.horizontal, balances: balances),
                      ),
                    )),
                    Positioned(right: 40, top: 60, child: RoundAvatar(path: RandomImage.getImagePath(), radius: 140, fromNetwork: false)),
          ],
        ),
      ),
    );
  }
}
