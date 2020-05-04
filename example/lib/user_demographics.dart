import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:research_package_demo_app/survey_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDemographicsPage extends StatefulWidget {
  @override
  _UserDemographicsPageState createState() => _UserDemographicsPageState();
}

class _UserDemographicsPageState extends State<UserDemographicsPage> {
  int age;
  String gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Text(
                    'Please enter your age and gender',
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
                //Divider(thickness: 2),
              ],
            ),
            //Container(height: 50),
            Column(
              children: <Widget>[
                Text(
                  'Age',
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  age == null ? '---' : age.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                FlatButton(
                  color: Colors.lightBlueAccent.withOpacity(0.5),
                  child: Text(
                    'Edit',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        height: MediaQuery.of(context).size.height / 4,
                        child: CupertinoPicker(
                          backgroundColor: Colors.white,
                          itemExtent: 40,
                          children: List.generate(
                            100,
                            (int index) => Center(
                              child: Text(
                                index.toString(),
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          ),
                          onSelectedItemChanged: (int i) {
                            setState(() {
                              age = i;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            //Container(height: 50),
            Column(
              children: <Widget>[
                Text(
                  'Gender',
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  gender ?? '---',
                  style: TextStyle(fontSize: 20),
                ),
                FlatButton(
                  color: Colors.lightBlueAccent.withOpacity(0.5),
                  child: Text(
                    'Edit',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        height: MediaQuery.of(context).size.height / 4,
                        child: CupertinoPicker(
                          backgroundColor: Colors.white,
                          itemExtent: 80,
                          children: <Widget>[
                            Center(
                                child:
                                    Text('', style: TextStyle(fontSize: 28))),
                            Center(
                                child: Text('Male',
                                    style: TextStyle(fontSize: 28))),
                            Center(
                                child: Text('Female',
                                    style: TextStyle(fontSize: 28))),
                          ],
                          onSelectedItemChanged: (int i) {
                            setState(() {
                              gender =
                                  i == 1 ? 'Male' : (i == 2) ? 'Female' : null;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            RaisedButton(
              onPressed: (age == null || gender == null)
                  ? null
                  : () async {
                      SharedPreferences sp =
                          await SharedPreferences.getInstance();
                      sp.setString('gender', gender);
                      sp.setInt('age', age);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => SurveyPage()));
                    },
              color: Colors.blue,
              child: Text('Finished -- Go to survey'),
            )
          ],
        ),
      ),
    );
  }
}
