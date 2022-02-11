import 'dart:async';

import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  StreamController _controller = StreamController();
   int _counter = 60;

   void startTimer() async{
     Timer.periodic(Duration (seconds: 1) ,(timer){
       _counter--;

       _controller.sink.add(_counter);

       if(_counter<=0){
         timer.cancel();
         _controller.close();
       }
      });
   }
   @override
   void dispose(){
     super.dispose();
     _controller.close();
   }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
            initialData: _counter,
            stream: _controller.stream,
            builder: (context,snapshot){
              return Text('${snapshot.data}');
            },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed:(){
              startTimer();
            }, child: Text('Start count down'))
        ],
        ),
      ),
      
    );
  }
}