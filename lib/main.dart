import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
      home: QuotesPage(),
    ),
  );
}


class QuotesPage extends StatefulWidget {
  @override
  _QuotesPageState createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
    String quotes='Be the change that you wish to see in the world.';
    String author='Mahatma Gandhi';
    bool loading=false;
    Future<Map> fetchquote() async {
      isloading();
      Response response = await get('https://favqs.com/api/qotd');
      loading=false;
      return jsonDecode(response.body);
    }

    isloading(){
    loading=true;
      setState(() {
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('${quotes}',
                style: TextStyle(fontFamily: 'Muli', fontSize: 25),),
              SizedBox(height: 10,),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text('${author}', style: TextStyle(
                    color: Colors.red, fontStyle: FontStyle.italic,),),),
              SizedBox(height: 15,),
              Align(
                alignment: Alignment.topLeft,
                child: FloatingActionButton(
                  onPressed: () async{
                          Map getquoteMap = await fetchquote();
                          quotes=getquoteMap['quote']['body'];
                          author=getquoteMap['quote']['author'];
                          setState((){
                          });
                        },
                  backgroundColor: Colors.white,
                  elevation: 10,
                 child:loading?SpinKitCircle(
                   color: Colors.red,
                   size: 50.0,
                 ):Icon(Icons.arrow_forward,color: Colors.red,),
              ),
              ),
            ],
          ),
        ),
      );
    }
  }


