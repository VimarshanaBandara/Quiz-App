import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quize/resultScreen.dart';

import 'QuizHelper.dart';
import 'package:http/http.dart'as http;


class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  String apiURL = "https://opentdb.com/api.php?amount=10&category=18&type=multiple";

  QuizHelper quizHelper;
  int currentQuestion = 0;
  int totalSeconds = 30;
  int elapsedSeconds = 0;

  Timer timer;
  int score = 0;


  @override
  void initState() {
    fetchAllQuiz();
    super.initState();
  }

  fetchAllQuiz()async
  {
      var response = await http.get(apiURL);
      var body = response.body;
      var json = jsonDecode(body);


      setState(() {
        quizHelper = QuizHelper.fromJson(json);
        quizHelper.results[currentQuestion].incorrectAnswers.add(
          quizHelper.results[currentQuestion].correctAnswer
        );
        quizHelper.results[currentQuestion].incorrectAnswers.shuffle();
        initTimer();
      });


  }

  initTimer(){
      timer = Timer.periodic(
        Duration(seconds: 1),
          (t){
            if(t.tick==totalSeconds)
              {
                print('Time Completed');
                t.cancel();
                changeQuestion();
              }else
                {
                  setState(() {
                    elapsedSeconds = t.tick;
                  });
                }
          }
      );
  }

  @override
  void dispose(){
    timer.cancel();
    super.dispose();
  }


  checkAnswer(answer)
  {
    String correctAnswer = quizHelper.results[currentQuestion].correctAnswer;
    if(correctAnswer == answer)
    {
       score += 1;
    }

    else
      {
        print('Wrong');
      }
     changeQuestion();
  }
 void changeQuestion(){
  timer.cancel();

  if(currentQuestion == quizHelper.results.length - 1)
    {
       print('Quiz completed');
       print('Score : $score');

       Navigator.pushReplacement(
         context,
         MaterialPageRoute(
           builder: (context) => ResultScreen(score: score,),
         )
       );

    } else{

     setState(() {
       currentQuestion += 1;

     });

     quizHelper.results[currentQuestion].incorrectAnswers.add(
         quizHelper.results[currentQuestion].correctAnswer
     );
     quizHelper.results[currentQuestion].incorrectAnswers.shuffle();
     initTimer();
  }

}


  @override
  Widget build(BuildContext context) {
    if(quizHelper != null)
    {
      return Scaffold(
        backgroundColor: Color(0xFF2D046E),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 60.0 , horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        image: AssetImage('images/img1.png'),
                        width: 70.0,
                        height: 70.0,
                      ),
                      Text('$elapsedSeconds s',style: TextStyle(color: Colors.white,fontSize: 18.0),)
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('Q. ${quizHelper.results[currentQuestion].question}',style: TextStyle(color: Colors.white,fontSize: 35.0),textAlign: TextAlign.center,),
                ),

                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 40.0,
                  ),
                  child: Column(
                    children: quizHelper.results[currentQuestion].incorrectAnswers.map((option){

                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: (){
                            checkAnswer(option);

                          },
                          child: Text(option,style: TextStyle(fontSize: 18.0),),
                          color: Color(0xFF511AA8),
                          colorBrightness: Brightness.dark,
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                        ),
                      );

                    }).toList(),
                  ),
                )

              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Color(0xFF2D046E),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }


  }
}
