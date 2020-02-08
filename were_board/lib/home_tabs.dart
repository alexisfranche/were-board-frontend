import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:were_board/login.dart';

import 'view_profile.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return GFTabs(
          unselectedLabelColor: Colors.black45,
          tabBarHeight: 85.0,
          tabBarColor: Colors.lightBlueAccent,
          initialIndex: 0,
          length: 5,
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
                icon: Icon(Icons.power),
                child: Text(
                  "Logout",
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

               //replace Icon widgets by the appropriate widgets (pages) that need to be displayed.
               Container(child: Icon(Icons.casino), color: Colors.white,),
               //ViewProfile(), // Un-comment to test view profile page
               Container(child: Icon(Icons.event_available), color: Colors.white,),
               Container(child: ViewProfile()),
               Container(child: LoginScreen(), ),
               Container(child: Icon(Icons.settings), color: Colors.white,),
             ],
            ),
        );
    }
}