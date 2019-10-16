import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart';
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(
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
    Future<Map> fetchquote() async {
      Response response = await get('https://favqs.com/api/qotd');
      return jsonDecode(response.body);
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
              SizedBox(height: 10,),
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
                  child: Icon(Icons.arrow_forward, color: Colors.red,),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }