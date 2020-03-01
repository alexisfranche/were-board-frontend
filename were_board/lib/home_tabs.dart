import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:flutter/services.dart';
import 'view_profile.dart';
import 'my_profile.dart';
import 'apply_to_event.dart';
import 'view_all_events.dart';
import 'view_event.dart';

class HomePage extends StatelessWidget {
  final String email;

  HomePage({this.email});

  final List<Tab> myTabs = <Tab>[
    Tab(icon: Icon(Icons.casino)),
    Tab(icon: Icon(Icons.event_available)),
    Tab(icon: Icon(Icons.person)),
    Tab(icon: Icon(Icons.person_outline)),
    Tab(icon: Icon(Icons.settings)),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: myTabs,
            ),
            title: Text("Home"),
          ),
          body: TabBarView(
            children: <Widget>[
              //replace Icon widgets by the appropriate widgets (pages) that need to be displayed.
              Container(
                child: Icon(Icons.casino),
                color: Colors.white,
              ),
              //ViewProfile(), // Un-comment to test view profile page
              //MyProfile(), // Un-comment to test my profile page
              Container(
                child: ViewAllEvents(),
                color: Colors.white,
              ),
              Container(child: ViewProfile(email: this.email)),
              Container(child: MyProfile(email: this.email)),
              Container(
                child: Icon(Icons.settings),
                color: Colors.white,
              ),
            ],
          ),
        ));
  }
}
