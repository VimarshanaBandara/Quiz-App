import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quize/quizscreen.dart';
void main(){
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark
      )
    );

    return Scaffold(
      backgroundColor: Color(0xFF2D046E),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 90.0,),
                Center(
                  child: Image(
                    image: AssetImage('images/img1.png',),

                  ),
                ),
              Text('Quiz',style: TextStyle(color: Colors.white,fontSize: 90.0),),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 40.0,horizontal: 30.0),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                  onPressed: (){
                    
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizScreen()));
                    
                  },
                  child: Text('PLAY',style: TextStyle(color:Colors.white,fontSize: 32.0),),
                  color: Color(0xFFFFBA00),
                ),
              )
            ],
          ),
        ),
      ),


    );
  }
}



