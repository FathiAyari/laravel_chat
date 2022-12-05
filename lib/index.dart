
import 'package:auth/Chats.dart';
import 'package:auth/menu.dart';
import 'package:flutter/material.dart';
import 'package:auth/main.dart';




class Index extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(
      ),
      appBar: AppBar(title: Text('Welcome'),
      
       backgroundColor: primaryColor,
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
      ), 
   body:SingleChildScrollView(
     child: Center( 
       child: Column( 
         children: [
           SizedBox(width:20,height: 20,),

    
     
         ],
       ),
       
     ),
   ),

   
   
   );
                        
      
  }}