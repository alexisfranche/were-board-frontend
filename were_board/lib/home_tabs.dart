import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';

import 'view_profile.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return GFTabs(
          unselectedLabelColor: Colors.black45,
          tabBarHeight: 85.0,
          tabBarColor: Colors.lightBlueAccent,
          initialIndex: 0,
          length: 4,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.casino),
              child: Text(
                "Dashboard",
              ),
             ),
             Tab(
               icon: Icon(Icons.event_available),
               child: Text(
                 "Manage Events",
               ),
              ),
              Tab(
                icon: Icon(Icons.person),
                child: Text(
                  "Profile",
                ),
              ),
              Tab(
                icon: Icon(Icons.settings),
                child: Text(
                  "Settings",
                ),
              ),
           ],
           tabBarView: GFTabBarView(
             children: <Widget>[

               //TODO: replace Icon widgets by the appropriate widgets (pages) that need to be displayed.
               Container(child: Icon(Icons.casino), color: Colors.white,),
               //ViewProfile(), // Un-comment to test view profile page
               Container(child: Icon(Icons.event_available), color: Colors.white,),
               Container(child: Icon(Icons.person), color: Colors.white,),
               Container(child: Icon(Icons.settings), color: Colors.white,),
             ],
            ),
        );
    }
}