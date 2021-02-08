
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';


class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  String cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/seashells.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  onChanged: (nv){
                    cityName=nv.toLowerCase();
                    
                  },
                  style: TextStyle(color:Colors.black,),
                  decoration: kInputDecoration,
                ),
              ),
              FlatButton(
                onPressed: () async{
                  Navigator.pop(context, cityName);
                  
    
                  // Navigator.push(context, MaterialPageRoute(builder:(ctx)=>LocationScreen(weather),),);
                },
                child: Text(
                  'Get Weather',
                  style: TextStyle(
                      fontSize: 35.0,
                      fontFamily: 'Spartan MB',
                      fontWeight: FontWeight.w900,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(4, 4),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
