import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';

import 'view_profile.dart';
import 'my_profile.dart';

class HomePage extends StatelessWidget{
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
  Widget build(BuildContext context){
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: myTabs,
          ),
          title: Text("Home"),
        ),
        body: TabBarView(
          children: <Widget>[

            //replace Icon widgets by the appropriate widgets (pages) that need to be displayed.
            Container(child: Icon(Icons.casino), color: Colors.white,),
            //ViewProfile(), // Un-comment to test view profile page
            //MyProfile(), // Un-comment to test my profile page
            Container(child: Icon(Icons.event_available), color: Colors.white,),
            Container(child: ViewProfile(email: this.email)),
            Container(child: MyProfile(email: this.email)),
            Container(child: Icon(Icons.settings), color: Colors.white,),
          ],
        ),

    ));
     return GFTabs(
          unselectedLabelColor: Colors.black45,
          tabBarHeight: 85.0,
          tabBarColor: Colors.lightBlueAccent,
          initialIndex: 0,
          length: 5,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.casino),
              /* child: Text(
                "Dashboard",
              ), */
             ),
             Tab(
               icon: Icon(Icons.event_available),
               /* child: Text(
                 "Manage Events",
               ), */
              ),
              Tab(
                icon: Icon(Icons.person),
                /* child: Text(
                  "Search Profile",
                ), */
              ),
              Tab(
                icon: Icon(Icons.person_outline),
                /* child: Text(
                  "My Profile"), */
                  ),
              Tab(
                icon: Icon(Icons.settings),
               /* child: Text(
                  "Settings",
                ), */
              ),
           ],
           tabBarView: GFTabBarView(
             children: <Widget>[

               //replace Icon widgets by the appropriate widgets (pages) that need to be displayed.
               Container(child: Icon(Icons.casino), color: Colors.white,),
               //ViewProfile(), // Un-comment to test view profile page
               //MyProfile(), // Un-comment to test my profile page
               Container(child: Icon(Icons.event_available), color: Colors.white,),
               Container(child: ViewProfile(email: this.email)),
               Container(child: MyProfile(email: this.email)),
               Container(child: Icon(Icons.settings), color: Colors.white,),
             ],
            ),
        );
    }
}