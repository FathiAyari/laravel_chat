import 'package:auth/navbar.dart';
import 'package:auth/registerPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  get width => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              Image.asset(
                "assets/login.png",
                width: 100,
                height: 100,
              ),
              Text(
                "Login",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Colors.grey[900]),
              ),
              SizedBox(height: 10),
              Text(
                "log in to your existant account of ",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.grey),
              ),
              SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.only(right: 20, left: 20),
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 20, bottom: 20),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Icon(Icons.email),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                        hintText: "Email",
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                        )),
                  )),
              SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.only(right: 20, left: 20),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 20, bottom: 20),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Icon(Icons.remove_red_eye),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                        hintText: "password",
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                        )),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 30, 0),
                    child: Text(
                      "Forget Pasword ?",
                      style: TextStyle(
                          color: Color.fromRGBO(27, 27, 27, 0.5),
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Navbar()));

                },
               
                child: Text(
                  "LOG IN",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),),SizedBox(width: 10,),
              
              SizedBox(
                height: 20,
              ),
              Text(
                "Or connect using ",
                style: TextStyle(color: Colors.grey[900], fontSize: 12),
              ),
          
                ],
              )
            
          ),
        ),
     ) ;
  
  }
}
