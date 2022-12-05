
import 'package:auth/Chats.dart';
import 'package:auth/index.dart';
import 'package:auth/menu.dart';
import 'package:flutter/material.dart';
class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Menu()));


              },
            ),


            actions: [
              IconButton(
                icon: Icon(Icons.notifications_none),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              )
            ],
            //backgroundColor: Colors.purple,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal.shade700, Colors.teal.shade700],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
            ),
            bottom: TabBar(
              //isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 6,

              tabs: [
                (IconButton(icon:  const Icon(Icons.home), onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Index()));

                },)),
                (IconButton(icon:  const Icon(Icons.article), onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Chats()));

                },)),
              ],
            ),
            elevation: 20,
            titleSpacing: 20,
          ),

          body: TabBarView(
            children: [ ElevatedButton(
              onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>Index()));

        }, child: null,),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>Chats()));

            }, child: null,),
              
              //buildPage(),
              //buildPage('Formation Page'),
              //buildPage('Evénements Page'),
             // buildPage('Annonces Page'),
              //buildPage('Forum Page'),
            ],
          ),
        ),
      );

  Widget buildPage(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 28),
        ),
      );
}