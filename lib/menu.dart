import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
    return Drawer(
      
      child: ListView(
        
      
        // Remove padding
        padding: EdgeInsets.zero,
        
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Rihab Mechergui'),
            accountEmail: Text('mecherguirihab4@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'user.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.teal.shade700,
              
            ),
          ),
          Divider(),
           ListTile(
            leading: Icon(Icons.description),
            title: Text('Profile'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Request'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => null,
          ),
       
          Divider(),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}