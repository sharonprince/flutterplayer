import 'package:flutter/material.dart';
import 'package:flutterplayer/Screens/Login/Components/mybutton.dart';
import 'package:flutterplayer/Screens/Login/Components/mytextfield.dart';
import 'package:flutterplayer/Screens/splashScreen/splashScreen.dart';
import 'package:flutterplayer/Widgets/config.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final usernameController = TextEditingController();

  // sign user in method
  void signUserIn() async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', usernameController.text);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: ((context) => splashscreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
        const SizedBox(height: 150),
             // logo
              const Icon(
                Icons.lock,
                size: 100,
                color: kWhite,
              ),
                //  Container(child: Image.asset("assets/images/transperentlogo.png",)),

                                  const SizedBox(height: 100),
      
             Expanded(child: SingleChildScrollView(
               child: Container(
                width: double.infinity,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Column( 
                        children: [ 
                          const SizedBox(height: 50),
                          Text(
                      'Welcome back you\'ve been missed!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                                    ),
                            
                                    const SizedBox(height: 40),
                      MyTextField(
                      controller: usernameController,
                      hintText: 'Enter your Name',
                      obscureText: false,
                                    ),
                            
                                    const SizedBox(height: 10),
                      
                                    const SizedBox(height: 10),
                            
                                
                            
                                    const SizedBox(height: 25),
                            
                                    // sign in button
                                    MyButton(
                      onTap: signUserIn,
                                    ),
                            
                                    const SizedBox(height: 50),
                            
                                   
                            
                                    const SizedBox(height: 150),
                             Text(
                      'Calvary Karunya Digital Gospel',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                                    ),
                                   
                            
                                    const SizedBox(height:30),
                               
                            
                      
                      
                        ],
                      ),
                    ),
                  ),
               ),
             )),
      
              // welcome back, you've been missed!
              // Text(
              //   'Welcome back you\'ve been missed!',
              //   style: TextStyle(
              //     color: Colors.grey[700],
              //     fontSize: 16,
              //   ),
              // ),
      
              // const SizedBox(height: 25),
      
              // username textfield
              // MyTextField(
              //   controller: usernameController,
              //   hintText: 'Enter your Name',
              //   obscureText: false,
              // ),
      
              // const SizedBox(height: 10),
      
      
              // const SizedBox(height: 10),
      
          
      
              // const SizedBox(height: 25),
      
              // // sign in button
              // MyButton(
              //   onTap: signUserIn,
              // ),
      
              // const SizedBox(height: 50),
      
             
      
              // const SizedBox(height: 50),
      
             
      
              // const SizedBox(height: 50),
      
             
            ],
          ),
        ),
      ),
    );
  }
}