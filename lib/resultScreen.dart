import 'package:flutter/material.dart';
import 'package:quize/quizscreen.dart';
class ResultScreen extends StatelessWidget {
  final int score;

  ResultScreen({this.score});

  @override
  Widget build(BuildContext context) {
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
              Text('Result',style: TextStyle(color: Colors.white,fontSize: 35.0),),
              Text('$score/10',style: TextStyle(color: Color(0xFFFFBA00),fontSize: 60.0),),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 40.0,horizontal: 30.0),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                  onPressed: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizScreen()));

                  },
                  child: Text('RESTART',style: TextStyle(color:Colors.white,fontSize: 32.0),),
                  color: Color(0xFFFFBA00),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                  onPressed: (){

                   Navigator.pop(context);

                  },
                  child: Text('EXIT',style: TextStyle(color:Colors.white,fontSize: 32.0),),
                  color: Color(0xFF511AA8),
                ),
              )
            ],
          ),
        ),
      ),




    );
  }
}
